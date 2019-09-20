<?php
namespace App\Http\Models;

class WebsocketOnWorkerStart extends WebsocketBase {
	public static function index($ws, $worker_id)
	{
        $GLOBALS['ws'] = $ws;

        switch ($worker_id) {
            case 0:
                //2秒一次检测所有队列是否有队友
                swoole_timer_tick(2000, function() use ($ws, $worker_id) {
                    $len = Ranking::len();

                    dump('当前队列排队人数：' . $len . '人');

                    if ($len < 2)
                        return;

                    $u_ids = Ranking::random(2);

                    $left_u_id = $u_ids[0];
                    $right_u_id = $u_ids[1];

                    list($left_fd, $right_fd) = CoRedis::hmget(REDIS_KEYS['u_ids'], 'u_id_' . $left_u_id, 'u_id_' . $right_u_id);

                    if (!$left_fd || !$right_fd) {
                        Ranking::joins($u_ids);
                        dump('这里未完成~');
                        return;
                    }

                    //生成房间信息
                    $flags = true;
                    do {
                        $room_id = PREFIX . mt_rand(1000, 9999);
                        $flags = CoRedis::exists($room_id);
                    } while($flags);

                    $topics = Topics::random(3);
                    dump('随机房间号 ' . $room_id);
                    CoRedis::pipeline(function($CoRedis) use ($room_id, $left_u_id, $left_fd, $right_u_id, $right_fd, $topics) {
                        $time = time();

                        //插入房间信息
                        $params = [
                            $left_u_id  => $room_id,
                            $right_u_id => $room_id
                        ];
                        CoRedis::hmset(REDIS_KEYS['rooms'], $params);

                        $count = count($topics['questions']);
                        $params = [
                            'left_u_id'        => $left_u_id, 
                            'left_fd'          => $left_fd, 
                            'left_answer'      => 'F', 
                            'right_fd'         => $right_fd, 
                            'right_u_id'       => $right_u_id, 
                            'right_answer'     => 'F', 
                            'start_time'       => $time, 
                            'last_answer_time' => $time, 
                            'current_topic_id' => 1, 
                            'last_topic_id'    => $count
                        ];

                        for ($i=0; $i < $count; $i++) {
                            $_i = $i + 1;

                            $params['question_' . $_i] = $topics['questions']['question_' . $i];
                            $params['answer_' . $_i]   = $topics['answers']['answer_' . $i];
                        }
                        CoRedis::hmset($room_id, $params);
                        // call_user_func_array([$pipe, 'hset'], $params);
                    });

                    $user = Users::info($left_u_id);
                    self::push($right_fd, '匹配到对手啦~', 201, ['user' => $user, 'is_room_creator' => 0, 'topics' => $topics['topics']]);

                    $user = Users::info($right_u_id);
                    self::push($left_fd, '匹配到对手啦~', 201, ['user' => $user, 'is_room_creator' => 1, 'topics' => $topics['topics']]);
                });
                break;
            case 1:
                break;
            default:
                break;
        }
    }
}
