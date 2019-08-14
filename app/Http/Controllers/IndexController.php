<?php
namespace App\Http\Controllers;

use Illuminate\Support\Facades\Input;
// use App\Http\Controllers\Controller;

use Config;
use DB;
use Excel;

use App\Http\Models\{
	Response,
	AdminsConfigs,
	Users
};

class IndexController extends Controller
{
	public function index()
	{
		ini_set("max_execution_time", "1800");
		die;
		$list = DB::table('splide_topic_repositories')
			->select('question', 'cate_id', 'cate_name', 'a', 'b', 'c', 'd', 'answer', 'explanation', 'question_id')
			->where('cate_id', '>', 0)
			->offset(15000)
			->limit(5000)
			->get()
			->toArray();
		$list = array_map('get_object_vars', $list);
		foreach ($list as $key => $value) {
			switch ($value['cate_name']) {
				case '体育':
					$list[$key]['cate_id'] = 2;
					break;
				case '化学':
					$list[$key]['cate_id'] = 3;
					break;
				case '历史':
					$list[$key]['cate_id'] = 4;
					break;
				case '地理':
					$list[$key]['cate_id'] = 5;
					break;
				case '天文':
					$list[$key]['cate_id'] = 6;
					break;
				case '常识':
					$list[$key]['cate_id'] = 7;
					break;
				case '政治':
					$list[$key]['cate_id'] = 8;
					break;
				case '文学':
					$list[$key]['cate_id'] = 9;
					break;
				case '旅游':
					$list[$key]['cate_id'] = 10;
					break;
				case '物理':
					$list[$key]['cate_id'] = 11;
					break;
				case '电脑':
					$list[$key]['cate_id'] = 12;
					break;
				case '科技':
					$list[$key]['cate_id'] = 13;
					break;	
				case '自然':
					$list[$key]['cate_id'] = 14;
					break;
				case '音乐':
					$list[$key]['cate_id'] = 15;
					break;	
				default:
					$list[$key]['cate_id'] = 0;
					break;
			}
			$list[$key]['explanation'] = str_replace('、', '', $value['explanation']);
			// $list[$key]['create_time'] = $_SERVER['REQUEST_TIME'];
			unset($list[$key]['question_id']);
		}
		// dd($list);

		echo DB::table('topics_repositories')->insert($list);

	}


	//导出excel
	public function excel()
	{
		Config::set([
        	'database.connections.mysql' => [
				'driver'    => 'mysql',
				'host'      => '192.168.1.71',
				'port'      => '3306',
				'database'  => 'xiehouyu',
				'username'  => 'root',
				'password'  => 'root',
				'charset'   => 'utf8mb4',
				'collation' => 'utf8mb4_unicode_ci',
				'prefix'    => '',
				'strict'    => false,
				'engine'    => null,
        	]
        ]);

		ini_set("max_execution_time", "1800");
		$data = DB::table('njjzw')->get()->toArray();
		$data = array_map('get_object_vars', $data);

		return Excel::create('数据导出', function($excel) use ($data) {
            $excel->sheet('数据导出', function($sheet) use ($data)
            {
                $sheet->cell('A1', function($cell) {
                	$cell->setValue('ID');
                });
                $sheet->cell('B1', function($cell) {
                	$cell->setValue('标题');
                });
                $sheet->cell('C1', function($cell) {
                	$cell->setValue('答案');
                });
                if (!empty($data)) {
                    foreach ($data as $key => $value) {
                        $i = $key+2;
                        $sheet->cell('A'.$i, $value['id']);
                        $sheet->cell('B'.$i, $value['title']);
                        $sheet->cell('C'.$i, $value['answer']);
                    }
                }
            });
        })->download('xls');

	}

}