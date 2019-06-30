<?php
namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use App\Exceptions\ApiException;


class AdminsConfigs extends Model 
{
	/**
	 * 获取备注详情
	 * 
	 */
	public static function getConfig($key = '')
	{
		$configs = AdminsConfigs::get()
			->toArray();

		if (empty($configs))
			throw new ApiException('对不起，您所玩的游戏木有激活！', -4004);

		$configs = array_combine(array_column($configs, 'key'), array_column($configs, 'value'));

		return $key == '' ? $configs : $configs[$key];
	}



	/**
	 * 活动详情
	 * 
	 * @param 
	 * @return 
	 */
	public static function isActive($configs = [])
	{
		$configs = !empty($configs) ? $configs : self::getConfig();

        if ($_SERVER['REQUEST_TIME'] < strtotime($configs['begin_time']))
            return -4002;

        if ($_SERVER['REQUEST_TIME'] > strtotime($configs['end_time']))
            return -4003;

        return 0;
	}
}
