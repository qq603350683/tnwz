<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

use Illuminate\Support\Facades\Redis;

use App\Http\Models\{
    Game,
    Users,
    Topics,
    Ranking,
    CoRedis,
    Response,
    ResponseCode,
    AdminsConfigs,
    WebsocketOnOpen,
    WebsocketOnClose,
    WebsocketOnMessage
};

class Tnwz extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'tnwz';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';


    protected $ws;
    // protected $redis;
    // protected $prefix = 'tnwz_';
    // protected $answer_countdown = 4;



    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        define('PREFIX', 'tnwz_');
        define('ANSWER_COUNTDOWN', 4);

        define('REDIS_CONFIG', [
            'host' => '127.0.0.1',
            'port' => 6379
        ]);

        define('REDIS_KEYS', [
            'fds'     => PREFIX . 'fd',      //u_id -> fd
            'u_ids'   => PREFIX . 'u_id',    //fd -> u_id
            'ranking' => PREFIX . 'ranking', //排队队列
            'rooms'   => PREFIX . 'room'     //房间号,
        ]);
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $this->ws = new \Swoole\WebSocket\Server('0.0.0.0', 9501);
        //设置异步任务的工作进程数量
        $this->ws->set([
            // 'ssl_cert_file' => '/phpstudy/server/nginx/conf/cert/214487213090933.pem',
            // 'ssl_key_file' => '/phpstudy/server/nginx/conf/cert/214487213090933.key',
            'reactor_num'              => 2,       //reactor线程数
            'worker_num'               => 4,       //worker进程数
            'task_worker_num'          => 4,
            'max_request'              => 2000,    //
            'backlog'                  => 128,     //Listen队列长度,
            'heartbeat_check_interval' => 10,      //每10秒历遍一次
            'heartbeat_idle_time'      => 25,      //25秒内没收到任何信息链接强制关闭
        ]);

        //清空Redis
        foreach (REDIS_KEYS as $key => $value) {
            Redis::del($value);
        }

        $this->ws->on('open',        [$this, 'onOpen']);
        $this->ws->on('message',     [$this, 'onMessage']);
        $this->ws->on('close',       [$this, 'onClose']);
        $this->ws->on('task',        [$this, 'onTask']);
        $this->ws->on('finish',      [$this, 'onFinish']);
        $this->ws->on('WorkerStart', [$this, 'onWorkerStart']);
        $this->ws->start();
    }


    public function push($fd, $resp) 
    {
        $this->ws->push($fd, $resp);
    }


    public function onOpen($ws, $request) 
    {
        WebsocketOnOpen::open($ws, $request);
    }


    public function onMessage($ws, $request) 
    {
        WebsocketOnMessage::message($ws, $request);
        // $GLOBALS['ws'] = $this->ws;
        
        // $fd = $request->fd;
        // $data = json_decode($request->data, true);
        // dump('server:message fd is ' . $fd);
        // dump('server:message data is ' . $request->data);
        // dump('server:message opcode is ' . $request->opcode);

        // if (!$data || !is_array($data)) {
        //     dump($data);
        //     $resp = Response::json('我不知道你在传什么东西~', ResponseCode::Error);
        //     $this->push($fd, $resp);
        //     return;
        // }

        // $case = $data['case'] ?? '';
        // $data = $data['data'] ?? [];

        // $u_id = CoRedis::hget(REDIS_KEYS['fds'], 'fd_' . $fd);
        // if (!$u_id) {
        //     $resp = Response::json('系统出现了一点错误，请重新连接~', ResponseCode::SystemAbnormal);
        //     $this->push($fd, $resp);
        //     $this->ws->close($fd);
        //     return;
        // }

        // switch ($case) {
        //     case 'close':
        //         //关系连接
        //         $this->ws->close($fd);
        //         break;
        //     case 'heartbeat':
        //         //心跳包
        //         break;
        //     case 'join_ranking':
        //         //加入PK排队队列
        //         $res = Ranking::join($u_id);
        //         if ($res == -4006) {
        //             dump('u_id: ' . $u_id . ' 加入排位排队失败'  . $res);
        //             $resp = Response::json('您已经在排队队列中了~', $res);
        //             $this->push($fd, $resp);
        //             return;
        //         }

        //         if ($res == -4007) {
        //             dump('u_id: ' . $u_id . ' 加入排位排队失败'  . $res);
        //             $resp = Response::json('您正在PK呢！', $res);
        //             $this->push($fd, $resp);
        //             return;
        //         }

        //         if ($res == -1) {
        //             dump('u_id: ' . $u_id . ' 加入排位排队失败'  . $res);
        //             $resp = Response::json('系统出现了一点错误，请重新连接', $res);
        //             $this->push($fd, $resp);
        //             return;
        //         }

        //         dump('u_id: ' . $u_id . ' 加入排位排队成功');
        //         break;
        //     case 'quit_ranking':
        //         //退出PK排队队列
        //         $res = Ranking::quit($u_id);
        //         dump('u_id: ' . $u_id . ' 退出排位排队' . ($res == true ? '成功' : '失败'));
        //         break;
        //     case 'item_select':
        //         if (!isset($data['item'])) {
        //             $resp = Response::json('您没有选择答案噢~', ResponseCode::Error);
        //             $this->push($fd, $resp);
        //             return;
        //         }

        //         if (!in_array($data['item'], ['a', 'b', 'c', 'd'])) {
        //             $resp = Response::json('请选择在合理范围内的选项~', ResponseCode::Error);
        //             $this->push($fd, $resp);
        //             return;
        //         }

        //         //房号id
        //         $room_id = CoRedis::hget(REDIS_KEYS['rooms'], $u_id);
        //         if (!$room_id) {
        //             $resp = Response::json('您木有在PK噢~', ResponseCode::Error);
        //             $this->push($fd, $resp);
        //             return;
        //         }

        //         //房号详情
        //         $room = CoRedis::hgetall($room_id);
        //         dump('当前题目ID是: ' . $room['current_topic_id']);
        //         if (!$room) {
        //             $resp = Response::json('您木有在PK噢~~', ResponseCode::Error);
        //             $this->push($fd, $resp);
        //             return;
        //         }

        //         //回答题目顺序不正确
        //         if ($room['current_topic_id'] != $data['current_num']) {
        //             $resp = Response::json('当前题目进度为第' . ($room['current_topic_id']) . '题', ResponseCode::Error);
        //             $this->push($fd, $resp);
        //             return;
        //         }

        //         //双方都超时回答处理，解散当前PK
        //         $time_difference = time() - $room['last_answer_time'];

        //         //判断时间是否正确
        //         $time_is_right = false;
        //         if ($room['current_topic_id'] == 1) {
        //             //这里减去3秒是前段动画时间
        //             if ($time_difference - 3 <= $this->answer_countdown)
        //                 $time_is_right = true;

        //             dump('1答题花费时间---' . ($time_difference - 3));
        //         } else {
        //             if ($time_difference <= $this->answer_countdown)
        //                 $time_is_right = true;

        //             dump('2答题花费时间---' . $time_difference);
        //         }

                

        //         if ($time_is_right == false) {
        //             CoRedis::pipeline(function($CoReids) use ($room_id, $room) {
        //                 CoRedis::del($room_id);
        //                 CoRedis::hdel(REDIS_KEYS['rooms'], $room['left_u_id'], $room['right_u_id']);
        //             });

        //             $resp = Response::json('当前题目进度异常', ResponseCode::ProgressAbnormal);
        //             $this->push($room['left_fd'], $resp);

        //             $resp = Response::json('当前题目进度异常', ResponseCode::ProgressAbnormal);
        //             $this->push($room['right_fd'], $resp);
        //             return;
        //         }

        //         $true_answer = $room['answer_' . $data['current_num']];
        //         $player_select = $data['item'];
        //         $is_answer_true = $player_select == $true_answer ? true : false;

        //         CoRedis::pipeline(function($CoRedis) use ($u_id, $is_answer_true, $true_answer, $player_select, $room_id, $room) {
        //             $time = time();

        //             $update = [
        //                 'current_topic_id' => $room['current_topic_id'] + 1,
        //                 'last_answer_time' => $time
        //             ];

        //             $res = ['true_answer' => $true_answer, 'player_select' => $player_select];

        //             if ($u_id == $room['left_u_id'] && $is_answer_true == true) {
        //                 $update['left_answer']  = $room['left_answer'] . 'T';
        //                 $update['right_answer'] = $room['right_answer'] . 'F';

        //                 CoRedis::hmset($room_id, $update);

        //                 $resp = Response::json('回答正确', ResponseCode::IAmRight, $res);
        //                 $this->push($room['left_fd'], $resp);

        //                 $resp = Response::json('对方回答正确', ResponseCode::OpponentRight, $res);
        //                 $this->push($room['right_fd'], $resp);
        //             } else if ($u_id == $room['left_u_id'] && $is_answer_true == false) {
        //                 $update['left_answer']  = $room['left_answer'] . 'F';
        //                 $update['right_answer'] = $room['right_answer'] . 'T';

        //                 CoRedis::hmset($room_id, $update);

        //                 $resp = Response::json('回答错误', ResponseCode::IAmWrong, $res);
        //                 $this->push($room['left_fd'], $resp);

        //                 $resp = Response::json('对方回答错误', ResponseCode::OpponentWrong, $res);
        //                 $this->push($room['right_fd'], $resp);
        //             } else if ($u_id == $room['right_u_id'] && $is_answer_true == true) {
        //                 $update['left_answer']  = $room['left_answer'] . 'F';
        //                 $update['right_answer'] = $room['right_answer'] . 'T';

        //                 CoRedis::hmset($room_id, $update);

        //                 $resp = Response::json('对方回答正确', ResponseCode::OpponentRight, $res);
        //                 $this->push($room['left_fd'], $resp);

        //                 $resp = Response::json('回答正确', ResponseCode::IAmRight, $res);
        //                 $this->push($room['right_fd'], $resp);
        //             } else if ($u_id == $room['right_u_id'] && $is_answer_true == false) {
        //                 $update['left_answer']  = $room['left_answer'] . 'T';
        //                 $update['right_answer'] = $room['right_answer'] . 'F';

        //                 CoRedis::hmset($room_id, $update);

        //                 $resp = Response::json('对方回答错误', ResponseCode::OpponentWrong, $res);
        //                 $this->push($room['left_fd'], $resp);

        //                 $resp = Response::json('回答错误', ResponseCode::IAmWrong, $res);
        //                 $this->push($room['right_fd'], $resp);
        //             } else {
        //                 CoRedis::del($room_id);
        //                 CoRedis::hdel(REDIS_KEYS['rooms'], $room['left_u_id'], $room['right_u_id']);

        //                 $resp = Response::json('还有这种情况？？？', ResponseCode::GameDataBbnormal);
        //                 $this->push($room['left_fd'], $resp);

        //                 $resp = Response::json('还有这种情况？？？', ResponseCode::GameDataBbnormal);
        //                 $this->push($room['right_fd'], $resp);
        //                 return;
        //             }
        //         });

        //         $room = CoRedis::hgetall($room_id);

        //         $arr = Game::isGameEnding($room_id, $room);
        //         if (!empty($arr)) {
        //             $resp = Response::json('比赛结束获得奖励', ResponseCode::GameEnding, $arr[$room['left_u_id']]);
        //             $this->push($room['left_fd'], $resp);

        //             $resp = Response::json('比赛结束获得奖励', ResponseCode::GameEnding, $arr[$room['right_u_id']]);
        //             $this->push($room['right_fd'], $resp);
        //         }

        //         break;
        //     case 'timeout':
        //         //回答超时
        //         $time = time();

        //         //房号id
        //         $room_id = CoRedis::hget(REDIS_KEYS['rooms'], $u_id);
        //         if (!$room_id) {
        //             $resp = Response::json('您木有在PK噢~', ResponseCode::Error);
        //             $this->push($fd, $resp);
        //             return;
        //         }

        //         $lock_name = PREFIX . $room_id . '_room_lock';
        //         $room_lock = CoRedis::setnx($lock_name, $time);
        //         if (!$room_lock) {
        //             dump('数据发送重复，已忽略处理');
        //             return;
        //         }


        //         list($room, $redisRes[0]) = CoRedis::pipeline(function($CoRedis) use ($room_id, $lock_name) {
        //             CoRedis::hgetall($room_id);
        //             CoRedis::expire($lock_name, $this->answer_countdown - 2);
        //         });
        //         $room = CoRedis::format($room);

        //         dump('redis 数据返回', $room, $redisRes);

        //         //房号详情
        //         if (!$room) {
        //             $resp = Response::json('您木有在PK噢~~', ResponseCode::Error);
        //             $this->push($fd, $resp);
        //             return;
        //         }

                
        //         $time_difference = $time - $room['last_answer_time'] - $this->answer_countdown;
        //         if ($room['current_topic_id'] == 1) {
        //             $time_difference -= 3;
        //         }

        //         if ($time_difference > 2 || $time_difference < -2) {
        //             //兼容网络传输时间前后1秒
        //             dump('倒计时好像还没结束吧？~', $time_difference, $time, $room['current_topic_id']);
        //             return;
        //         }

        //         $redisRes = CoRedis::hmset($room_id, [
        //             'current_topic_id' => $room['current_topic_id'] + 1,
        //             'last_answer_time' => $time,
        //             'left_answer'      => $room['left_answer'] . 'F',
        //             'right_answer'     => $room['right_answer'] . 'F'
        //         ]);
        //         dump('res is ', $redisRes);

        //         $resp = Response::json('超时回答了哦~', ResponseCode::AnswerTimeOut);
        //         $this->push($room['left_fd'], $resp);

        //         $resp = Response::json('超时回答了哦~', ResponseCode::AnswerTimeOut);
        //         $this->push($room['right_fd'], $resp);
                
        //         $room['left_answer'] .= 'F';
        //         $room['right_answer'] .= 'F';
        //         $room['current_topic_id'] += 1;

        //         $arr = Game::isGameEnding($room_id, $room);
        //         if (!empty($arr)) {
        //             $resp = Response::json('比赛结束获得奖励', ResponseCode::GameEnding, $arr[$room['left_u_id']]);
        //             $this->push($room['left_fd'], $resp);

        //             $resp = Response::json('比赛结束获得奖励', ResponseCode::GameEnding, $arr[$room['right_u_id']]);
        //             $this->push($room['right_fd'], $resp);
        //         }

        //         dump('超时处理执行完毕');
        //         break;
        //     default:
        //         $resp = Response::json('事件类型？...', ResponseCode::Error);
        //         $this->push($fd, $resp);
        //         return;
        //         break;
        // }
    }


    /**
     * 关闭连接
     */
    public function onClose($ws, $fd)
    {
        WebsocketOnClose::close($ws, $fd);
        // dump('server:close success');
        // dump('close fd is ' . $fd);

        // $u_id = Redis::command('hget', [REDIS_KEYS['fds'], 'fd_' . $fd]);
        // dump('del u_id is ', $u_id);
        // if ($u_id > 0) {
        //     $hdel = [
        //         [
        //             'key'   => REDIS_KEYS['fds'],
        //             'field' => 'fd_' . $fd
        //         ],
        //         [
        //             'key'   => REDIS_KEYS['u_ids'],
        //             'field' => 'u_id_' . $u_id
        //         ]
        //     ];
        //     $res = Redis::pipeline(function($pipe) use ($u_id, $hdel) {
        //         //删除排位
        //         $pipe->srem(REDIS_KEYS['ranking'], $u_id);

        //         //删除关联数据
        //         foreach ($hdel as $key => $value) {
        //             $pipe->hdel($value['key'], $value['field']);
        //         }   
        //     });

        //     //退出房间号
        //     $room_id = Redis::hget(REDIS_KEYS['rooms'], $u_id);
        //     if ($room_id) {
        //         $room = Redis::hgetall($room_id);

        //         if (is_array($room) && !empty($room)) {
        //             dump('del room', $room);
        //             $to_u_id = $room['left_u_id'] == $u_id ? $room['right_u_id'] : $room['left_u_id'];
        //             $to_fd_id = Redis::command('hget', [REDIS_KEYS['u_ids'], 'u_id_' . $to_u_id]);

        //             $resp = Response::json('您的对手掉线或者跑掉啦~', 202);
        //             $this->push($to_fd_id, $resp);

        //             //删除房间信息
        //             Redis::pipeline(function($pipe) use ($room_id, $room) {
        //                 $pipe->del($room_id);
        //                 $pipe->hdel(REDIS_KEYS['rooms'], $room['left_u_id'], $room['right_u_id']);
        //             });
        //         }
        //     }
        // }
    }


    /**
     * 毫秒级定时器
     */
    public function onWorkerStart($ws, $worker_id) 
    {
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

                    list($left_fd, $right_fd) = Redis::pipeline(function($pipe) use ($left_u_id, $right_u_id) {
                        $pipe->hget(REDIS_KEYS['u_ids'], 'u_id_' . $left_u_id);
                        $pipe->hget(REDIS_KEYS['u_ids'], 'u_id_' . $right_u_id);
                    });

                    // dump($fds, $left_u_id, $right_u_id);
                    if (!($left_fd) || !$right_fd) {
                        Ranking::joins($u_ids);
                        dump('这里未完成~');
                        return;
                    }

                    //生成房间信息
                    $flags = true;
                    do {
                        $room_id = PREFIX . mt_rand(1000, 9999);
                        $flags = Redis::exists($room_id);
                    } while($flags);

                    $topics = Topics::random(5);
                    dump('随机房间号 ' . $room_id);
                    Redis::pipeline(function($pipe) use ($room_id, $left_u_id, $left_fd, $right_u_id, $right_fd, $topics) {
                        $time = time();

                        //插入房间信息
                        $pipe->hmset(REDIS_KEYS['rooms'], $left_u_id, $room_id, $right_u_id, $room_id);

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

                        $pipe->hmset($room_id, $params);
                        // call_user_func_array([$pipe, 'hset'], $params);
                    });

                    $user = Users::info($left_u_id);
                    $resp = Response::json('匹配到对手啦~', 201, ['user' => $user, 'is_room_creator' => 0, 'topics' => $topics['topics']]);
                    $this->push($right_fd, $resp);

                    $user = Users::info($right_u_id);
                    $resp = Response::json('匹配到对手啦~', 201, ['user' => $user, 'is_room_creator' => 1, 'topics' => $topics['topics']]);
                    $this->push($left_fd, $resp);
                });
                break;
            case 1:
                break;
            default:
                break;
        }
    }


    /**
     * 处理异步任务
     */
    public function onTask($ws, $task_id, $from_id, $data) 
    {

    }


    /**
     * 处理异步任务的结果
     */
    public function onFinish($ws, $task_id, $data) 
    {

    }


    /**
     * 异步日志写入
     */
    public function swooleAsyncWritefile($content) 
    {
        $time = date('Y-m-d H:i:s');
        $file = __DIR__ . '/../../chat/logs/' . date('Ymd') . '.log';
        $content = $time . PHP_EOL . $content . PHP_EOL;
        swoole_async_writefile($file, $content, function($filename) {
            echo PHP_EOL . "wirte ok." . PHP_EOL;
        }, FILE_APPEND);
    }

    /**
     * 异步错误日志写入
     */
    public function swooleAsyncWriteErrfile($resp, $content) 
    {
        $time = date('Y-m-d H:i:s');
        $file = __DIR__ . '/../../chat/logs/' . date('Ymd') . 'err.log';
        $content = PHP_EOL . $e->getMessage() . PHP_EOL . json_encode($data) . PHP_EOL;
        swoole_async_writefile($file, $content, function($filename) {
            echo PHP_EOL . "err wirte ok." . PHP_EOL;
        }, FILE_APPEND);
    }
}
