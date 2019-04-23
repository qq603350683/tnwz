<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

use Illuminate\Support\Facades\Redis;

use App\Http\Models\{
    Response,
    AdminsConfigs,
    Users,
    Topics,
    Ranking
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
    protected $prefix = 'tnwz_';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        define('REDIS_NAME', [
            'fds'     => $this->prefix . 'fd',      //u_id -> fd
            'u_ids'   => $this->prefix . 'u_id',    //fd -> u_id
            'ranking' => $this->prefix . 'ranking', //排队队列
            'rooms'   => $this->prefix . 'room'     //房间号
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
            'reactor_num'     => 2,       //reactor线程数
            'worker_num'      => 4,        //worker进程数
            'task_worker_num' => 4,
            'max_request'     => 2000,    //
            'backlog'         => 128,         //Listen队列长度
        ]);

        //清空Redis
        foreach (REDIS_NAME as $key => $value) {
            $hdel[] = $value;
        }
        Redis::command('del', $hdel);

        $this->ws->on('open', [$this, 'onOpen']);
        $this->ws->on('message', [$this, 'onMessage']);
        $this->ws->on('close', [$this, 'onClose']);
        $this->ws->on('task', [$this, 'onTask']);
        $this->ws->on('finish', [$this, 'onFinish']);
        $this->ws->on('WorkerStart', [$this, 'onWorkerStart']);
        $this->ws->start();
    }


    public function push($fd, $resp) 
    {
        $this->ws->push($fd, $resp);
    }


    public function onOpen($ws, $request) 
    {
        dump('fd 接入 ' . $request->fd . ' 成功');
        $u_id         = intval($request->get['u_id'] ?? 0);
        $unique_token = $request->get['unique_token'] ?? '';
        dump('u_id: ' . $request->get['u_id'] . ' unique_token: ' . $unique_token);

        if (!$u_id || !$unique_token) {
            $resp = Response::json('哎呦，出现了点小错误', -4001);
            $this->push($request->fd, $resp);
            $this->ws->close($request->fd);
        }

        $user = Users::info($u_id, ['u_id', 'unique_token']);
        if (empty($user)) {
            $resp = Response::json('亲，找不到您当前的用户', -4001);
            $this->push($request->fd, $resp);
            $this->ws->close($request->fd);
        }

        $is_active = AdminsConfigs::isActive();
        if ($is_active != 0) {
            $resp = Response::json('活动不在进行中...', $is_active);
            $this->push($request->fd, $resp);
            $this->ws->close($request->fd);
            return;
        }

        //保存到redis
        $hset = [
            [
                'key'   => REDIS_NAME['fds'],
                'field' => 'fd_' . $request->fd,
                'value' => $u_id
            ],
            [
                'key'   => REDIS_NAME['u_ids'],
                'field' => 'u_id_' . $u_id,
                'value' => $request->fd
            ]
        ];
        Redis::pipeline(function($pipe) use ($hset) {
            foreach ($hset as $key => $value) {
                $pipe->hset($value['key'], $value['field'], $value['value']);
            }   
        });

        $resp = [
            'fd'   => $request->fd,
            'u_id' => $user['u_id']
        ];
        $resp = Response::json('连接成功', 200);
        $this->push($request->fd, $resp);
    }


    public function onMessage($ws, $request) 
    {
        $data = json_decode($request->data, true);
        dump('server:message fd is ' . $request->fd);
        dump('server:message data is ' . $request->data);
        dump('server:message opcode is ' . $request->opcode);

        if (!$data || !is_array($data)) {
            $resp = Response::json('我不知道你在传什么东西~', -1);
            $this->push($request->fd, $resp);
            return;
        }

        $data['case'] = $data['case'] ?? '';

        $u_id = Redis::command('hget', [REDIS_NAME['fds'], 'fd_' . $request->fd]);
        if (!$u_id) {
            $resp = Response::json('系统出现了一点错误，请重新连接~', -1);
            $this->push($request->fd, $resp);
            $this->ws->close($request->fd);
            return;
        }

        switch ($data['case']) {
            case 'join_ranking':
                //加入PK排队队列
                $res = Ranking::join($u_id);
                dump('u_id: ' . $u_id . ' 加入排位排队' . ($res == true ? '成功' : '失败'));
                break;
            
            case 'quit_ranking':
                //退出PK排队队列
                $res = Ranking::quit($u_id);
                dump('u_id: ' . $u_id . ' 退出排位排队' . ($res == true ? '成功' : '失败'));
                break;

            default:
                $resp = Response::json('事件类型？...', -1);
                $this->push($request->fd, $resp);
                return;
                break;
        }
    }


    /**
     * 关闭连接
     */
    public function onClose($ws, $fd)
    {
        dump('server:close success');
        dump('close fd is ' . $fd);

        $u_id = Redis::command('hget', [REDIS_NAME['fds'], 'fd_' . $fd]);
        dump('del u_id is ' . $u_id);
        if ($u_id > 0) {
            $hdel = [
                [
                    'key'   => REDIS_NAME['fds'],
                    'field' => 'fd_' . $fd
                ],
                [
                    'key'   => REDIS_NAME['u_ids'],
                    'field' => 'u_id_' . $u_id
                ]
            ];
            Redis::pipeline(function($pipe) use ($u_id, $hdel) {
                //删除排位
                $pipe->srem(REDIS_NAME['ranking'], $u_id);

                //删除关联数据
                foreach ($hdel as $key => $value) {
                    $pipe->hdel($value['key'], $value['field']);
                }   
            });
        }
    }


    /**
     * 毫秒级定时器
     */
    public function onWorkerStart($ws, $worker_id) 
    {
        if ($worker_id == 0) {
            swoole_timer_tick(2000, function() use ($ws, $worker_id) {
                //2秒一次检测所有队列是否有队友
                $len = Ranking::len();
                dump('当前队列排队人数：' . $len . '人');

                if ($len < 2)
                    return;

                $u_ids = Ranking::random(2);

                $fds = Redis::pipeline(function($pipe) use ($u_ids) {
                    foreach ($u_ids as $key => $value) {
                        $pipe->hget(REDIS_NAME['fds'], 'fd_' . $value);
                    }
                });

                if (empty($fds) || count($fds) != 2) {
                    Ranking::joins($u_ids);
                }

                //生成房间信息
                $flag = true;
                do {
                    $room_id = $this->prefix . mt_rand(1000, 9999);
                    $flag = Redis::sismember(REDIS_NAME['rooms'], $room_id);
                } while($flag);

                

                $topics = Topics::random(10);

                $user = Users::info($u_ids[0]);
                $resp = Response::json('匹配到对手啦~', 201, ['user' => $user, 'topics' => $topics['topics']]);
                $this->push($fds[1], $resp);

                $user = Users::info($u_ids[1]);
                $resp = Response::json('匹配到对手啦~', 201, ['user' => $user, 'topics' => $topics['topics']]);
                $this->push($fds[0], $resp);
            });
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
