<?php
namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use App\Exceptions\ApiException;


class Users extends Model 
{
	public static function info($u_id, $select = '*')
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
	public static function ranks($offset, $limit)
	{
		$ranks = Users::select('u_id', 'nickname', 'wx_avatar', 'local_avatar', 'city', 'lv')
			->where('status', 1)
			->orderBy('lv', 'desc')
			->orderBy('sort', 'desc')
			->offset($offset)
			->limit($limit)
			->get();

		if (empty($ranks))
			return [];

		return $ranks;
	}
}
