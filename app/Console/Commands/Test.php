<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

use Illuminate\Support\Facades\Redis;

use App\Http\Models\{
    Response,
    AdminsConfigs,
    Users,
    Topics,
    Game,
    Ranking
};

class Test extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'test';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';


    protected $ws;
    protected $prefix = 'test_';
    protected $answer_countdown = 3;

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        define('REDIS_TEST_KEYS', [
            'test'     => $this->prefix . 'test', 
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
        foreach (REDIS_TEST_KEYS as $key => $value) {
            Redis::del($value);
        }

        Redis::hset(REDIS_TEST_KEYS['test'], [
            0 => 'a',
            1 => 'b',
            2 => 'c',
            3 => 'd',
            4 => 'e',
            5 => 'f',
            6 => 'g',
            7 => 'h',
            8 => 'i',
            9 => 'j' 
        ]);
        // Redis::command('del', $hdel);

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
        $mod = time() % 10;
        dump('mod is ' . $mod);
    }


    public function onMessage($ws, $request) 
    {
        $mod = time() % 10;
        dump('mod is ' . $mod);
    }


    /**
     * 关闭连接
     */
    public function onClose($ws, $fd)
    {
        
    }


    /**
     * 毫秒级定时器
     */
    public function onWorkerStart($ws, $worker_id) 
    {
        switch ($worker_id) {
            case 0:
                $mod = time() % 10;
                dump('mod is ' . $mod);
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
