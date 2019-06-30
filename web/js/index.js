(function() {
	var clientCssWidth = document.documentElement.clientWidth;
	document.documentElement.style.fontSize = (60 * clientCssWidth / 1080) + 'px';
	var api = {
		'http_server' : '../',
		'ranking_list' : 'ranks',
		'check_login' : 'base/check-login',
		'user_info' : 'users',
	};
	var params = {
		'title' : '？？？',
		'ranking_loading' : 'PK',
		'ranking_list' : '排行榜'
	};
	var animated = {
		'bounceOutUp' : 'animated bounceOutUp',
		'flipOutX' : 'animated flipOutX',
		'bounceInLeft' : 'animated bounceInLeft',
		'bounceInRight' : 'animated bounceInRight',
		'bounceOut': 'animated bounceOut',
		'zoomIn' : 'animated zoomIn',
	};
	var images = [
		{'url' : 'images/title.png'},
	 	{'url' : 'images/balloon.png'},
	 	{'url' : 'images/background_1.png'},
	 	{'url' : 'images/background_2.png'},
	 	{'url' : 'images/background_3.png'},
	 	{'url' : 'images/background_4.png'},
	 	{'url' : 'images/bank.png'},
	 	{'url' : 'images/exp.png'},
	 	{'url' : 'images/false.png'},
	 	{'url' : 'images/first.png'},
	 	{'url' : 'images/gold.png'},
	 	{'url' : 'images/goods.png'},
	 	{'url' : 'images/more.png'},
	 	{'url' : 'images/qrcode.png'},
	 	{'url' : 'images/ranking.png'},
	 	{'url' : 'images/ranking_1.png'},
	 	{'url' : 'images/ranking_2.png'},
	 	{'url' : 'images/ranking_3.png'},
	 	{'url' : 'images/ranking_4.png'},
	 	{'url' : 'images/ranking_5.png'},
	 	{'url' : 'images/ranking_6.png'},
	 	{'url' : 'images/ranking_list.png'},
	 	{'url' : 'images/ranking_online_prople.png'},
	 	{'url' : 'images/sercond.png'},
	 	{'url' : 'images/setting.png'},
	 	{'url' : 'images/shop.png'},
	 	{'url' : 'images/third.png'},
	 	{'url' : 'images/time.png'},
	 	{'url' : 'images/true.png'},
	 	{'url' : 'images/loading.png'},
	 	{'url' : 'images/success.gif'},
	 	{'url' : 'images/warning.png'}
	];
	var window_w = document.documentElement.scrollWidth || document.body.scrollWidth,
		window_h = document.documentElement.scrollHeight || document.body.scrollHeight,
		loading = document.getElementById('loading'),
		index = document.getElementById('index'),
		avatar = document.getElementById('avatar'),
		nickname = document.getElementById('nickname'),
		lv = document.getElementById('lv'),
		exp = document.getElementById('exp'),
		ranking_loading = document.getElementById('ranking-loading'),
		ranking_avatar = document.getElementById('ranking-avatar'),
		ranking_nickname = document.getElementById('ranking-nickname'),
		ranking_city = document.getElementById('ranking-city'),
		ranking_lv = document.getElementById('ranking-lv'),
		ranking_gold = document.getElementById('ranking-gold'),
		user_gold = document.getElementById('user-gold'),
		ranking = document.getElementById('ranking'),          //rank
		gold = document.getElementById('gold'),          //gold
		setting = document.getElementById('setting'),       //setting
		ranking_list_btn = document.getElementById('ranking-list-btn'),  //ranking_list
		goods = document.getElementById('goods'),         //goods
		shop = document.getElementById('shop'),          //shop
		ranking_close = document.getElementById('ranking-close'),
		ranking_loading_close = document.getElementById('ranking-loading-close'),
		ranking_list = document.getElementById('ranking-list'),
		loading = document.getElementById('loading'),
		loading_logo = document.getElementById('loading-logo'),
		loading_num = document.getElementById('loading-num'),
		loading_process = document.getElementById('loading-process'),
		loading_process_now = document.getElementById('loading-process-now'),
		ranking_main = document.getElementById('ranking-main'),
		pk = document.getElementById('pk'),
		pk_info = document.getElementById('pk-info'),
		message = document.getElementById('message'),
		message_info = document.getElementById('message-info'),
		pk_process_left = document.getElementById('pk-process-left'),
		pk_process_right = document.getElementById('pk-process-right'),
		pk_process_left_num = document.getElementById('pk-process-left-num'),
		pk_process_right_num = document.getElementById('pk-process-right-num');

	var ranking_main_max = 100; //排行榜最多获取100名
	var is_active = 0;       //0待定状态 1活动进行中 -4002活动尚未开始   -4003活动已经结束
	var countdown = 10;      //倒计时

	//------------------------------------------------------------------基础操作类-----start----------------------------
	var Base = window.Base = function() {

	};

	Base.prototype.dom = function(id, _class, callback) {
		var doms = id.childNodes;
		for (var i = 0; i < doms.length; i++) {
			if (doms[i].className == _class) {
				if (callback && typeof(callback) === "function")
					callback();
				return doms[i];
			}
		}
	};

	//更改标题
	Base.prototype.title = function(title) {
		document.title = title;
	};

	//往上弹出
	Base.prototype.top = function(dom, callback) {
		var self = this;
		setTimeout(function() {
			var top = parseInt(dom.offsetTop);
			if (top > 0) {
				top -= 15;
				top = top > 0 ? top : 0;
				dom.style.top = top + 'px';
				self.top(dom, callback);
				if (top == 0 && callback && typeof(callback) === "function")
					callback();
			}
		}, 1);
	};

	//往下退出
	Base.prototype.topBack = function(dom, callback) {
		var self = this;
		setTimeout(function() {
			var top = parseInt(dom.offsetTop);
			if (top < window_h) {
				top += 15;
				top = top < window_h ? top : window_h;
				dom.style.top = top + 'px';
				self.topBack(dom, callback);
				if (callback && typeof(callback) === "function")
					callback();
			}
		}, 1);
	};

	//往左弹出
	Base.prototype.left = function(dom, callback) {
		var self = this;
		setTimeout(function() {
			var left = parseInt(dom.offsetLeft);
			if (left > 0) {
				left -= 15;
				left = left > 0 ? left : 0;
				dom.style.left = left + 'px';
				self.left(dom);
				if (callback && typeof(callback) === "function")
					callback();
			}
		}, 1);
	};

	//更改css
	Base.prototype.css = function(dom, obj, callback) {
		var keys = new Array(),
			len = 0;
		for(var key in obj) {
			keys.push(key);
			len++;
		}
		for (var i = 0; i < len; i++) {
			dom.style[keys[i]] = obj[keys[i]];
		}
		if (callback && typeof(callback) === "function")
			callback();
	};

	//获取css属性
	Base.prototype.getCss = function(dom, attribute) {
        return dom.currentStyle ? dom.currentStyle[attribute] : window.getComputedStyle(dom, null)[attribute];
	};

	//ajax
	Base.prototype.ajax = function(obj, callback) {
		var keys = new Array(),
			data = obj.data ? obj.data : '',
			_data = '',
			len = 0;
		// console.log(data.length);
		if (data) {
			for(var key in data) {
				keys.push(key);
				len++;
			}
			for (var i = 0; i < len; i++) {
				_data += i == len - 1 ? keys[i] + '=' + data[keys[i]] : keys[i] + '=' + data[keys[i]] + '&';
			}

		}

		var xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4) {
				var data = JSON.parse(xhr.responseText);
				if (callback && typeof(callback) === "function") {
					callback(data);
				}
			}
		}

		xhr.open(obj.type, obj.url, true);
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		xhr.send(_data);
	};

	//ajax返回基础处理函数
	Base.prototype.response = function(data) {
		console.log(data.message);
		switch(data.code) {
			case 201:
				//匹配到对手了
				PK.status = 1;
				PK.start(data.data);
				break;
			case 202:
				//对手掉线或者逃跑
				Message.show('fail', '游戏数据异常，将退出本次游戏');
				PK.close();
				PK.status = 0;
				break;
			case 203:
				//回答正确
				// clearTimeout(PK.countdown_id);
				// PK.countdown_id = '';
				// PK.countdown(0);
				PK.iAmRight();
				break;
			case 204:
				//对方回答正确
				break;
			case 205:
				//回答错误
				break;
			case 206:
				//对方回答错误
				break;
			case -1:
				Message.show('warning', data.message);
				return false;
				break;
			case -4001:
				Message.show('warning', '系统出现了一些错误，请稍后再试');
				return false;
				break;
			case -4002:   //活动尚未开始
				is_active = data.code;
				Game.active(data.code);
				return false; 
				break;
			case -4003:   //活动已结束
				is_active = data.code;
				Game.active(data.code);
				return false;
				break;
			case -4004:
				Message.show('fail', '游戏尚未配置上线成功，请联系管理员', 9999999);
				return false;
				break;
			case -4005:
				Message.show('warning', '请勿重复登录...', 9999999);
				return false;
			case -4006:
				Message.show('warning', data.message);
				setTimeout(function() {
					Ranking.quit();
				}, 1000);
				return false;
			case -4007:
				Message.show('warning', data.message);
				setTimeout(function() {
					Ranking.quit();
				}, 1000);
				return false;
				break;
			case -4008:
				Message.show('fail', '游戏数据异常，将退出本次游戏');
				PK.close();
				return false;
				break;
			case -4009:
				Message.show('fail', '游戏数据异常，将退出本次游戏。');
				PK.close();
				return false;
				break;
		}
		return true;
	};

	//获取URL的参与
	Base.prototype.reuqestGet = function(param) {
		var url = location.href;
		//判断是否有参数
		// console.log(url.indexOf('?'));
		if (url.indexOf('?') == -1)
			return '';
		var _params = url.split('?');
		_params = _params[1];
		if (_params.indexOf('&') == -1) {
			_params = _params.split('=');
			return _params[0] == param ? _params[1] : '';
		} else {
			_params = _params.split('&');
			console.log(_params);
			for (var i = 0; i < _params.length; i++) {
				_params[i] = _params[i].split('=');
				if (_params[i][0] == param)
					return _params[i][1];
			}
		}
	};
	//------------------------------------------------------------------基础操作类-----end------------------------------

	//--------------------------------------------------------------------信息提示类---------------------------
	var Message = window.Message = function() {
		this.status = true;
		this.setTimeOutID = '';
	};


	//提示信息
	Message.prototype.show = function(type, msg, time) {
		var self = this;
		time = !time ? 2000 : time; 
		switch(type) {
			case 'success': 
				var img = 'images/success.gif';
				break;
			case 'fail':
				var img = 'images/fail.png';
				break;
			case 'warning':
				var img = 'images/warning.png';
				break;
		}
		message.getElementsByTagName('img')[0].setAttribute('src', img);
		message_info.innerHTML = msg;

		if (self.status == false) {
			clearTimeout(this.setTimeOutID);
			this.setTimeOutID = '';
		} else {
			self.status = false;
			message.setAttribute('class', 'animated bounceInDown');
		}

		Base.css(message, {'display':'block'}, function() {
			self.setTimeOutID = setTimeout(function() {
				message.setAttribute('class', 'animated bounceOutUp');
				self.status = true;
				self.setTimeOutID = '';
			}, time);
		});
	};


	//停止消息提示
	Message.prototype.hide = function() {
		if (this.setTimeOutID != '') {
			clearTimeout(this.setTimeOutID);
			this.setTimeOutID = '';
		}

		if (this.status == false) {
			message.setAttribute('class', 'animated bounceOutUp');
			self.status = true;
			self.setTimeOutID = '';
		}
	}


	//------------------------------------------------------------------游戏-----start------------------------------
	var Game = window.Game = function() {
		this.loadingNowNum = 0;
		this.loadingNum = 0;
	};

	//读取游戏资源
	Game.prototype.loadingAllResource = function(callback) {
		var self = this;
		//计数器
		var allReadyDoneNumber = 0;
		//遍历数组
		var RobjLen = images.length;
		for (var i = 0; i < RobjLen; i++) {
			var url = images[i]['url'];
			images[i] = new Image();
			images[i].src = url;
			images[i].onload = function() {
				allReadyDoneNumber++;
				self.loadingNum = parseInt(allReadyDoneNumber / RobjLen * 100);
				Game.loading();
				if (allReadyDoneNumber == RobjLen && callback && typeof(callback) === "function") {
					callback();
				}
			}
		}
	};

	//进度数字 / 进程读条
	Game.prototype.loading = function() {
		var self = this;
		setTimeout(function() {
			if (self.loadingNowNum < self.loadingNum) {
				self.loadingNowNum++;
				loading_num.innerHTML = self.loadingNowNum + '%';
				loading_process_now.style.width = parseInt(loading_process.offsetWidth * self.loadingNowNum / 100) + 'px';
				Game.loading();
			}
		},1);
	};

	//开始游戏
	Game.prototype.go = function(data) {
		Game.loadingAllResource(function() {
	    	setTimeout(function() {
	    		loading_logo.setAttribute('class', 'mainOut');
	    		Base.css(loading_num, {'display' : 'none'});
	    		Base.css(loading_process, {'display' : 'none'});
	    		Base.css(loading_process_now, {'display' : 'none'});

		    	setTimeout(function() {
		    		Base.css(loading, {'display' : 'none'});
		    		Base.css(index, {'display' : 'block'});
		    	}, 500);

		    	setTimeout(function() {
		    		User.init(data.user);
		    		is_active = data.is_active;
				    WsServicer.connection();
				    WsServicer.heartbeat();
		    	}, 1000);
	    	}, 500);
	    });
	};

	//活动状态
	Game.prototype.active = function() {
		switch(is_active) {
			// case 0:
			// 	Message.show('warning', '正在连接服务器。。。');
			// 	return false;
			// 	break;
			case -4002:
				Message.show('warning', '活动尚未开始');
				return false;
				break;
			case -4003:
				Message.show('warning', '活动已经结束');
				return false;
				break;
		}
		return true;
	};

	//------------------------------------------------------------------游戏-----end------------------------------


	//------------------------------------------------------------------用户类操作-----start----------------------------
	var User = window.User = function() {
		// this.init();
	};

	//初始化用户数据
	User.prototype.init = function(user) {
		this.u_id = user.u_id;
		this.avatar = user.wx_avatar;
		this.nickname = user.nickname;
		this.city = user.city;
		this.lv = user.lv;
		this._exp = 0;
		this.exp = user.exp;
		this._gold = 0;
		this.gold = user.gold;
		this.unique_token = user.unique_token;
		this.goldSum = parseInt(user.gold / 133);

		//头像
		avatar.getElementsByTagName('img')[0].setAttribute('src', this.avatar);
		ranking_avatar.getElementsByTagName('img')[0].setAttribute('src', this.avatar);

		//昵称
		nickname.innerHTML = this.nickname;
		ranking_nickname.innerHTML = this.nickname;

		//lv
		lv.getElementsByTagName('span')[0].innerHTML = this.lv;
		ranking_lv.getElementsByTagName('span')[0].innerHTML = this.lv;

		//地区
		ranking_city.innerHTML = this.city;

		//金币
		ranking_gold.getElementsByTagName('span')[0].innerHTML = this.gold;

		this.expTimer();
		this.goldTimer();
	};

	//经验条动画
	User.prototype.expTimer = function() {
		var self = this;
		setTimeout(function() {
			self._exp++;
			exp.style.width = self._exp + 'px';
			if (self._exp < self.exp)
				self.expTimer();
		}, 10);
	};

	//金币动画
	User.prototype.goldTimer = function() {
		var self = this;
		setTimeout(function() {
			self.gold - self._gold < self.goldSum ? self._gold++ : self._gold += self.goldSum;
			user_gold.getElementsByTagName('span')[0].innerHTML = self._gold;
			if (self._gold < self.gold)
				self.goldTimer();
		}, 1);
	};

	//------------------------------------------------------------------用户类操作-----end----------------------------

	//------------------------------------------------------------------排位操作-----start----------------------------
	var Ranking = window.Ranking = function() {
		this.cir_0 = Base.dom(ranking_loading, 'cir_0');
		this.cir_1 = Base.dom(ranking_loading, 'cir_1');
		this.cir_2 = Base.dom(ranking_loading, 'cir_2');
		this.status = 0;
		this.offset = 0;
		this.limit = 20;
		this.html = '';
		this.loadingHtml = '<div class="loading"><img class="spin" src="images/loading.png"><span>正在加载中...</span></div>';
		this.endingHtml = '<div class="loading"><span>已经到底啦~</span></div>';
		this.loadingFlag = true;
	};

	//排位开始排位--开始转圈
	Ranking.prototype.start = function() {
		var self = this;
		self.status = 1;
		setTimeout(function() {
			self.cir_1.setAttribute('class', 'cir_1 cir_1_0');
			self.cir_2.setAttribute('class', 'cir_2 cir_1_5');
		},200);
	};

	//取消排位排队--取消转圈
	Ranking.prototype.stop = function() {
		this.cir_1.setAttribute('class', 'cir_1');
		this.cir_2.setAttribute('class', 'cir_2');
	};

	//关闭排位排队
	Ranking.prototype.quit = function() {
		if (PK.status == 1)
    		return false;
    	PK.status = 0;
    	this.status = 0;
    	Base.title(params.title);
    	Ranking.stop();
    	Base.topBack(ranking_loading);
	};

	//重置状态
	Ranking.prototype.reset = function() {
		this.cir_0.setAttribute('class', 'cir_0');
		this.cir_1.setAttribute('class', 'cir_1');
		this.cir_2.setAttribute('class', 'cir_2');
		ranking_avatar.setAttribute('class', '');
		ranking_loading.getElementsByTagName('ul')[0].setAttribute('class', '');
		ranking_loading_close.setAttribute('class', '');
	}

	//匹配到对手动画
	Ranking.prototype.moveTop = function(callback) {
		if (PK.status == 0)
			return false;
		this.cir_0.setAttribute('class', 'cir_0 ' + animated.bounceOutUp);
		this.cir_1.setAttribute('class', 'cir_1 ' + animated.bounceOutUp);
		this.cir_2.setAttribute('class', 'cir_2 ' + animated.bounceOutUp);
		ranking_avatar.setAttribute('class', animated.bounceOutUp);
		ranking_loading.getElementsByTagName('ul')[0].setAttribute('class', animated.bounceOut);
		ranking_loading_close.setAttribute('class', animated.bounceOut);
		if (callback && typeof(callback) === "function")
			callback();
	};

	//获取排行榜
	Ranking.prototype.lists = function() {
		var self = this;
		self.loadingFlag = false;
		if (self.offset + 1 >= ranking_main_max)
			return false;
		var html1 = '<li class="ranking-user"> \
                		<div class="ranking-sort"><img src="{{num}}"></div> \
                		<div class="ranking-avatar"><img src="{{avatar}}"></div> \
                		<div class="ranking-info"><span>{{nickname}}</span><span>{{city}}</span></div> \
                		<div class="ranking-lv"><span class="ranking-grade">{{lv_name}}</span><span>LV.{{lv}}</span></div> \
        			</li>';
        var html2 = '<li class="ranking-user"> \
                		<div class="ranking-sort"><span>{{num}}</span></div> \
                		<div class="ranking-avatar"><img src="{{avatar}}"></div> \
                		<div class="ranking-info"><span>{{nickname}}</span><span>{{city}}</span></div> \
                		<div class="ranking-lv"><span class="ranking-grade">{{lv_name}}</span><span>LV.{{lv}}</span></div> \
        			</li>';
        Base.ajax({
        	'type' : 'GET',
        	'url' : api.http_server + api.ranking_list,
        	'data' : {
        		offset : self.offset,
        		limit : self.limit
        	}
        }, function(data) {
       		if (!Base.response(data))
       			return false;
       		if (data.code == 200) {
	       		var len = data.data.length;
	       		var allHtml = '';
	       		for (var i = 0; i < len; i++) {
	       			switch (self.offset + 1) {
	       				case 1 :
	       					var _html = html1;
	       					_html = _html.replace(/{{num}}/, 'images/first.png');
	       					break;
	       				case 2 :
	       					var _html = html1;
	       					_html = _html.replace(/{{num}}/, 'images/sercond.png');
	       					break;
	       				case 3 :
	       					var _html = html1;
	       					_html = _html.replace(/{{num}}/, 'images/third.png');
	       					break;
	       				default :
	       					var _html = html2;
	       					_html = _html.replace(/{{num}}/, self.offset + 1);
	       					break;
	       			}
	       			
	       			_html = _html.replace(/{{avatar}}/, data['data'][i]['wx_avatar']);
	       			_html = _html.replace(/{{nickname}}/, data['data'][i]['nickname']);
	       			_html = _html.replace(/{{city}}/, data['data'][i]['city']);
	       			_html = _html.replace(/{{lv_name}}/, data['data'][i]['lv_name']);
	       			_html = _html.replace(/{{lv}}/, data['data'][i]['lv']);
	       			self.offset += 1;
	       			self.html += _html;
	       		}
	       		ranking_main.innerHTML = self.offset == ranking_main_max || len < self.limit ? self.html + self.endingHtml : self.html + self.loadingHtml;
	       		self.loadingFlag = true;
       		}
       		// console.log(allHtml);
       	});
	};

	
	//------------------------------------------------------------------排位操作-----end----------------------------


	//------------------------------------------------------------------PK-----start----------------------------
	var PK = window.PK = function() {
		self.status = 0;  //0寻求队列中   1找到对手
		self.headerHtml = '';
		self.currentTopicNum = 0;
		self.topicTotalNum = 0;
		self.topic = {};
		self.itemStatus = 0;
		self.itemSelect = '';
	};

	//PK开始加载动画
	PK.prototype.start = function(data) {
		var self = this;
		PK.topic = data.topics;
		PK.topicTotalNum = data.topics.length;
		PK.currentTopicNum = 0;
		PK.countdown_id = '';
		PK.process_left = 0;
		PK.process_rifht = 0;

		var opponents = data.user;
		var html = '<div class="pk_0 animated bounceInLeft"> \
			            <div><img src="' + User.avatar + '"></div> \
			            <span>' + User.nickname + '</span> \
			            <br > \
			            <span>来自:' + User.city + '</span> \
			        </div> \
			        <div class="pk_1 animated bounceInRight"> \
			            <div><img src="' + opponents.wx_avatar + '"></div> \
			            <span>' + opponents.nickname + '</span> \
			            <br > \
			            <span>来自:' + opponents.city + '</span> \
			        </div> \
			        <img id="pk-logo" class="animated zoomIn" src="images/title.png">';

		pk_info.innerHTML = html;

		PK.headerHtml = '<div id="pk-header"> \
			            <div id="pk-user-left"> \
			                <img src="' + User.avatar + '"> \
			            </div> \
			            <div id="pk-time"> \
			                <div id="pk-time-num">' + countdown + '</div> \
			            </div> \
			            <div id="pk-user-right"> \
			                <img src="' + opponents.wx_avatar + '"> \
			            </div> \
			        </div>';

		Ranking.moveTop(function() {
			setTimeout(function() {
				Base.css(pk_info, {'display' : 'block'});
				Base.css(ranking_loading, {'top' : '100%'}, function() {
					Ranking.reset();
					pk.innerHTML = self.headerHtml + PK.topicHtml(PK.topic, PK.currentTopicNum);
					Base.css(document.getElementById('pk-main'), {'width' : clientCssWidth + 'px'});
					self.itemBindClick(PK.topic[0]['a'], PK.topic[0]['b'], PK.topic[0]['c'], PK.topic[0]['d']);

					setTimeout(function() {
						Base.css(pk, {'display' : 'block'});
						PK.countdown(countdown);
					}, 2000)
				});
			},1000);
		});
	};

	//PK倒计时
	PK.prototype.countdown = function(_countdown) {
		var self = this;

		PK.countdown_id = setTimeout(function() {
			if (_countdown == 0) {
				PK.currentTopicNum += 1;

				if (PK.currentTopicNum == PK.topicTotalNum) {
					console.log('finish');
					//答题完毕
					return '';
				}

				pk.innerHTML = PK.headerHtml + PK.topicHtml(PK.topic, PK.currentTopicNum);
				Base.css(document.getElementById('pk-main'), {'width' : clientCssWidth + 'px'});
				_countdown = countdown;

				PK.itemStatus = 0;

				setTimeout(function() {
					self.itemBindClick(PK.topic[PK.currentTopicNum]['a'], PK.topic[PK.currentTopicNum]['b'], PK.topic[PK.currentTopicNum]['c'], PK.topic[PK.currentTopicNum]['d']);
				}, 200);
			} else {
				_countdown--;
				document.getElementById("pk-time-num").innerText = _countdown;
			}

			PK.countdown(_countdown)
		}, 1000);
		return '';
	};

	//PK题目渲染
	PK.prototype.topicHtml = function(topic, i) {
		var html = '<div id="pk-main"  class="animated bounceIn"> \
			            {{topic}}<span id="question-num">{{i}}</span> \
			        </div> \
			        <div id="pk-footer"> \
			            <div id="pk-process-left"> \
			                <div id="pk-process-left-num"></div> \
			            </div> \
			            <div id="pk-item-main">';

		if (topic[i].a) {
			html += '<div id="item_a" class="animated slideInUp"> \
 	                    <div class="my-answer"><img src="images/true.png"></div> \
 	                    <div class="options">{{item_a}}</div> \
 	                    <div class="opponent-answer"><img src="images/false.png"></div> \
 	                </div>';

 	        html = html.replace(/{{item_a}}/, topic[i].a);
		}

		if (topic[i].b) {
			html += '<div id="item_b" class="animated slideInUp"> \
 	                    <div class="my-answer"><img src="images/true.png"></div> \
 	                    <div class="options">{{item_b}}</div> \
 	                    <div class="opponent-answer"><img src="images/false.png"></div> \
 	                </div>';

 	        html = html.replace(/{{item_b}}/, topic[i].b);
		}

		if (topic[i].c) {
			html += '<div id="item_c" class="animated slideInUp"> \
 	                    <div class="my-answer"><img src="images/true.png"></div> \
 	                    <div class="options">{{item_c}}</div> \
 	                    <div class="opponent-answer"><img src="images/false.png"></div> \
 	                </div>';

 	        html = html.replace(/{{item_c}}/, topic[i].c);
		}

		if (topic[i].d) {
			html += '<div id="item_d" class="animated slideInUp"> \
 	                    <div class="my-answer"><img src="images/true.png"></div> \
 	                    <div class="options">{{item_d}}</div> \
 	                    <div class="opponent-answer"><img src="images/false.png"></div> \
 	                </div>';

 	        html = html.replace(/{{item_d}}/, topic[i].d);
		}

		html +=	'</div> \
		            <div id="pk-process-right"> \
		                <div id="pk-process-right-num"></div> \
		            </div> \
		        </div>';

		html = html.replace(/{{i}}/, i + 1);
		html = html.replace(/{{topic}}/, topic[i].question);
		return html;
	};

	//PK答案绑定事件
	PK.prototype.itemBindClick = function(a, b, c, d) {
		console.log(a, b, c, d)
		if (a)
			document.getElementById('item_a').onclick = this.itemClick;

		if (b)
			document.getElementById('item_b').onclick = this.itemClick;

		if (c)
			document.getElementById('item_c').onclick = this.itemClick;

		if (d)
			document.getElementById('item_d').onclick = this.itemClick;

	};

	//PK答案点击事件
	PK.prototype.itemClick = function() {
		var self = this;

		if (PK.itemStatus == 1)
			return false;

		PK.itemStatus = 1;

		data = WsServicer.itemSelect;

		data.data.current_num = PK.currentTopicNum;
		switch (this.id) {
			case 'item_a': 
				PK.itemSelect = 'a';
				data.data.item = 'a';
				break;
			case 'item_b': 
				PK.itemSelect = 'b';
				data.data.item = 'b';
				break;
			case 'item_c': 
				PK.itemSelect = 'c';
				data.data.item = 'c';
				break;
			case 'item_d': 
				PK.itemSelect = 'd';
				data.data.item = 'd';
				break;
			default:
				return false;
		}

		var ds = {
    		'data' : {},
    		'message' : '203~~~~~',
    		'code' : 203
    	};
    	Base.response(ds);
		// WsServicer.send(data);
	};


	//出现网络错误关闭PK
	PK.prototype.close = function() {
		//清空秒数倒计时
		if (PK.countdown_id != '') {
			clearTimeout(PK.countdown_id);
			PK.countdown_id = '';
		}

		//清空页面
		Base.css(pk, {'display' : 'none'});
		Base.css(pk_info, {'display' : 'none'});

		PK.status = 0;

		pk_info.innerHTML = '';
		pk.innerHTML = '';
	};


	//我回答正确
	PK.prototype.iAmRight = function() {
		var item = document.getElementById('item_' + PK.itemSelect);
		item.setAttribute('class', 'answer-true');

	};

	//更新进度条
	PK.prototype.processUpdate = function(direction, percent) {
		switch (direction) {
			case 'left':
				dom = pk_process_left_num;
				p_dom = pk_process_left;
				_percent = PK.process_left;
				PK.process_left++;
				break;
			case 'right':
				dom = pk_process_right_num;
				p_dom = pk_process_right;
				_percent = PK.process_right;
				PK.process_right++;
				break;
		}

		if (_percent < percent) {
			_percent++;
			Base.css(dom, {'height' : _percent + '%'});
			setTimeout(function() {
				PK.processUpdate(direction, percent);
			}, 20);
		}
	};

	//------------------------------------------------------------------PK-----end----------------------------


	//------------------------------------------------------------------连接Websocket-----start----------------------------
	var WsServicer = window.WsServicer = function() {
		this.host = 'ws://192.168.26.129';
		// this.host = 'ws://192.168.83.133';
		this.prot = '9501';
		
	};

	//初始化数据
	WsServicer.prototype.init = function() {
		this.status;

		//加入排队
		this.pkStart = {
			'case' : 'join_ranking',
			'data' : {}
		};

		//退出排队
		this.quitQueue = {
			'case' : 'quit_ranking',
			'data' : {}
		};

		//发送答案
		this.itemSelect = {
			'case' : 'item_select',
			'data' : {
				'item' : '',
				'current_num': 0
			}
		};
	};

	//打开连接
	WsServicer.prototype.connection = function() {
		var self = this;
		this.ws = new WebSocket(this.host + ':' + this.prot + '?u_id=' + User.u_id + '&unique_token=' + User.unique_token);
		this.ws.onopen = function(e) {
			self.open();
		};

		this.ws.onmessage = function(e) {
			self.message(e);
		};

		this.ws.onclose = function(e) {
			self.close(e);
		};

		this.ws.onerror = function(e) {
			self.error(e);
		};

		this.init();
	};

	//连接成功
	WsServicer.prototype.open = function(e) {
		console.log('WebSocket connection success');
	};

	//接收信息
	WsServicer.prototype.message = function(e) {
		var data = JSON.parse(e.data);
		Base.response(data);
		
		console.log(data);
	};

	//连接关闭
	WsServicer.prototype.close = function(e) {
		WsServicer.closePage();

		console.log('WebSocket connection close');
		Message.show('warning', '网络异常，正在为您重新连接，请检查您的网络是否异常', 20000);
	};

	//连接错误
	WsServicer.prototype.error = function(e) {
		WsServicer.closePage();

		console.log('WebSocket connection fail');
		Message.show('warning', '服务器出现异常，请稍后再试', 99999999);
	};

	//发送消息
	WsServicer.prototype.send = function(data) {
		data = JSON.stringify(data);
		if (this.ws.readyState != 1){
			console.log('current execute resend', data);
			this.connection();

			setTimeout(function() {
				if (WsServicer.ws.readyState == 1) {
					Message.show('success', '已成功重新连接服务器', 1000);
					WsServicer.ws.send(data);
				}
			}, 500);
		} else {
			console.log('current execute send', data);
			this.ws.send(data);
		}
	};

	//发送心跳包
	WsServicer.prototype.heartbeat = function(time) {
		var self = this;
		time = !time ? 10000 : time;

		setTimeout(function() {
			var heartbeat = {
				'case' : 'heartbeat'
			};
			self.send(heartbeat);
			self.heartbeat(time);
		}, time)
	};

	//发送失败
	WsServicer.prototype.sendFail = function(data) {
		data = data == '' ? '{"case":"none"}' : JSON.parse(data);

		switch(data.case) {
			case 'pk_queue':
				//退出排队
				setTimeout(function() {
					Ranking.quit();
				}, 2000);
				break;
		}

		this.connection();
		setTimeout(function() {
			if (WsServicer.ws.readyState != 1) {
				this.sendFail();
			} else {
				Message.hide();
				setTimeout(function() {
					Message.show('success', '服务器连接成功');
				}, 500);
			}
		}, 500);
	};

	WsServicer.prototype.closePage = function() {
		if (PK.status == 1) {
			PK.status = 0;
			PK.close();
		}

		if (Ranking.status == 1) {
			Ranking.quit();
		}
	};
	//------------------------------------------------------------------连接Websocket-----end----------------------------

	var Base = new Base();
	var Message = new Message();
	var Game = new Game();
	var Ranking = new Ranking();
	var User = new User();
	var PK = new PK();
	var WsServicer = new WsServicer();

	Base.ajax({
    	'type' : 'GET',
    	'url' : api.http_server + api.user_info + '/' + Base.reuqestGet('u_id'),
    }, function(data) {
   		if (!Base.response(data))
   			return false;
   		if (data.code == 200) {
   			Game.go(data.data);
   		}
   	});
    
    Base.title(params.title);

    
    //打开排行榜
    ranking_list_btn.onclick = function() {
    	Base.title(params.ranking_list);
    	Base.top(ranking_list, function() {
    		if (Ranking.loadingFlag)
    			Ranking.lists();
    	});
    };

    //排行榜滚动加载更多
    ranking_main.onscroll = function(e) {
    	var bottom = e.srcElement.scrollHeight - e.srcElement.scrollTop - e.srcElement.clientHeight;
    	if (bottom <= 50 && Ranking.loadingFlag) {
    		Ranking.loadingFlag = false;
    		Ranking.lists();
    	}
    }

    //关闭排行榜
    ranking_close.onclick = function() {
    	Base.title(params.title);
    	Base.topBack(ranking_list, function() {
    		ranking_main.innerHTML = Ranking.loadingHtml;
	    	Ranking.loadingFlag = true;
	    	Ranking.offset = 0;
	    	Ranking.html = '';
    	});
    };

    //排位排队按钮
    ranking.onclick = function() {
    	if (!Game.active(is_active))
    		return false;
    	Base.title(params.ranking_loading);
    	Base.top(ranking_loading, function() {
    		Ranking.start();
    		WsServicer.send(WsServicer.pkStart);
    		// setTimeout(function() {
    		// 	PK.status = 1;
    		// 	PK.start();
    		// },2000);
    	});
    };

    //排位排队关闭按钮
    ranking_loading_close.onclick = function() {
    	if (PK.status == 1) {
    		Message.show('warning', '已经匹配到对手了...');
    		return false;
    	}
    	WsServicer.send(WsServicer.quitQueue);
    	Ranking.quit();
    };

    //模拟打开匹配成功
    shop.onclick = function() {
    	var ds = {
    		'data' : {
    			'user' : {
    				'a_id' : 1,
	    			'city' : '广州市',
	    			'lv' : 20,
	    			'nickname' : '邻里圈牛逼',
	    			'u_id' : 2,
	    			'wx_avatar' : 'http://192.168.26.129/answer/web/images/avatar.png'
    			},
    			'total_question' : 10,
    			'topics' : [
    				{
    					'ts_id' : 1,
    					'question' : '大煮干丝”是哪个菜系的代表菜之一',
    					'img' : '',
    					'a' : '四川菜系',
    					'b' : '山东菜系',
    					'c' : '广东菜系',
    					'd' : '淮扬菜系',
    				},
    				{
    					'ts_id' : 2,
    					'question' : '红茶属于_____茶',
    					'img' : '',
    					'a' : '半发酵',
    					'b' : '发酵',
    					'c' : '不发酵',
    					'd' : '微发酵',
    				},
    				{
    					'ts_id' : 1,
    					'question' : '吃冰淇淋不解渴主要是因为它',
    					'img' : '',
    					'a' : '含蛋白质',
    					'b' : '含脂肪',
    					'c' : '含糖',
    					'd' : '',
    				}
    			]
    		},
    		'message' : '匹配到对手啦~',
    		'code' : 201
    	};
    	WsServicer.connection();
    	Base.response(ds);
    }

    document.getElementById('item_d').onclick = function() {
    	var ds = {
    		'data' : {
    			'user' : {
    				'a_id' : 1,
	    			'city' : '广州市',
	    			'lv' : 20,
	    			'nickname' : '邻里圈牛逼',
	    			'u_id' : 2,
	    			'wx_avatar' : 'http://192.168.26.129/answer/web/images/avatar.png'
    			},
    			'total_question' : 10,
    			'topics' : [
    				{
    					'ts_id' : 1,
    					'question' : '大煮干丝”是哪个菜系的代表菜之一',
    					'img' : '',
    					'a' : '四川菜系',
    					'b' : '山东菜系',
    					'c' : '广东菜系',
    					'd' : '淮扬菜系',
    				},
    				{
    					'ts_id' : 2,
    					'question' : '红茶属于_____茶',
    					'img' : '',
    					'a' : '半发酵',
    					'b' : '发酵',
    					'c' : '不发酵',
    					'd' : '微发酵',
    				},
    				{
    					'ts_id' : 1,
    					'question' : '吃冰淇淋不解渴主要是因为它',
    					'img' : '',
    					'a' : '含蛋白质',
    					'b' : '含脂肪',
    					'c' : '含糖',
    					'd' : '',
    				}
    			]
    		},
    		'message' : '匹配到对手啦~',
    		'code' : 201
    	};
    	Base.response(ds);
  //   	PK.topicTotalNum = data.topics.length;
		// PK.currentTopicNum = 0;
		// PK.countdown_id = '';
		// PK.process_left = 0;
		// PK.process_rifht = 0;
    	PK.process_left += 1;
    	var per =  PK.process_left / parseInt((PK.topicTotalNum / 2) + 1) * 100;
    	// console.log(per);
    	// Base.css(direction_id, {'height' : per + '%'});
    	PK.processUpdate('left', per);
    };

    // setTimeout(function() {
    // 	Base.css(loading, {'display' : 'none'});
    // 	Base.css(index, {'display' : 'block'});
    // },1000);
})();