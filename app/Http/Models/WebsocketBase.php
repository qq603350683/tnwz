<?php
namespace App\Http\Models;

class WebsocketBase {
    /**
     * Websocket 推送消息
     *
     */
	public static function push($fd, $message, $code, $data = [])
    {
        $resp = Response::json($message, $code, $data);

        if (!isset($GLOBALS['ws'])) {
            dump('Global ws is not isset');
            return;
        }

        ($GLOBALS['ws'])->push($fd, $resp);
    }


    /**
     * 关闭 Websocket 链接
     *
     * @param 
     */
    public static function close($fd)
    {
        ($GLOBALS['ws'])->close($fd);
    }
}