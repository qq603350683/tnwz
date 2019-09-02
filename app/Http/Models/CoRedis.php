<?php
namespace App\Http\Models;

class CoRedis 
{
	private static $commandCount = 0;
	private static $instance = NULL;

	private function __construct()
	{

	}

	/**
	 * this
	 *
	 * @param 
	 */
	public function __clone()
	{
		dd('Redis Clone is not allowed.');
	}


	public static function getInstance()
	{
		if (is_null(self::$instance)) {
			$redis = new \Swoole\Coroutine\Redis();
       		$redis->connect(REDIS_CONFIG['host'], REDIS_CONFIG['port']);
       		self::$instance = $redis;
		}

		if (self::$instance->getDefer() == true)
			self::$commandCount += 1;

		return self::$instance; 
	}


	public static function get($key)
	{
		return self::getInstance()->get($key);
	}


	public static function set($key, $value, $expire = 0)
	{
		return $expire > 0 ? self::getInstance()->set($key, $value, $expire) : self::getInstance()->set($key, $value);
	}


	public static function del($key)
	{
		return self::getInstance()->delete($key);
	}


	public static function exists($key)
	{
		return self::getInstance()->exists($key);
	}


	public static function setnx($key, $value)
	{
		return self::getInstance()->setnx($key, $value);
	}


	public static function expire($key, $expire)
	{
		if (!is_numeric($expire))
			return 0;

		if ($expire <= 0)
			return 0;

		return self::getInstance()->expire($key, $expire);
	}


	public static function hset($key, $field, $value)
	{
		return self::getInstance()->hset($key, $field, $value);
	}


	public static function hmset($key, $array)
	{
		return self::getInstance()->hMset($key, $array);
	}


	public static function hget($key, $field)
	{
		return self::getInstance()->hget($key, $field);
	}


	public static function hmget($key, ...$array)
	{
		return self::getInstance()->hmget($key, $array);
	}


	public static function hgetall($key)
	{
		$all = self::getInstance()->hgetall($key);
		if (is_null($all) || empty($all) || !is_array($all))
			return $all;
		
		return self::format($all);
	}


	public static function hdel($key, $field)
	{
		return self::getInstance()->hDel($key, $field);
	}


	public static function sismember($key, $field)
	{
		return self::getInstance()->sismember($key, $field);
	}



	public static function sadd($key, $value)
	{
		return self::getInstance()->sadd($key, $value);
	}


	public static function srem($key, $field)
	{
		return self::getInstance()->srem($key, $field);
	}


	public static function scard($key)
	{
		return self::getInstance()->scard($key);
	}


	public static function spop($key)
	{
		return self::getInstance()->spop($key);
	}


	public static function pipeline($callback)
	{
		$CoRedis = self::getInstance();

		$CoRedis->setDefer();

		call_user_func($callback, $CoRedis);

		for ($i=0; $i < self::$commandCount; $i++) {
			$res[] = $CoRedis->recv();
		}

		self::$commandCount = 0;
		$CoRedis->setDefer(false);

		return $res;
	}


	public static function format($array)
	{
		$count = count($array);
        for ($i=0; $i < $count; $i += 2) { 
            $array[$array[$i]] = $array[$i + 1];
            unset($array[$i], $array[$i + 1]);
        }
        return $array;
	}
}