<?php
namespace App\Http\Models;

class Response {
	/**
	 * 返回一个json
	 * @param string $message 信息提示
	 * @param int $status 响应码  -4001统一提示错误 -4002活动未开始 -4003活动已经结束
	 * @param arr $data 返回的数据
	 * @return string
	 */
	public static function json($message , $code = -1 , $data = []){
		return json_encode(['message' => $message , 'code' => $code , 'data' => $data]);
	}
}
