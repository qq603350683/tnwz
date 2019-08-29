<?php
namespace App\Http\Models;

class WebsocketOnOpen extends WebsocketBase {
	public static function open($ws, $request)
	{
		$GLOBALS['ws'] = $ws;

		$fd = $request->fd;
        dump('fd 接入 ' . $fd . ' 成功');
        $u_id         = intval($request->get['u_id'] ?? 0);
        $unique_token = $request->get['unique_token'] ?? '';
        dump('u_id: ' . $request->get['u_id'] . ' unique_token: ' . $unique_token);

        if (!$u_id || !$unique_token) {
            self::push($fd, '哎呦，出现了点小错误', ResponseCode::UserAbnormal);
            return;
        }

        $user = Users::info($u_id, ['u_id', 'unique_token']);
        if (empty($user)) {
            self::push($fd, '亲，找不到您当前的用户...', ResponseCode::UserAbnormal);
            return;
        }

        $is_active = AdminsConfigs::isActive();
        if ($is_active != 0) {
            self::push($fd, '活动不在进行中...', $is_active);
            return;
        }

        //保存到redis
        $hset = [
            [
                'key'   => REDIS_KEYS['fds'],
                'field' => 'fd_' . $fd,
                'value' => $u_id
            ],
            [
                'key'   => REDIS_KEYS['u_ids'],
                'field' => 'u_id_' . $u_id,
                'value' => $fd
            ]
        ];

        CoRedis::pipeline(function($CoRedis) use ($hset) {
            foreach ($hset as $key => $value) {
                CoRedis::hset($value['key'], $value['field'], $value['value']);
            }
        });

        self::push($fd, '连接成功', ResponseCode::Success);
	}
}
