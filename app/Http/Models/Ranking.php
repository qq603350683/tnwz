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
		$res = Redis::pipeline(function($pipe) use ($u_id) {
			//判断是否重复加入队列
			$pipe->sismember(REDIS_KEYS['ranking'], $u_id);

			//判断是否正在PK中。
			$pipe->sismember(REDIS_KEYS['rooms'], $u_id);
		});
		if ($res[0] == 1)
			return -4006;

		if ($res[1] == 1)
			return -4007;

		$resp = Response::json('qqqqqqqqqqqq', -1);
		($GLOBALS['ws'])->push(1, $resp);

		$res = Redis::command('sadd', [REDIS_KEYS['ranking'], $u_id]);
		return $res ? 1 : -1;
	}


	/**
	 * 批量加入队列
	 * 
	 * 
	 */
	public static function joins($u_ids)
	{
		$res = Redis::pipeline(function($pipe) use ($u_ids) {
			foreach ($u_ids as $key => $value) {
				//判断是否重复加入队列
				$pipe->sismember(REDIS_KEYS['ranking'], $value);

				//判断是否正在PK中。
				$pipe->sismember(REDIS_KEYS['rooms'], $value);
			}
		});

		dump('这里要做检查~~~~~~', $res);
		if (in_array(false, $res)) {

		}
		

		return Redis::pipeline(function($pipe) use ($u_ids) {
			foreach ($u_ids as $key => $value) {
				$pipe->sadd(REDIS_KEYS['ranking'], $value);
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
		$res = Redis::command('sismember', [REDIS_KEYS['ranking'], $u_id]);
		if (!$res)
			return false;

		$res = Redis::command('srem', [REDIS_KEYS['ranking'], $u_id]);
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
		$len = Redis::scard(REDIS_KEYS['ranking']);
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
				$pipe->spop(REDIS_KEYS['ranking']);
			}
        });
	}
}
