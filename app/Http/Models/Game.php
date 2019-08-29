<?php
namespace App\Http\Models;

use App\Exceptions\ApiException;

use Illuminate\Support\Facades\Redis;

class Game
{
	/**
	 * 计算游戏结果
	 *
	 *
	 */
	public static function isGameEnding($room_id, $room):array
	{
		if (!is_array($room) || empty($room))
			return [];

		if ($room['left_answer'] == '' || $room['right_answer'] == '')
			return [];


        $left_score  = array_count_values(str_split($room['left_answer']));
        $left_score  = $left_score['T'] ?? 0;
        $right_score = array_count_values(str_split($room['right_answer']));
        $right_score = $right_score['T'] ?? 0;

        $is_left_victory = $left_score / $room['last_topic_id'];
        $is_right_victory = $right_score / $room['last_topic_id'];
        dump('左右双方得分比: ' . $is_left_victory . '|' . $is_right_victory);

        if ((($room['current_topic_id'] - 1) == $room['last_topic_id']) || $is_left_victory > 0.5 || $is_right_victory > 0.5) {
            if ($is_left_victory > 0.5) {
                dump('左边胜利 left success' . $is_left_victory . '|' . $room['left_u_id']);
            } else if ($is_right_victory > 0.5) {
                dump('右边胜利 left success' . $is_right_victory . '|' . $room['right_u_id']);
            } else {
                dump('平手 falt');
            }

            //全部题目回答完毕

            $res = $left_score <=> $right_score;
            dump('比赛结果是:' . $res);
            $config = AdminsConfigs::getConfig();

            if ($res == 1) {
                //left 胜利
                $victory_u_id = $room['left_u_id'];
                $result = [
                    $room['left_u_id']  => [
                        'gold' => $config['victory_gold'],
                        'exp'  => $config['victory_exp']
                    ],
                    $room['right_u_id'] => [
                        'gold' => $config['defeat_gold'],
                        'exp'  => $config['defeat_exp']
                    ]
                ];
            } else if ($res == 0) {
                //平手
                $victory_u_id = 0;
                $result = [
                    $room['left_u_id']  => [
                        'gold' => $config['flat_gold'],
                        'exp'  => $config['flat_exp']
                    ],
                    $room['right_u_id'] => [
                        'gold' => $config['flat_gold'],
                        'exp'  => $config['flat_exp']
                    ]
                ];
            } else if ($res == -1) {
                //right 胜利
                $victory_u_id = $room['right_u_id'];
                $result = [
                    $room['left_u_id']  => [
                        'gold' => $config['defeat_gold'],
                        'exp'  => $config['defeat_exp']
                    ],
                    $room['right_u_id'] => [
                        'gold' => $config['victory_gold'],
                        'exp'  => $config['victory_exp']
                    ]
                ];
            } else {
                dump('我也不知道是谁胜利啦~');
            }

            Users::calcResult($victory_u_id, $result);

            //删除房间信息
            Redis::pipeline(function($pipe) use ($room_id, $room) {
                $pipe->del($room_id);
                $pipe->hdel(REDIS_KEYS['rooms'], $room['left_u_id'], $room['right_u_id']);
            });

            WebsocketBase::push($room['left_fd'], '比赛结束获得奖励', ResponseCode::GameEnding, $result[$room['left_u_id']]);
            WebsocketBase::push($room['right_fd'], '比赛结束获得奖励', ResponseCode::GameEnding, $result[$room['right_u_id']]);

            return true;
        }

        return fasle;
	}
}
