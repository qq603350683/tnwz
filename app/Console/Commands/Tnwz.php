<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

use Illuminate\Support\Facades\Redis;

use App\Http\Models\{
    Game,
    Users,
    Topics,
    Ranking,
    CoMySQL,
    CoRedis,
    Response,
    ResponseCode,
    WebsocketLog,
    AdminsConfigs,
    WebsocketOnOpen,
    WebsocketOnClose,
    WebsocketOnMessage,
    WebsocketOnWorkerStart
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

        //创建日志文件
        $dir = storage_path('/swoole');
        if (!is_dir($dir)) {
            mkdir($dir);
            chmod($dir, 0755);
        }

        $this->ws->on('open',       'App\Http\Models\WebsocketOnOpen::index');
        $this->ws->on('message',    'App\Http\Models\WebsocketOnMessage::index');
        $this->ws->on('close',      'App\Http\Models\WebsocketOnClose::index');
        $this->ws->on('task',        [$this, 'onTask']);
        $this->ws->on('finish',      [$this, 'onFinish']);
        $this->ws->on('WorkerStart', 'App\Http\Models\WebsocketOnWorkerStart::index');
        $this->ws->start();
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
