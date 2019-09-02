<?php
namespace App\Http\Models;

class WebsocketOnClose {
	public static function index($ws, $fd)
    {
        dump('Server: close fd ' . $fd . ' success');
        dump('Service: del u_id is '. $u_id);

        $u_id = CoRedis::hget(REDIS_KEYS['fds'], 'fd_' . $fd);
        
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

            $res = CoRedis::pipeline(function($CoRedis) use ($u_id, $hdel) {
                CoRedis::srem(REDIS_KEYS['ranking'], $u_id);

                foreach ($hdel as $key => $value) {
                    CoRedis::hdel($value['key'], $value['field']);
                }
            });

            //退出房间号
            $room_id = CoRedis::hget(REDIS_KEYS['rooms'], $u_id);
            if ($room_id) {
                $room = CoRedis::hgetall($room_id);

                if (is_array($room) && !empty($room)) {
                    dump('Service: del room' . $room);
                    $to_u_id = $room['left_u_id'] == $u_id ? $room['right_u_id'] : $room['left_u_id'];
                    $to_fd_id = CoRedis::hget(REDIS_KEYS['u_ids'], 'u_id_' . $to_u_id);

                    self::push($to_fd_id, '您的对手掉线或者跑掉啦~', ResponseCode::OpponentAbstained);

                    //删除房间信息
                    CoRedis::pipeline(function($CoRedis) use ($room_id, $room) {
                        CoRedis::del($room_id);

                        CoRedis::hdel(REDIS_KEYS['rooms'], $room['left_u_id']);
                        CoRedis::hdel(REDIS_KEYS['rooms'], $room['right_u_id']);
                    });
                }
            }
        }
    }
}