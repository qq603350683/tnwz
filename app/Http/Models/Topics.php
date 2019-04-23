<?php
namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use App\Exceptions\ApiException;

class Topics extends Model 
{
	/**
	 * 随机获取$count条题目
	 *
	 * @param int $count 数量
	 */
	public static function random($count = 10)
	{
		$topics = Topics::select('t_id', 'cate_name', 'question', 'a', 'b', 'c', 'd', 'answer')
			->where('status', 1)
			->offset(0)
			->limit($count)
			->get()
			->toArray();
		if (empty($topics))
			return [];

		foreach ($topics as $key => $value) {
			$questions['question_' . $key] = $value['question'];
			$answers['answer_' . $key]     = $value['answer'];
			unset($topics[$key]['answer']);
		}

		return ['topics' => $topics, 'questions' => $questions, 'answers' => $answers];
	}
}
