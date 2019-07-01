<?php
namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use App\Exceptions\ApiException;


class Users extends Model 
{
	public $timestamps = false;

	// const CREATED_AT = 'create_time';
	// const UPDATED_AT = 'update_time';

	// protected $dateFormat = 'U';
	protected $primaryKey = 'u_id';

	public static function info($u_id, $select = '*'):array
	{
		$info = Users::where('u_id', $u_id)
			->select($select)
			->first();

		if (empty($info))
			throw new ApiException('Current user does not exists', -1);

		return $info->toArray();
	}


	/**
	 * this
	 * 
	 * @param 
	 * @return 
	 */
	public static function ranks($offset, $limit):array
	{
		$ranks = Users::select('u_id', 'nickname', 'wx_avatar', 'local_avatar', 'city', 'lv')
			->where('status', 1)
			->orderBy('lv', 'desc')
			->orderBy('sort', 'desc')
			->offset($offset)
			->limit($limit)
			->get()
			->toArray();

		if (empty($ranks))
			return [];

		return $ranks;
	}


	/**
	 * 获得金币/经验
	 * 
	 * @param 
	 * @return 
	 */
	public static function calcResult($victory_u_id, $datas):bool
	{
		foreach ($datas as $key => $value) {
			$info = self::info($key);

			//金币增加
			$update['gold'] = $info['gold'] + $value['gold'];

			//总场次+1
			$update['game_num'] = $info['game_num'] + 1;

			//经验修改  升级逻辑
			$total_exp = $info['exp'] + $value['exp'];
			if ($total_exp >= $info['lv_exp']) {
				$update['lv'] = $info['lv'] + 1;
				$update['exp'] = $info['lv_exp'] - $total_exp;
			} else {
				$update['exp'] = $total_exp;
			}

			if ($victory_u_id == 0) {
				//平手
				$update['flat_num'] = $info['flat_num'] + 1;
				$update['victory_rate'] = $info['victory_num'] / $update['game_num'];
			} else if ($victory_u_id == $key) {
 				//胜利
 				$update['victory_num'] = $info['victory_num'] + 1;
 				$update['victory_rate'] = $update['victory_num'] / $update['game_num'];
			} else {
				//失败
				$update['defeat_num'] = $info['defeat_num'] + 1;
				$update['victory_rate'] = $info['victory_num'] / $update['game_num'];
			}

			$res = Users::where('u_id', $key)
				->update($update);
				
			dump($key . '计算结果' . $res);
		}

		return true;
	}
}
