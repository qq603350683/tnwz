/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : tncj

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-04-23 08:13:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `a_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL COMMENT '登录账户',
  `password` char(40) NOT NULL COMMENT '密码',
  `name` varchar(10) NOT NULL COMMENT '客户姓名',
  `company` varchar(20) NOT NULL COMMENT '客户公司名称',
  `email` varchar(50) NOT NULL COMMENT '客户邮箱',
  `phone` char(11) NOT NULL COMMENT '客户联系电话',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `last_login_time` int(10) NOT NULL,
  `admin_type` tinyint(1) NOT NULL COMMENT '0普通管理员   1超级管理员',
  `nav` varchar(255) NOT NULL COMMENT '导航栏',
  `amount` decimal(10,2) unsigned NOT NULL COMMENT '余额',
  `end_time` int(10) unsigned NOT NULL COMMENT '活动持续结束时间',
  `create_time` int(10) unsigned NOT NULL COMMENT '账户创建时间',
  PRIMARY KEY (`a_id`),
  UNIQUE KEY `username` (`username`),
  KEY `phone` (`phone`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES ('1', 'admin', '123456', '超级管理员', '微想网络科技', '', '', '', '0', '1', '', '0.00', '0', '1533384915');

-- ----------------------------
-- Table structure for admins_configs
-- ----------------------------
DROP TABLE IF EXISTS `admins_configs`;
CREATE TABLE `admins_configs` (
  `ac_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL COMMENT '键',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT '值',
  `unit` varchar(10) NOT NULL,
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`ac_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of admins_configs
-- ----------------------------
INSERT INTO `admins_configs` VALUES ('1', 'begin_time', '2018-08-06 20:16:43', '', '活动开始时间');
INSERT INTO `admins_configs` VALUES ('2', 'end_time', '2019-10-01 20:16:48', '', '活动结束时间');

-- ----------------------------
-- Table structure for topics
-- ----------------------------
DROP TABLE IF EXISTS `topics`;
CREATE TABLE `topics` (
  `t_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` smallint(5) unsigned NOT NULL COMMENT '类型',
  `cate_name` varchar(10) NOT NULL COMMENT '名称',
  `question` varchar(250) NOT NULL COMMENT '问题',
  `img` varchar(50) NOT NULL COMMENT '图片题',
  `a` varchar(10) NOT NULL COMMENT 'A答案',
  `b` varchar(10) NOT NULL COMMENT 'B答案',
  `c` varchar(10) NOT NULL COMMENT 'C答案',
  `d` varchar(10) NOT NULL COMMENT 'D答案',
  `answer` varchar(5) NOT NULL COMMENT '答案选项',
  `status` tinyint(1) NOT NULL COMMENT '-1删除 0下架 1上架',
  `create_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`t_id`),
  KEY `cate_id` (`cate_id`),
  KEY `question` (`question`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of topics
-- ----------------------------
INSERT INTO `topics` VALUES ('1', '1', '其他', '大煮干丝”是哪个菜系的代表菜之一', '', '四川菜系', '山东菜系', '广东菜系', '淮扬菜系', 'd', '1', '0');
INSERT INTO `topics` VALUES ('2', '1', '其他', '红茶属于_____茶', '', '半发酵', '发酵', '不发酵', '微发酵', 'a', '1', '0');
INSERT INTO `topics` VALUES ('3', '1', '其他', '满汉全席起兴于', '', '清代', '唐代', '宋代', '两汉', 'a', '1', '0');
INSERT INTO `topics` VALUES ('4', '1', '其他', '吃冰淇淋不解渴主要是因为它', '', '含蛋白质', '含脂肪', '含糖', '', 'd', '1', '0');
INSERT INTO `topics` VALUES ('5', '1', '其他', '下列哪项是人体的造血器官', '', '心脏', '骨髓', '肾脏', '', 'a', '1', '0');
INSERT INTO `topics` VALUES ('6', '1', '其他', '老三届指的是那几年毕业的初、高中毕业生', '', '1964-1966', '1966-1968', '1969-1971', '', 'b', '1', '0');
INSERT INTO `topics` VALUES ('7', '1', '其他', '博士作为官名最早出现在', '', '秦 ', '汉', '唐', '', 'a', '1', '0');
INSERT INTO `topics` VALUES ('8', '1', '其他', '“谬种流传”最早是宋朝人批评当时的', '', '官场黑暗', '科举制度', '社会风气', '诗词风格', 'b', '1', '0');
INSERT INTO `topics` VALUES ('9', '1', '其他', '《在那遥远的地方》是哪里的民歌', '', '四川民歌', '江苏民歌', '蒙古民歌', '青海民歌', 'e', '1', '0');
INSERT INTO `topics` VALUES ('10', '1', '其他', '人体含水量百分比最高的器官是', '', '肝', '肾', '眼球', '心脏', 'c', '1', '0');
INSERT INTO `topics` VALUES ('11', '1', '其他', '人体最大的解毒器官是', '', '胃', '肾脏', '肝脏', '脾', 'c', '1', '0');
INSERT INTO `topics` VALUES ('12', '1', '其他', '下半旗是把旗子下降到', '', '旗杆的一半处', '下降1米', '下降1.5米', '距离杆顶的1/3处', 'd', '1', '0');
INSERT INTO `topics` VALUES ('13', '1', '其他', '下列地点与电影奖搭配不正确的是', '', '戛纳-金棕榈', '柏林-圣马克金狮', '洛杉矶-奥斯卡 ', '中国-金鸡 ', 'b', '1', '0');
INSERT INTO `topics` VALUES ('14', '1', '其他', '下列哪种邮件如果丢失了，邮局不负赔偿责任', '', '平信', '挂号信', '非保价邮包', '特快专递邮件', 'a', '1', '0');
INSERT INTO `topics` VALUES ('15', '1', '其他', '面哪种酸，人在品尝时不是酸味的', '', '琥珀酸', '苹果酸 ', '柠檬酸', '单宁酸', 'd', '1', '0');

-- ----------------------------
-- Table structure for topics_cates
-- ----------------------------
DROP TABLE IF EXISTS `topics_cates`;
CREATE TABLE `topics_cates` (
  `tc_id` smallint(6) NOT NULL,
  `name` varchar(10) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`tc_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='题目分类表';

-- ----------------------------
-- Records of topics_cates
-- ----------------------------
INSERT INTO `topics_cates` VALUES ('1', '其他', '1');

-- ----------------------------
-- Table structure for topisc_selects
-- ----------------------------
DROP TABLE IF EXISTS `topisc_selects`;
CREATE TABLE `topisc_selects` (
  `ts_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` smallint(5) unsigned NOT NULL COMMENT '类型',
  `cate_name` varchar(10) NOT NULL COMMENT '名称',
  `question` varchar(250) NOT NULL COMMENT '问题',
  `img` varchar(50) NOT NULL COMMENT '图片题',
  `a` varchar(10) NOT NULL COMMENT 'A答案',
  `b` varchar(10) NOT NULL COMMENT 'B答案',
  `c` varchar(10) NOT NULL COMMENT 'C答案',
  `d` varchar(10) NOT NULL COMMENT 'D答案',
  `answer` varchar(5) NOT NULL COMMENT '答案选项',
  `status` tinyint(1) NOT NULL COMMENT '-1删除 0下架 1上架',
  `a_id` int(10) unsigned NOT NULL COMMENT '用户ID',
  `create_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ts_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of topisc_selects
-- ----------------------------
INSERT INTO `topisc_selects` VALUES ('1', '1', '其他', '大煮干丝”是哪个菜系的代表菜之一', '', '四川菜系', '山东菜系', '广东菜系', '淮扬菜系', 'd', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('2', '1', '其他', '红茶属于_____茶', '', '半发酵', '发酵', '不发酵', '微发酵', 'a', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('3', '1', '其他', '满汉全席起兴于', '', '清代', '唐代', '宋代', '两汉', 'a', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('4', '1', '其他', '吃冰淇淋不解渴主要是因为它', '', '含蛋白质', '含脂肪', '含糖', '', 'c', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('5', '1', '其他', '下列哪项是人体的造血器官', '', '心脏', '骨髓', '肾脏', '', 'a', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('6', '1', '其他', '老三届指的是那几年毕业的初、高中毕业生', '', '1964-1966', '1966-1968', '1969-1971', '', 'b', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('7', '1', '其他', '博士作为官名最早出现在', '', '秦 ', '汉', '唐', '', 'a', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('8', '1', '其他', '“谬种流传”最早是宋朝人批评当时的', '', '官场黑暗', '科举制度', '社会风气', '诗词风格', 'b', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('9', '1', '其他', '《在那遥远的地方》是哪里的民歌', '', '四川民歌', '江苏民歌', '蒙古民歌', '青海民歌', 'e', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('10', '1', '其他', '人体含水量百分比最高的器官是', '', '肝', '肾', '眼球', '心脏', 'c', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('11', '1', '其他', '人体最大的解毒器官是', '', '胃', '肾脏', '肝脏', '脾', 'c', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('12', '1', '其他', '下半旗是把旗子下降到', '', '旗杆的一半处', '下降1米', '下降1.5米', '距离杆顶的1/3处', 'd', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('13', '1', '其他', '下列地点与电影奖搭配不正确的是', '', '戛纳-金棕榈', '柏林-圣马克金狮', '洛杉矶-奥斯卡 ', '中国-金鸡 ', 'b', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('14', '1', '其他', '下列哪种邮件如果丢失了，邮局不负赔偿责任', '', '平信', '挂号信', '非保价邮包', '特快专递邮件', 'a', '1', '1', '0');
INSERT INTO `topisc_selects` VALUES ('15', '1', '其他', '面哪种酸，人在品尝时不是酸味的', '', '琥珀酸', '苹果酸 ', '柠檬酸', '单宁酸', 'd', '1', '1', '0');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `u_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(50) NOT NULL COMMENT '昵称',
  `wx_avatar` varchar(250) NOT NULL COMMENT '微信头像',
  `local_avatar` varchar(50) NOT NULL COMMENT '本地头像',
  `openid` varchar(50) NOT NULL,
  `unionid` varchar(50) NOT NULL,
  `sex` tinyint(1) NOT NULL COMMENT '微信用户的性别，值为1时是男性，值为2时是女性，值为0时是未知',
  `province` varchar(50) NOT NULL COMMENT '微信用户个人资料填写的省份',
  `city` varchar(50) NOT NULL COMMENT '微信普通用户个人资料填写的城市',
  `country` varchar(50) NOT NULL COMMENT '国家，如中国为CN',
  `name` varchar(10) NOT NULL COMMENT '姓名',
  `phone` char(11) NOT NULL DEFAULT '-1' COMMENT '手机号码',
  `gold` mediumint(5) unsigned NOT NULL COMMENT '用户金币',
  `exp` int(10) unsigned NOT NULL COMMENT '当前经验',
  `lv_exp` int(10) unsigned NOT NULL COMMENT '升级所需要经验',
  `lv` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '等级',
  `winner_rate` decimal(4,2) unsigned NOT NULL COMMENT '胜率',
  `winner_num` smallint(5) unsigned NOT NULL COMMENT '胜利场次',
  `abstained_num` smallint(5) unsigned NOT NULL COMMENT '逃跑场次',
  `game_num` smallint(5) unsigned NOT NULL COMMENT '总场次',
  `a_id` int(10) unsigned NOT NULL COMMENT '项目ID',
  `register_time` int(10) unsigned NOT NULL COMMENT '注册时间',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `status` tinyint(1) NOT NULL,
  `sort` int(10) unsigned NOT NULL,
  `unique_token` varchar(120) NOT NULL,
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `unique_token` (`unique_token`) USING BTREE,
  KEY `openid` (`openid`),
  KEY `phone` (`phone`),
  KEY `item_id` (`a_id`),
  KEY `winner_rate` (`winner_rate`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', '肥宅日常', 'http://192.168.26.129/answer/web/images/avatar.png', '1.jpg', 'feizhairichang', 'feizhairichang', '0', '广东省', '广州市', '中国', '', '-1', '95411', '30', '50', '20', '0.00', '0', '0', '0', '1', '0', '0', '1', '0', 'unique_token');
INSERT INTO `users` VALUES ('2', '总有刁民想害朕', 'http://192.168.26.129/answer/web/images/avatar_2.jpg', '1.jpg', 'feizhairichang', 'feizhairichang', '0', '广东省', '广州市', '中国', '', '-1', '152', '40', '50', '12', '0.00', '0', '0', '0', '1', '0', '0', '1', '0', 'unique_token2');
