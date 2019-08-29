<?php
namespace App\Http\Models;

use Illuminate\Support\Facades\Redis;

class WebsocketOnClose {
	public static function close($ws, $fd)
    {
        dump('server:close success');
        dump('close fd is ' . $fd);

        $u_id = Redis::command('hget', [REDIS_KEYS['fds'], 'fd_' . $fd]);
        dump('del u_id is ', $u_id);
        if ($u_id > 0) {
            $hdel = [
                [
                    'key'   => REDIS_KEYS['fds'],
                    'field' => 'fd_' . $fd
                ],
                [
                    'key'   => REDIS_KEYS['u_ids'],
                    'field' => 'u_id_' . $u_id
                ]
            ];
            $res = Redis::pipeline(function($pipe) use ($u_id, $hdel) {
                //删除排位
                $pipe->srem(REDIS_KEYS['ranking'], $u_id);

                //删除关联数据
                foreach ($hdel as $key => $value) {
                    $pipe->hdel($value['key'], $value['field']);
                }   
            });

            //退出房间号
            $room_id = Redis::hget(REDIS_KEYS['rooms'], $u_id);
            if ($room_id) {
                $room = Redis::hgetall($room_id);

                if (is_array($room) && !empty($room)) {
                    dump('del room', $room);
                    $to_u_id = $room['left_u_id'] == $u_id ? $room['right_u_id'] : $room['left_u_id'];
                    $to_fd_id = Redis::command('hget', [REDIS_KEYS['u_ids'], 'u_id_' . $to_u_id]);

                    $resp = Response::json('您的对手掉线或者跑掉啦~', 202);
                    $this->push($to_fd_id, $resp);

                    //删除房间信息
                    Redis::pipeline(function($pipe) use ($room_id, $room) {
                        $pipe->del($room_id);
                        $pipe->hdel(REDIS_KEYS['rooms'], $room['left_u_id'], $room['right_u_id']);
                    });
                }
            }
        }
    }
}