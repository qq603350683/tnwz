<?php
namespace App\Http\Models;

class WebsocketOnMessage extends WebsocketBase {
	public static function message($ws, $request)
	{
        $GLOBALS['ws'] = $ws;
        
        $fd = $request->fd;
        $data = json_decode($request->data, true);
        dump('server:message fd is ' . $fd);
        dump('server:message data is ' . $request->data);
        dump('server:message opcode is ' . $request->opcode);

        if (!$data || !is_array($data)) {
            self::push($fd, '我不知道你在传什么东西~', ResponseCode::Error);
            return;
        }

        $case = $data['case'] ?? '';
        $data = $data['data'] ?? [];

        $u_id = CoRedis::hget(REDIS_KEYS['fds'], 'fd_' . $fd);
        if (!$u_id) {
            self::push($fd, '系统出现了一点错误，请重新连接~', ResponseCode::SystemAbnormal);
            self::close($fd);
            return;
        }

        $GLOBALS['fd'] = $fd;
        $GLOBALS['u_id'] = $u_id;

        switch ($case) {
            case 'close':
                //关系连接
                self::close($fd);
                break;
            case 'heartbeat':
                //心跳包
                break;
            case 'join_ranking':
                //加入PK排队队列
                $res = Ranking::join($u_id);
                dump('Service: u_id: ' . $u_id . ' 加入排位排队成功');
                break;
            case 'quit_ranking':
                //退出PK排队队列
                $res = Ranking::quit($u_id);
                dump('Service: u_id: ' . $u_id . ' 退出排位排队' . ($res == true ? '成功' : '失败'));
                break;
            case 'item_select':
                if (!isset($data['item'])) {
                    self::push($fd, '您没有选择答案噢', ResponseCode::Error);
                    return;
                }

                if (!in_array($data['item'], ['a', 'b', 'c', 'd'])) {
                    self::push($fd, '请选择在合理范围内的选项~', ResponseCode::Error);
                    return;
                }

                //房号id
                $room_id = CoRedis::hget(REDIS_KEYS['rooms'], $u_id);
                if (!$room_id) {
                    self::push($fd, '您木有在PK噢~', ResponseCode::Error);
                    return;
                }

                //房号详情
                $room = CoRedis::hgetall($room_id);
                dump('当前题目ID是: ' . $room['current_topic_id']);
                if (!$room) {
                    self::push($fd, '您木有在PK噢~', ResponseCode::Error);
                    return;
                }

                //回答题目顺序不正确
                if ($room['current_topic_id'] != $data['current_num']) {
                    self::push($fd, '当前题目进度为第' . ($room['current_topic_id']) . '题', ResponseCode::Error);
                    return;
                }

                //双方都超时回答处理，解散当前PK
                $time_difference = time() - $room['last_answer_time'];

                //判断时间是否正确
                $time_is_right = false;
                if ($room['current_topic_id'] == 1) {
                    //这里减去3秒是前段动画时间
                    if ($time_difference - 3 <= ANSWER_COUNTDOWN)
                        $time_is_right = true;

                    dump('1答题花费时间---' . ($time_difference - 3));
                } else {
                    if ($time_difference <= ANSWER_COUNTDOWN)
                        $time_is_right = true;

                    dump('2答题花费时间---' . $time_difference);
                }

                

                if ($time_is_right == false) {
                    CoRedis::pipeline(function($CoReids) use ($room_id, $room) {
                        CoRedis::del($room_id);
                        CoRedis::hdel(REDIS_KEYS['rooms'], $room['left_u_id'], $room['right_u_id']);
                    });

                    self::push($room['left_fd'], '当前题目进度异常', ResponseCode::ProgressAbnormal);
                    self::push($room['right_fd'], '当前题目进度异常', ResponseCode::ProgressAbnormal);
                    return;
                }

                $true_answer = $room['answer_' . $data['current_num']];
                $player_select = $data['item'];
                $is_answer_true = $player_select == $true_answer ? true : false;

                CoRedis::pipeline(function($CoRedis) use ($u_id, $is_answer_true, $true_answer, $player_select, $room_id, $room) {
                    $time = time();

                    $update = [
                        'current_topic_id' => $room['current_topic_id'] + 1,
                        'last_answer_time' => $time
                    ];

                    $res = ['true_answer' => $true_answer, 'player_select' => $player_select];

                    if ($u_id == $room['left_u_id'] && $is_answer_true == true) {
                        $update['left_answer']  = $room['left_answer'] . 'T';
                        $update['right_answer'] = $room['right_answer'] . 'F';

                        CoRedis::hmset($room_id, $update);

                        self::push($room['left_fd'], '回答正确', ResponseCode::IAmRight, $res);
                        self::push($room['right_fd'], '对方回答正确', ResponseCode::OpponentRight, $res);
                    } else if ($u_id == $room['left_u_id'] && $is_answer_true == false) {
                        $update['left_answer']  = $room['left_answer'] . 'F';
                        $update['right_answer'] = $room['right_answer'] . 'T';

                        CoRedis::hmset($room_id, $update);

                        self::push($room['left_fd'], '回答错误', ResponseCode::IAmWrong, $res);
                        self::push($room['right_fd'], '对方回答错误', ResponseCode::OpponentWrong, $res);
                    } else if ($u_id == $room['right_u_id'] && $is_answer_true == true) {
                        $update['left_answer']  = $room['left_answer'] . 'F';
                        $update['right_answer'] = $room['right_answer'] . 'T';

                        CoRedis::hmset($room_id, $update);

                        self::push($room['left_fd'], '对方回答正确', ResponseCode::OpponentRight, $res);
                        self::push($room['right_fd'], '回答正确', ResponseCode::IAmRight, $res);
                    } else if ($u_id == $room['right_u_id'] && $is_answer_true == false) {
                        $update['left_answer']  = $room['left_answer'] . 'T';
                        $update['right_answer'] = $room['right_answer'] . 'F';

                        CoRedis::hmset($room_id, $update);

                        self::push($room['left_fd'], '对方回答错误', ResponseCode::OpponentWrong, $res);
                        self::push($room['right_fd'], '回答错误', ResponseCode::IAmWrong, $res);
                    } else {
                        CoRedis::del($room_id);
                        CoRedis::hdel(REDIS_KEYS['rooms'], $room['left_u_id'], $room['right_u_id']);

                        self::push($room['left_fd'], '还有这种情况？？？', ResponseCode::GameDataBbnormal);
                        self::push($room['right_fd'], '还有这种情况？？？', ResponseCode::GameDataBbnormal);
                        return;
                    }
                });

                $room = CoRedis::hgetall($room_id);

                Game::isGameEnding($room_id, $room);
                break;
            case 'timeout':
                //回答超时
                $time = time();

                //房号id
                $room_id = CoRedis::hget(REDIS_KEYS['rooms'], $u_id);
                if (!$room_id) {
                    self::push($fd, '您木有在PK噢~', ResponseCode::Error);
                    return;
                }

                $lock_name = PREFIX . $room_id . '_room_lock';
                $room_lock = CoRedis::setnx($lock_name, $time);
                if (!$room_lock) {
                    dump('数据发送重复，已忽略处理');
                    return;
                }


                list($room, $redisRes[0]) = CoRedis::pipeline(function($CoRedis) use ($room_id, $lock_name) {
                    CoRedis::hgetall($room_id);
                    CoRedis::expire($lock_name, ANSWER_COUNTDOWN - 2);
                });
                $room = CoRedis::format($room);

                dump('redis 数据返回', $room, $redisRes);

                //房号详情
                if (!$room) {
                    self::push($fd, '您木有在PK噢~', ResponseCode::Error);
                    return;
                }

                
                $time_difference = $time - $room['last_answer_time'] - ANSWER_COUNTDOWN;
                if ($room['current_topic_id'] == 1) {
                    $time_difference -= 3;
                }

                if ($time_difference > 2 || $time_difference < -2) {
                    //兼容网络传输时间前后1秒
                    dump('倒计时好像还没结束吧？~', $time_difference, $time, $room['current_topic_id']);
                    return;
                }

                $redisRes = CoRedis::hmset($room_id, [
                    'current_topic_id' => $room['current_topic_id'] + 1,
                    'last_answer_time' => $time,
                    'left_answer'      => $room['left_answer'] . 'F',
                    'right_answer'     => $room['right_answer'] . 'F'
                ]);
                dump('res is ', $redisRes);

                self::push($room['left_fd'], '超时回答了哦~', ResponseCode::AnswerTimeOut);
                self::push($room['right_fd'], '超时回答了哦~', ResponseCode::AnswerTimeOut);
                
                $room['left_answer'] .= 'F';
                $room['right_answer'] .= 'F';
                $room['current_topic_id'] += 1;

                Game::isGameEnding($room_id, $room);
                dump('超时处理执行完毕');
                break;
            default:
                $resp = Response::json('事件类型？...', ResponseCode::Error);
                $this->push($fd, $resp);
                return;
                break;
        }
    }
}
