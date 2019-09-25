<?php
namespace App\Http\Models;

class CoMySQL
{
	public static $instance = null;

	public static $begin = false;

	public static $DB = null;

	private function __construct($size = 2)
	{
		$this->channel = new \Swoole\Coroutine\Channel($size);

		while ($size--) {
			$this->connect(true);
		}
	}


	private function __clone()
	{

	}

	public function connect($is_push_chan = false)
	{
		$DB = new \Swoole\Coroutine\MySQL();
		$res = $DB->connect([
			'host'     => env('DB_HOST'),
			'port'     => env('DB_PORT'),
			'user'     => env('DB_USERNAME'),
			'password' => env('DB_PASSWORD'),
			'database' => env('DB_DATABASE')
		]);
		if (!$res)
			return false;

		// if ($is_push_chan == true)
		// 	self::getInstance()->push($DB);
		if ($is_push_chan == true)
			$this->put($DB);

		return $DB;
	}


	public function put(\Swoole\Coroutine\MySQL $MySQL):void
	{
		$this->channel->push($MySQL);
	}


	public function get($timeout = -1): ?\Swoole\Coroutine\MySQL
	{
		return $this->channel->pop($timeout) ?: null;
	}


	public static function getInstance()
	{
		if (!self::$instance instanceof self)
			self::$instance = new self();

		return self::$instance;
	}


	/**
	 * 开启事物
	 *
	 * @param 
	 */
	public static function begin()
	{
		self::$begin = true;
	}


	/**
	 * 回滚事物
	 *
	 * @param 
	 */
	public static function rollback()
	{
		if (self::$begin != true)
			return fasle;

		self::$DB->rollback();

		self::$begin = false;
	}


	/**
	 * this
	 *
	 * @param 
	 */
	public static function commit()
	{
		if (self::$begin != true)
			return fasle;

		self::$DB->commit();	

		self::$begin = false;
	}


	/**
	 * 执行SQL
	 *
	 * @param 
	 */
	public static function query($sql, $params = [])
	{
		self::$DB = self::getInstance()->get();

		if (self::$begin == true)
			self::$DB->begin();

		if (empty($params)) {
			$res = self::$DB->query($sql);
		} else {
			$res = self::$DB->prepare($sql);
			if (!$res) {
				$res = self::reQuery($sql, $params);
			} else {
				$res = $res->execute($params);
			}
		}

		return $res;
	}


	/**
	 * MySQL 断开重连并重新查询 SQL
	 *
	 * @param 
	 */
	public static function reQuery($sql, $params = [])
	{
		if (in_array(self::$DB->errno, [2006, 2013])) {

			//DB断开了
			self::$DB = self::connect(true);

			if (empty($params)) {
				$res = self::$DB->query($sql);
			} else {
				$res = self::$DB->prepare($sql);
				if ($res)
					$res = $res->execute($params);
			}

			if (!$res) {
				//这里问题大了~  估计数据库挂了~

				return false;
			}
		}

		return $res;
	}
}