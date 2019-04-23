<?php
namespace App\Http\Models;

use Illuminate\Support\Facades\Redis;

class Ranking {
	/**
	 * 加入队列排队
	 * 
	 * @param 
	 * @return 
	 */
	public static function join($u_id)
	{
		$res = Redis::command('sismember', [REDIS_NAME['ranking'], $u_id]);
		if ($res)
			return true;
		$res = Redis::command('sadd', [REDIS_NAME['ranking'], $u_id]);
		return $res ? true : false;
	}


	/**
	 * 批量加入队列
	 * 
	 * 
	 */
	public static function joins($u_ids)
	{
		return Redis::pipeline(function($pipe) use ($u_ids) {
			foreach ($u_ids as $key => $value) {
				$pipe->sadd(REDIS_NAME['ranking'], $value);
			}
        });
	}


	/**
	 * 退出队列
	 * 
	 * @param 
	 * @return 
	 */
	public static function quit($u_id)
	{
		$res = Redis::command('sismember', [REDIS_NAME['ranking'], $u_id]);
		if (!$res)
			return false;

		$res = Redis::command('srem', [REDIS_NAME['ranking'], $u_id]);
		return $res ? true : false;
	}


	/**
	 * 获取长度
	 * 
	 * @param 
	 * @return 
	 */
	public static function len()
	{
		$len = Redis::scard(REDIS_NAME['ranking']);
		return $len;
	}


	/**
	 * 随机弹出count个用户
	 * 
	 * @param 
	 * @return 
	 */
	public static function random($count)
	{
		return Redis::pipeline(function($pipe) use ($count) {
			for ($i=0; $i < $count; $i++) { 
				$pipe->spop(REDIS_NAME['ranking']);
			}
        });
	}
}
