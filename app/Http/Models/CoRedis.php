<?php
namespace App\Http\Models;

class CoRedis 
{
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


	public static function hgetall($key)
	{
		$all = self::getInstance()->hgetall($key);
		if (is_null($all) || empty($all))
			return $all;

		$count = count($all);
        for ($i=0; $i < $count; $i += 2) { 
            $all[$all[$i]] = $all[$i + 1];
            unset($all[$i], $all[$i + 1]);
        }
        return $all;
	}


	public static function hdel($key, $field)
	{
		return self::getInstance()->hDel($key, $field);
	}


	/**
	 * this
	 *
	 * @param 
	 */
	public static function pipeline($callback)
	{
		// return 
	}
}