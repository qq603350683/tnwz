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
	public static function join($u_id = 0)
	{
		$u_id = $u_id > 0 ? $u_id : $GLOBALS['u_id'];

		$res = CoRedis::pipeline(function($CoRedis) use ($u_id) {
			CoRedis::sismember(REDIS_KEYS['ranking'], $u_id);

			CoRedis::sismember(REDIS_KEYS['rooms'], $u_id);
		});

		if ($res[0] == 1) {
			WebsocketBase::push($GLOBALS['fd'], '您已经加入排队中了哦~', ResponseCode::AlreadyInRanking);
			return fasle;
		}

		if ($res[1] == 1) {
			WebsocketBase::push($GLOBALS['fd'], '您正在PK呢！', ResponseCode::UserInPKStatus);
			return false;
		}

		$res = CoRedis::sadd(REDIS_KEYS['ranking'], $u_id);
		if ($res == 0) {
			WebsocketBase::push($GLOBALS['fd'], '加入排队失败~', ResponseCode::Error);
			return false;
		}

		WebsocketBase::push($GLOBALS['fd'], '加入排位队列成功', ResponseCode::Success);

		return true;
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
		CoRedis::srem(REDIS_KEYS['ranking'], $u_id);

		WebsocketBase::push($GLOBALS['fd'], '退出排位队列成功', ResponseCode::Success);

		return true;
	}


	/**
	 * 获取长度
	 * 
	 * @param 
	 * @return 
	 */
	public static function len()
	{
		$len = CoRedis::scard(REDIS_KEYS['ranking']);
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
		return CoRedis::pipeline(function($CoRedis) use ($count) {
			for ($i=0; $i < $count; $i++) { 
				CoRedis::spop(REDIS_KEYS['ranking']);
			}
        });
	}
}
