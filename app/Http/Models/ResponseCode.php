<?php
namespace App\Http\Models;

class ResponseCode {
	const Success = 200;

	const OpponentAbstained  = 202;

	const IAmRight = 203;
	const OpponentRight = 204;
	const IAmWrong = 205;
	const OpponentWrong = 206;

	const AnswerTimeOut = 207;

	const GameEnding = 208;

	const Error = -1;

	const UserAbnormal = -4001;

	const AlreadyInRanking = -4006;

	const UserInPKStatus = -4007;

	const ProgressAbnormal = -4008;  

	const SystemAbnormal = -4099;

	const GameDataBbnormal = -4009;
}
