<?php
namespace App\Http\Controllers;

use Illuminate\Support\Facades\Input;
// use App\Http\Controllers\Controller;

use App\Http\Models\{
	Response,
	AdminsConfigs,
	Users
};

class UsersController extends Controller
{
	/**
	 * 获取用户详情
	 *
	 * @param int $u_id 用户id
	 */
	public function info($u_id)
	{
		$u_id = intval($u_id);
		if (!$u_id)
			return Response::json('u_id is not exists', -1);

		AdminsConfigs::getConfig();

		$info = Users::info($u_id, ['u_id', 'wx_avatar', 'city', 'nickname', 'lv', 'exp', 'gold', 'unique_token']);
		$is_active = AdminsConfigs::isActive();

		return Response::json('success', 200, ['is_active' => $is_active, 'user' => $info]);
	}


	/**
	 * 获取排行榜
	 * 
	 * @param 
	 * @return 
	 */
	public function ranks()
	{
		$offset = intval(Input::get('offset', 0));
		$limit  = intval(Input::get('limit', 20));

		$ranks = Users::ranks($offset, $limit);

		return Response::json('success', 200, $ranks);
	}
}