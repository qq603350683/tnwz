<?php
namespace App\Http\Models;

class WebsocketLog {
    public static function SQL($sql, $params = [])
    {
        $sql = vsprintf(str_replace('?','%s', $sql), $params);

        self::write('SQL', $sql);
    }


    /**
     * this
     * 
     * @param 
     */
    public static function write($type, $content)
    {
        $filepath = storage_path('/swoole/tnwz.log');

        switch ($type) {
            case 'SQL':
                $filepath = storage_path('/swoole/sql' . date('Ymd') . '.log');
                break;
        }

        $content = date('Y-m-d H:i:s') . ' ' . $type . ' ' . $content .  PHP_EOL;

        go(function() use ($filepath, $content) {
            file_put_contents($filepath, $content, FILE_APPEND | LOCK_EX);
        });
    }
}