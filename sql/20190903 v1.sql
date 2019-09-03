/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : tnwz

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-09-03 15:41:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `a_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账户',
  `password` char(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户姓名',
  `company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户公司名称',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户邮箱',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户联系电话',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `last_login_time` int(10) NOT NULL,
  `admin_type` tinyint(1) NOT NULL COMMENT '0普通管理员   1超级管理员',
  `nav` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '导航栏',
  `amount` decimal(10,2) unsigned NOT NULL COMMENT '余额',
  `end_time` int(10) unsigned NOT NULL COMMENT '活动持续结束时间',
  `create_time` int(10) unsigned NOT NULL COMMENT '账户创建时间',
  PRIMARY KEY (`a_id`),
  UNIQUE KEY `username` (`username`),
  KEY `phone` (`phone`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '键',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '值',
  `unit` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`ac_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of admins_configs
-- ----------------------------
INSERT INTO `admins_configs` VALUES ('1', 'begin_time', '2018-08-06 20:16:43', '', '活动开始时间');
INSERT INTO `admins_configs` VALUES ('2', 'end_time', '2019-10-01 20:16:48', '', '活动结束时间');
INSERT INTO `admins_configs` VALUES ('3', 'victory_gold', '20', '', '胜利获得的金币');
INSERT INTO `admins_configs` VALUES ('4', 'defeat_gold', '10', '', '失败获得的金币数');
INSERT INTO `admins_configs` VALUES ('5', 'flat_gold', '15', '', '平手获得的金币数');
INSERT INTO `admins_configs` VALUES ('6', 'victory_exp', '10', '', '胜利获得的经验值');
INSERT INTO `admins_configs` VALUES ('7', 'defeat_exp', '5', '', '失败获得的经验值');
INSERT INTO `admins_configs` VALUES ('8', 'flat_exp', '7', '', '平手获得的经验值');

-- ----------------------------
-- Table structure for topics
-- ----------------------------
DROP TABLE IF EXISTS `topics`;
CREATE TABLE `topics` (
  `tr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '问题描述',
  `cate_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `cate_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `a` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'a答案',
  `b` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'b答案',
  `c` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'c答案',
  `d` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'd答案',
  `answer` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '正确答案',
  PRIMARY KEY (`tr_id`)
) ENGINE=MyISAM AUTO_INCREMENT=594 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of topics
-- ----------------------------
INSERT INTO `topics` VALUES ('1', '真丝衣服能不能与樟脑丸放在一起？', '11', '物理', '能', '不能', '', '', 'b');
INSERT INTO `topics` VALUES ('2', '太阳光经三棱镜折射后，形成色带，将温度计的水银泡涂黑，放到光带上，从紫端向红端移动，温度计指示的温度将不断', '11', '物理', '升高', '降低', '', '', 'a');
INSERT INTO `topics` VALUES ('3', '下列门窗中，保温、耐火、防水、防腐、隔音效果最好的是', '11', '物理', '木门窗', '钢门窗', '铝合金门窗', '塑钢门窗', 'd');
INSERT INTO `topics` VALUES ('4', '质量单位千克等于国际千克原器的质量，这个原器由', '11', '物理', '铂金制成', '黄金制成', '铂铱合金制成', '铝制成', 'c');
INSERT INTO `topics` VALUES ('5', '属于国家一类保护动物的是', '11', '物理', '天鹅', '娃娃鱼', '孔雀', '丹顶鹤', 'a');
INSERT INTO `topics` VALUES ('6', '铁锅通常用哪种铁制成？', '11', '物理', '生铁', '熟铁', '', '', 'a');
INSERT INTO `topics` VALUES ('7', '我们在电塔附近听到的嗡鸣声是', '11', '物理', '变压器发出的', '电线发出的', '人耳的错觉', '', 'b');
INSERT INTO `topics` VALUES ('8', '辣椒在植物分类中，是属于', '14', '自然', '椒科', '茄科', '', '', 'b');
INSERT INTO `topics` VALUES ('9', '举重时运动员为什么搓白粉？', '2', '体育', '使手变的粗糙', '吸取手上的汗', '刺激肌肉', '保护皮肤', 'b');
INSERT INTO `topics` VALUES ('10', '举重比赛的级别是按', '2', '体育', '按杠铃重量划分', '按体重划分', '按年龄划分', '按性别划分', 'b');
INSERT INTO `topics` VALUES ('11', '《新人口论》的作者是哪国人？', '9', '文学', '中国人', '英国人', '美国人', '', 'a');
INSERT INTO `topics` VALUES ('12', '国家住宅电气标准中规定，两居室的固定插座数量为？', '11', '物理', '6个', '8个', '10个', '12个', 'd');
INSERT INTO `topics` VALUES ('13', '反映波兰作曲家肖邦生平的美国影片是', '9', '文学', '《翠堤春晓》', '《一曲难忘》', '《音乐之声》', '《雨中曲》', 'b');
INSERT INTO `topics` VALUES ('14', '&quot;孤帆远影碧空尽&quot;的下一句是什么？', '9', '文学', '万里黄河绕黑山', '惟见长江天际流', '春风不度玉门关', '白云千载空悠悠', 'b');
INSERT INTO `topics` VALUES ('15', '多快的速度才能使卫星环绕地球运行?', '6', '天文', '大于11.2千米&#x2F;秒而小于16.4千米&#x2F;秒', '大于7.9千米&#x2F;秒而小于11.2千米&#x2F;秒', '大于16.4千米&#x2F;秒而小于18.2千米&#x2F;秒', '大于7.9千米&#x2F;秒而小于16.4千米&#x2F;秒', 'b');
INSERT INTO `topics` VALUES ('16', '几个人以上共同故意犯罪被称为共同犯罪。', '8', '政治', '2个', '3个', '5个', '10个', 'a');
INSERT INTO `topics` VALUES ('17', '古诗云洞庭天下水，岳阳天下楼。岳阳楼在哪座湖上？', '9', '文学', '太湖', '洞庭湖', '', '', 'b');
INSERT INTO `topics` VALUES ('18', '人类最先使用的制造器具的金属是', '11', '物理', '铁', '银', '铜', '铅', 'c');
INSERT INTO `topics` VALUES ('19', '“息壤”是谁用来治水的法宝？', '9', '文学', '鲧', '李冰', '禹', '', 'a');
INSERT INTO `topics` VALUES ('20', '在地球上，极光是高纬度地区特有的景观，对不对？', '5', '地理', '对', '不对', '', '', 'a');
INSERT INTO `topics` VALUES ('21', '消防队救火', '7', '常识', '收费', '不收费', '收取部分费用', '', 'b');
INSERT INTO `topics` VALUES ('22', '最早的纸币源于:', '4', '历史', '中国', '美国', '苏联', '', 'a');
INSERT INTO `topics` VALUES ('23', '鸵鸟受到惊吓或敌害时可能会', '14', '自然', '把头埋进沙子里', '将脖子平贴地面，紧缩身体', '把全身都埋进沙子里', '会将头低垂到与地面平行，羽毛竖起', 'd');
INSERT INTO `topics` VALUES ('24', '蒙古首都乌兰巴托的意思是', '5', '地理', '繁荣的城市', '红色英雄', '没有水的城市', '苏联联邦', 'b');
INSERT INTO `topics` VALUES ('25', '感光胶片中的全色片是一种', '11', '物理', '黑白感光片', '彩色感光片', '', '', 'a');
INSERT INTO `topics` VALUES ('26', '“寸草春晖”是比喻父母恩情难以报答，它出自唐朝哪位诗人的诗句？', '9', '文学', '李白', '杜甫', '孟郊', '', 'c');
INSERT INTO `topics` VALUES ('27', '依据中国法律规定，机动车靠边停车时应', '7', '常识', '开左转向灯', '开右转向灯', '', '', 'b');
INSERT INTO `topics` VALUES ('28', '人体最可能肥胖的部位是', '14', '自然', '背部', '肚子', '上臂', '', 'b');
INSERT INTO `topics` VALUES ('29', '俗称的“黑管”是哪种木管乐器？', '15', '音乐', '单簧管', '双簧管', '巴松', '萨克斯', 'a');
INSERT INTO `topics` VALUES ('30', '问仓储超市与其它超市最大的不同点是什么', '7', '常识', '铺房简陋', '储售场地合一', '随进随卖', '需要库房', 'b');
INSERT INTO `topics` VALUES ('31', '同样重量的雪水、雨水和矿泉水，用相同的火力烧，哪种水最后开？', '11', '物理', '雪水', '雨水', '矿泉水', '', 'a');
INSERT INTO `topics` VALUES ('32', '世界水日是哪一天?', '4', '历史', '3月23日', '4月23日', '5月23日', '6月23日', 'a');
INSERT INTO `topics` VALUES ('33', '国家公务员制度起源于？', '8', '政治', '美国雇员制', '法国议会制', '英国文官制', '德国武官制', 'c');
INSERT INTO `topics` VALUES ('34', '按照我国合同法的规定，当事人对合同变更的内容约定不明确时', '8', '政治', '推定自始没有订立合同', '视为合同解除', '推定为未变更', '视为合同自始未成立', 'c');
INSERT INTO `topics` VALUES ('35', '不同的塑料组成有很大差异，但主要原料都是', '11', '物理', '环氧化合物', '合成树脂', '石蜡', '聚氯乙烯', 'b');
INSERT INTO `topics` VALUES ('36', '仰韶文化是我国历史上哪个时代中期的文化？', '4', '历史', '旧石器', '新石器', '青铜器', '铁器', 'b');
INSERT INTO `topics` VALUES ('37', '在“夸父逐日”中，“夸父”是怎样追逐太阳的？', '9', '文学', '驾车', '奔跑', '飞行', '骑马', 'b');
INSERT INTO `topics` VALUES ('38', '为什么笛卡儿指着一筐兔子说，那是他的书？', '9', '文学', '那是他的宠物', '家族图腾', '提倡观察', '他是经验主义者', 'c');
INSERT INTO `topics` VALUES ('39', '月亮金字塔坐落在哪里？', '5', '地理', '斯里兰卡', '马尔代夫', '埃及', '墨西哥', 'd');
INSERT INTO `topics` VALUES ('40', '鱼有心脏吗？', '14', '自然', '有', '没有', '', '', 'a');
INSERT INTO `topics` VALUES ('41', '电度表上的一度电表示耗电量为', '11', '物理', '1百瓦*小时', '1千瓦*小时', '1瓦*小时', '', 'b');
INSERT INTO `topics` VALUES ('42', '纯羊绒的含绒量在', '7', '常识', '51%以上', '70%以上', '95%以上', '', 'c');
INSERT INTO `topics` VALUES ('43', '国际奥委会为感谢萨马兰奇对奥林匹克运动的贡献，发行了一枚名为《感谢主席先生》的', '8', '政治', '邮票', '邮折', '纪念封', '纪念币', 'c');
INSERT INTO `topics` VALUES ('44', '农历把每月初一叫做什么日？', '7', '常识', '朔日', '望日', '', '', 'a');
INSERT INTO `topics` VALUES ('45', '从事有害作业的小李接受职业性健康检查时占用了工作时间，能否算正常出勤？', '8', '政治', '能', '不能', '', '', 'a');
INSERT INTO `topics` VALUES ('46', '我国足协评出千禧年足球先生张恩华是以什么身份获得这项殊荣的？', '7', '常识', '前锋', '中锋', '后卫', '', 'c');
INSERT INTO `topics` VALUES ('47', '照相机不能拍摄到人眼看不到的星星吗？', '11', '物理', '对', '不对', '', '', 'b');
INSERT INTO `topics` VALUES ('48', '世界上最靠北的首都是', '5', '地理', '斯德哥尔摩', '莫斯科', '雷克亚未克', '哥本哈根', 'c');
INSERT INTO `topics` VALUES ('49', '《阳关三叠》是甚么时候的琴曲？', '4', '历史', '汉代', '隋唐', '宋元', '明清', 'b');
INSERT INTO `topics` VALUES ('50', '电池上通常标有R55、R5、等符号，R代表', '7', '常识', '电池的形状', '电池的含电量', '电池的尺寸大小', '酸性或碱性电池的标志', 'a');
INSERT INTO `topics` VALUES ('51', '影响电视图象的主要污染因素是', '5', '地理', '大气污染', '噪声污染', '电磁辐射污染', '灰尘污染', 'c');
INSERT INTO `topics` VALUES ('52', '北京等地四合院的大门一般是开在哪个角上？', '5', '地理', '东南角', '西南角', '东北角', '西北角', 'a');
INSERT INTO `topics` VALUES ('53', '依照宪法规定中华人民共和国主席,副主席都缺位的时候由全国人民代表大会补选。在补选以前应由谁暂时代理主席职位？', '8', '政治', '国务院总理', '全国人民代表大会常务委员会委员长', '', '', 'b');
INSERT INTO `topics` VALUES ('54', '行星仪的作用是:', '6', '天文', '测量距离的仪器', '确定方位的仪器', '测试轨道的仪器', '表示行星在轨道上运行的仪器', 'd');
INSERT INTO `topics` VALUES ('55', '根据宪法规定，土地使用权可以依据法律的规定', '8', '政治', '出租', '买卖', '转让', '遗赠', 'c');
INSERT INTO `topics` VALUES ('56', 'WNBA代表什么?', '2', '体育', '美国男子职业篮球赛', '美国大学生篮球赛', '美国女子职业篮球赛', '', 'c');
INSERT INTO `topics` VALUES ('57', '小明把一个中央有圆孔的铜垫片加热，他发现中央的圆孔', '11', '物理', '变大', '变小', '不变', '', 'a');
INSERT INTO `topics` VALUES ('58', '镁、铝、镁铝合金谁的熔点低？', '11', '物理', '镁', '铝', '镁铝合金', '不一定', 'c');
INSERT INTO `topics` VALUES ('59', '空手道的禁忌是', '2', '体育', '用脚', '用肘', '出击触及对方身体', '', 'c');
INSERT INTO `topics` VALUES ('60', '我国曲艺中的相声是', '7', '常识', '北方曲种', '南方曲种', '', '', 'a');
INSERT INTO `topics` VALUES ('61', '下面哪一种熨烫衣服的方法是不正确的？', '7', '常识', '熨之前在衣服上喷一些水', '尽可能长时间地熨', '掌握合适的温度', '在衣服和熨斗之间垫一块湿布', 'b');
INSERT INTO `topics` VALUES ('62', '“腊八粥”最早起源于', '4', '历史', '祭祀', '民间庆祝丰收的风俗', '佛教', '', 'c');
INSERT INTO `topics` VALUES ('63', '我国最著名的热水湖是哪一个？', '5', '地理', '西藏羊八井', '新疆罗布泊', '内蒙古呼伦湖', '', 'a');
INSERT INTO `topics` VALUES ('64', '“三明治”的命名与什么活动有关？', '9', '文学', '骑马', '打猎', '打牌', '', 'c');
INSERT INTO `topics` VALUES ('65', '根据《企业破产法》，参加债权人会议的全体成员都享有表决权吗？', '8', '政治', '是', '不是', '', '', 'b');
INSERT INTO `topics` VALUES ('66', '小王面对远处一座峭壁高喊一声，1秒钟后听到回声，请问小王离峭壁有多远？', '11', '物理', '340米', '170米', '85米', '42.5米', 'b');
INSERT INTO `topics` VALUES ('67', '为什么白种人的头发大多是金黄色的？', '3', '化学', '头发中铜元素多', '头发中铁元素多', '头发中钛元素多', '头发中钼元素多', 'c');
INSERT INTO `topics` VALUES ('68', '搪瓷器皿是否越重越好？', '11', '物理', '是', '不是', '', '', 'b');
INSERT INTO `topics` VALUES ('69', '音乐界所说的大小施特劳斯', '15', '音乐', '是父子关系', '不是父子关系', '', '', 'a');
INSERT INTO `topics` VALUES ('70', '非洲国家边界按什么划分的最多？', '5', '地理', '直线或曲线的几何方法', '经线或纬线', '河流、山脉等自然地貌', '民族', 'b');
INSERT INTO `topics` VALUES ('71', '世界上目前产量最大、应用最广泛的电池是', '5', '地理', '蓄电池', '湿电池', '锌锰干电池', '', 'c');
INSERT INTO `topics` VALUES ('72', '人的唾液是舌头分泌的，对吗？', '14', '自然', '对', '错', '', '', 'b');
INSERT INTO `topics` VALUES ('73', '声音在哪里传播更快？', '11', '物理', '空气中', '水中', '', '', 'b');
INSERT INTO `topics` VALUES ('74', '冻疮是由于皮肤哪一部分受损而引起的？', '14', '自然', '毛囊', '汗腺', '竖毛肌', '毛细血管', 'd');
INSERT INTO `topics` VALUES ('75', '“驸马”最初是指', '4', '历史', '给皇帝养马的人', '官名', '给皇帝牵马的人', '马的名字', 'b');
INSERT INTO `topics` VALUES ('76', '清洁的空气中含有多少氧？', '11', '物理', '21%', '31%', '41%', '', 'a');
INSERT INTO `topics` VALUES ('77', '亚洲首次举办奥运会是哪一届？', '2', '体育', '16届', '17届', '18届', '19届', 'c');
INSERT INTO `topics` VALUES ('78', '路透社是哪个国家的通讯社？', '5', '地理', '美国', '英国', '俄国', '法国', 'b');
INSERT INTO `topics` VALUES ('79', '“泾渭分明”指的是', '9', '文学', '织物经纬线区别', '地球经纬度分明', '泾水混，渭水清', '泾水清，渭水浊', 'c');
INSERT INTO `topics` VALUES ('80', '除法律另有规定或合同另有约定外，保险合同成立后，谁有权解除合同？', '8', '政治', '投保人', '保险人', '被保险人', '受益人', 'a');
INSERT INTO `topics` VALUES ('81', '港澳回归后，寄往该地区信函费用是否和国内其它地区相同？', '5', '地理', '相同', '低于其它地区', '高于其它地区', '', 'c');
INSERT INTO `topics` VALUES ('82', '下列天体中，距离地球最近的恒星是', '6', '天文', '太阳', '比邻星', '月球', '', 'a');
INSERT INTO `topics` VALUES ('83', '母亲节那天为了表示对母亲的敬意，子女要佩戴什么花', '7', '常识', '郁金香', '石竹花', '兰花', '康乃馨', 'd');
INSERT INTO `topics` VALUES ('84', '老李除了一个痴呆儿子外，只有外孙子小李一个亲人，小李有赡养外祖父的法定义务吗？', '8', '政治', '有', '没有', '', '', 'a');
INSERT INTO `topics` VALUES ('85', '委托人所确定的拍卖标的的保留价是成交的最高价吗？', '8', '政治', '是', '不是', '', '', 'b');
INSERT INTO `topics` VALUES ('86', '世界上第一个国际电影节是', '9', '文学', '柏林国际电影节', '威尼斯电影节', '戛纳电影节', '', 'b');
INSERT INTO `topics` VALUES ('87', '我国商业性发射通讯卫星最多的运载火箭是', '13', '科技', '长征二号', '长征二号丙', '长征三号', '长征三号甲', 'b');
INSERT INTO `topics` VALUES ('88', '一般来说，在发生通货膨胀时，靠固定工资生活的人', '8', '政治', '生活水平会下降', '生活水平会提高', '', '', 'a');
INSERT INTO `topics` VALUES ('89', '景泰蓝的表层用金丝,彩釉装饰,用什么做胎?', '7', '常识', '铜', '铁', '锡', '', 'a');
INSERT INTO `topics` VALUES ('90', '哪种病人不宜饮茶？', '3', '化学', '心血管疾病', '急性胃肠炎', '溃疡病', '肾衰竭', 'c');
INSERT INTO `topics` VALUES ('91', '下列影片中，以歌颂少数民族新生活为题材的是', '9', '文学', '《李双双》', '《洞箫横吹》', '《柳堡的故事》', '《达吉和她的父亲》', 'd');
INSERT INTO `topics` VALUES ('92', '用微波炉煮荷包蛋时要用牙签在蛋清、蛋黄上扎孔主要是为了什么？', '7', '常识', '容易入味', '防止爆裂', '受热均匀', '煮熟得快', 'b');
INSERT INTO `topics` VALUES ('93', '世界名画《和平鸽》的创作者是', '9', '文学', '毕加索', '凡高', '', '', 'a');
INSERT INTO `topics` VALUES ('94', '阿诗玛是我国云南哪个民族塑造的艺术形象？', '10', '旅游', '彝族', '瑶族', '白族', '苗族', 'a');
INSERT INTO `topics` VALUES ('95', '&quot;隔着门缝看人”时，看到的人', '7', '常识', '比原来扁了', '和原来一样', '', '', 'b');
INSERT INTO `topics` VALUES ('96', '民用挂锁的保密度是由互开率表示的，一般最高不超过', '11', '物理', '百分之三', '千分之十', '千分之三', '', 'c');
INSERT INTO `topics` VALUES ('97', '冬季奥运会如何计算届次？', '2', '体育', '4年1次，如因故不能举行，届数照算', '4年1次，以实际举办次数计算', '', '', 'b');
INSERT INTO `topics` VALUES ('98', '政府属于现代市场经济条件下的市场主体吗？', '8', '政治', '不属于', '属于', '', '', 'b');
INSERT INTO `topics` VALUES ('99', '会飞的蝙蝠属于', '14', '自然', '兽类', '鸟类', '', '', 'a');
INSERT INTO `topics` VALUES ('100', '“琴棋书画”中的“棋”指', '9', '文学', '象棋', '围棋', '古代象棋', '国际象棋', 'b');
INSERT INTO `topics` VALUES ('101', '雨后阳光下有时会出现彩虹，雨后的月光下', '11', '物理', '不会出现彩虹', '也可能出现彩虹', '', '', 'b');
INSERT INTO `topics` VALUES ('102', '美国1787年宪法规定，解释宪法的权力在', '4', '历史', '众议院', '参议院', '最高法院', '总统', 'c');
INSERT INTO `topics` VALUES ('103', '“歌棚”是哪个民族的习俗？', '10', '旅游', '傣族', '苗族', '壮族', '京族', 'c');
INSERT INTO `topics` VALUES ('104', '人走路时摆动双臂主要是为了', '7', '常识', '减少能量消耗', '校正头部位置', '平衡走路姿势', '加快行走速度', 'c');
INSERT INTO `topics` VALUES ('105', '最早设计的轮椅有几个轮子？', '7', '常识', '两个', '三个', '四个', '', 'b');
INSERT INTO `topics` VALUES ('106', '给折枝山茶花保鲜应该用什么？', '3', '化学', '淡盐水', '醋酸', '硼酸', '稀盐酸', 'a');
INSERT INTO `topics` VALUES ('107', '勾股定理中，较长的直角边叫做', '13', '科技', '“股”', '“勾”', '“弦”', '', 'a');
INSERT INTO `topics` VALUES ('108', '世界上地势最低的国家是', '5', '地理', '芬兰', '冰岛', '挪威', '荷兰', 'd');
INSERT INTO `topics` VALUES ('109', '市场经济条件下市场发育和运行的目标一般是形成', '8', '政治', '卖方市场', '有限的买方市场', '有限的卖方市场', '无限的买方市场', 'b');
INSERT INTO `topics` VALUES ('110', '成语“秦失其鹿”中的鹿是指什么？', '9', '文学', '一名大将', '一只梅花鹿', '皇帝之位', '', 'c');
INSERT INTO `topics` VALUES ('111', '任意停放车辆属下列哪类违章？', '8', '政治', '车辆检验违章', '车辆行驶违章', '车辆装载违章', '车辆驾驶违章', 'b');
INSERT INTO `topics` VALUES ('112', '在苹果树修剪合理的情况下，果实着色最好的部位应处于', '14', '自然', '树北侧上方', '树南侧上方', '树北侧下方', '树南侧下方', 'b');
INSERT INTO `topics` VALUES ('113', '各国国籍法对国籍的取得有不同的规定，我国人在外国结婚，同时取得该国国籍，那他的中国国籍会怎样？', '8', '政治', '可以备档作保留', '会自动丧失', '仍然保留', '', 'b');
INSERT INTO `topics` VALUES ('114', '世界上第一颗爆炸的原子弹的名字是？', '6', '天文', '瘦子', '胖子', '男孩', '女孩', 'a');
INSERT INTO `topics` VALUES ('115', '在戏曲舞台上，有的角色手执马鞭行而不舞，是象征', '9', '文学', '骑马', '牵马而行', '', '', 'b');
INSERT INTO `topics` VALUES ('116', '陆地水中储量最大的水体是', '5', '地理', '地下水', '江河水', '冰川水', '湖泊水', 'c');
INSERT INTO `topics` VALUES ('117', '古代女子成年行什么礼？', '4', '历史', '冠礼', '笄礼', '', '', 'b');
INSERT INTO `topics` VALUES ('118', '在什么条件下柿子才可以结冰？', '11', '物理', '零摄氏度', '高于零摄氏度', '低于零摄氏度', '', 'c');
INSERT INTO `topics` VALUES ('119', '被称为“三苏”的北宋文学家父子中的父亲是', '9', '文学', '苏洵', '苏轼', '苏辙', '苏舜钦', 'a');
INSERT INTO `topics` VALUES ('120', '熊猫的交配多采用', '14', '自然', '一夫多妻制', '一妻多夫制', '多夫多妻制', '', 'c');
INSERT INTO `topics` VALUES ('121', '下面的通讯社哪个属于美国？', '5', '地理', '新华社', '美联社', '', '', 'b');
INSERT INTO `topics` VALUES ('122', '发射第一颗人造卫星的国家是', '6', '天文', '前苏联', '美国', '', '', 'a');
INSERT INTO `topics` VALUES ('123', '新加坡经济发展较快的主要原因是', '5', '地理', '自然条件好', '劳动力资源丰富', '地理位置优越', '', 'c');
INSERT INTO `topics` VALUES ('124', '韭菜是一种什么类型的植物？', '14', '自然', '一年生草本', '多年生草本', '二年生草本', '', 'b');
INSERT INTO `topics` VALUES ('125', '骆驼有双层眼睫毛。', '14', '自然', '对', '不对', '', '', 'a');
INSERT INTO `topics` VALUES ('126', '中国最热的地方在哪里？', '5', '地理', '吐鲁番盆地', '南沙群岛', '', '', 'a');
INSERT INTO `topics` VALUES ('127', '猫在哪个国家内受到严格保护？', '5', '地理', '古埃及', '古印度', '古希腊', '古罗马', 'a');
INSERT INTO `topics` VALUES ('128', '我国于1958年制出第一台电子管计算机，它的运算速度为每秒？', '12', '电脑', '两千次', '两万次', '二十万次', '二百万次', 'a');
INSERT INTO `topics` VALUES ('129', '《福尔摩斯探案集》里的“苏格兰场”在', '9', '文学', '苏格兰', '英国', '爱尔兰', '纽芬兰', 'b');
INSERT INTO `topics` VALUES ('130', '最早制造香水瓶所用的原料是', '7', '常识', '陶瓷', '玻璃', '石膏', '铜瓶', 'c');
INSERT INTO `topics` VALUES ('131', '“龙井茶叶，虎跑水”。虎跑泉的水很有趣，装满一杯水后，轻轻地放进一粒小石子，水就会高出杯面，可是它却不溢出来，好象覆盖着一个无形的杯盖。泉水为什么不溢出来？', '11', '物理', '泉水比纯水的表面张力大', '泉水比纯水的表面张力小', '', '', 'a');
INSERT INTO `topics` VALUES ('132', '在失重情况下，蜡烛燃烧时的火焰是', '11', '物理', '泪滴状', '蚕豆形', '椭圆形', '球形', 'd');
INSERT INTO `topics` VALUES ('133', '蕴藏石油最丰富的半岛是', '5', '地理', '亚平宁半岛', '小亚细亚半岛', '阿拉伯半岛', '', 'c');
INSERT INTO `topics` VALUES ('134', '已发现的绕太阳运行的彗星大约有多少个？', '6', '天文', '1个', '160个', '1600个', '', 'c');
INSERT INTO `topics` VALUES ('135', '下列战役中，被陈毅元帅称作“人民群众用小车推出来的”是', '4', '历史', '淮海战役', '平津战役', '辽沈战役', '', 'a');
INSERT INTO `topics` VALUES ('136', '我国的“诗圣”指的是', '9', '文学', '李白', '杜甫', '李贺', '', 'b');
INSERT INTO `topics` VALUES ('137', '欧洲第一个使用印刷机的民族是', '5', '地理', '爱尔兰人', '冰岛人', '丹麦人', '意大利人', 'b');
INSERT INTO `topics` VALUES ('138', '产于福建的名茶是', '5', '地理', '白茶', '龙井茶', '黑茶', '', 'a');
INSERT INTO `topics` VALUES ('139', '水族姑娘出嫁后要完成的第一件事是', '10', '旅游', '挑柴', '挑水', '挑米', '', 'b');
INSERT INTO `topics` VALUES ('140', '“文过饰非”中“文”是指', '9', '文学', '做文章', '掩饰', '听，同“闻”', '', 'b');
INSERT INTO `topics` VALUES ('141', '鳄鱼是哺乳动物。', '14', '自然', '对', '不对', '', '', 'b');
INSERT INTO `topics` VALUES ('142', '我国小说史上第一部长篇讽刺小说是', '9', '文学', '聊斋志异', '儒林外史', '钟馗捉鬼传', '', 'b');
INSERT INTO `topics` VALUES ('143', '哪个城市被称作&quot;草原钢城&quot;？', '5', '地理', '呼和浩特', '包头', '', '', 'b');
INSERT INTO `topics` VALUES ('144', '海南岛是我国的第几大岛？', '5', '地理', '第一大岛', '第二大岛', '第三大岛', '', 'b');
INSERT INTO `topics` VALUES ('145', '&quot;华表”又叫做', '9', '文学', '表木', '讷木', '', '', 'a');
INSERT INTO `topics` VALUES ('146', '小儿没爬就会走了，好吗？', '7', '常识', '好', '不好', '', '', 'b');
INSERT INTO `topics` VALUES ('147', '亚欧大陆桥欧洲的终点站是', '5', '地理', '鹿特丹', '阿姆斯特丹', '', '', 'a');
INSERT INTO `topics` VALUES ('148', '印度的国鸟是', '5', '地理', '云雀', '绿孔雀', '', '', 'b');
INSERT INTO `topics` VALUES ('149', '火腿中有“南腿”之称的是', '7', '常识', '苏北火腿', '金华火腿', '榕峰火腿', '宣威火腿', 'b');
INSERT INTO `topics` VALUES ('150', '大汶口文化遗址在我国的', '5', '地理', '山东', '河南', '', '', 'a');
INSERT INTO `topics` VALUES ('151', '烤全羊烤的是', '7', '常识', '山羊', '羚羊', '绵羊', '黄羊', 'c');
INSERT INTO `topics` VALUES ('152', '会计师事务所要成为负有限责任的法人，条件之一是注册资本须', '8', '政治', '不少于10万元', '不少于20万元', '不少于30万元', '不少于40万元', 'c');
INSERT INTO `topics` VALUES ('153', '机动车辆在草原上行驶时,有固定公路线的,不得离开公路线行驶，对吗?', '8', '政治', '对', '不对', '', '', 'a');
INSERT INTO `topics` VALUES ('154', '我国能生产磁悬浮客车吗？', '13', '科技', '能', '不能', '', '', 'a');
INSERT INTO `topics` VALUES ('155', '“红杏枝头春意闹”属于', '9', '文学', '通感', '夸张', '烘托', '象征', 'a');
INSERT INTO `topics` VALUES ('156', '按有关法律规定，经营者可以从事的抽奖式有奖销售，最高奖的奖金额的限度是', '8', '政治', '五千元人民币', '五万人民币', '一百万人民币', '五百万人民币', 'a');
INSERT INTO `topics` VALUES ('157', '海龟上岸产卵会选择', '14', '自然', '新月或满月的时候', '半月的时候', '中午时分', '', 'a');
INSERT INTO `topics` VALUES ('158', '《掷铁饼者》是什么时期的作品？', '9', '文学', '文艺复兴时期', '古希腊时期', '古罗马时期', '资产阶级革命时期', 'b');
INSERT INTO `topics` VALUES ('159', '角抵戏为什么要头戴野兽面具？', '9', '文学', '源自对狩猎活动的模仿', '为了热闹', '装饰', '不容易碰伤头', 'a');
INSERT INTO `topics` VALUES ('160', '20公里以上的竞走比赛，一般每隔多少公里设置饮食供给站？', '2', '体育', '3公里', '5公里', '7公里', '10公里', 'b');
INSERT INTO `topics` VALUES ('161', '在我国，判例有没有法律约束力？', '8', '政治', '有', '没有', '', '', 'b');
INSERT INTO `topics` VALUES ('162', '否决权最初的语义是', '9', '文学', '我禁止', '这是不对的', '', '', 'a');
INSERT INTO `topics` VALUES ('163', '债券与股票的区别是什么？', '7', '常识', '债券风险小、收益稳定、股票风险大、收益高', '债券持有的时间长，股票持有的时间短', '', '', 'a');
INSERT INTO `topics` VALUES ('164', '计算机的运算过程，实际上是对几个数码，按照一定的逻辑规则并进行判断和转换的过程？', '12', '电脑', '1个', '两个', '四个', '无数个', 'b');
INSERT INTO `topics` VALUES ('165', '《天演论》是我国近代哪位著名的思想家翻译的？', '9', '文学', '魏源', '梁启超', '严复', '胡适', 'c');
INSERT INTO `topics` VALUES ('166', '蝴蝶发现花蜜靠', '14', '自然', '眼看', '前足沾', '嗅觉闻', '嘴尝', 'b');
INSERT INTO `topics` VALUES ('167', '《嘎达梅林》是哪个民族的叙事歌曲？', '15', '音乐', '维吾尔族', '哈萨克族', '蒙古族', '达斡尔', 'c');
INSERT INTO `topics` VALUES ('168', '空腹跑步有利健康吗？', '7', '常识', '有利', '不利', '', '', 'b');
INSERT INTO `topics` VALUES ('169', '人参的主要产地在', '5', '地理', '西藏', '东北', '', '', 'b');
INSERT INTO `topics` VALUES ('170', '谁是“中山装”的创始人？', '4', '历史', '黄隆生', '孙中山', '汪精卫', '黄兴', 'b');
INSERT INTO `topics` VALUES ('171', '起诉虐待案件应是什么部门受理', '8', '政治', '人民检查院', '人民法院', '公安机关', '民政机关', 'b');
INSERT INTO `topics` VALUES ('172', '红糖呈现红色是因为', '7', '常识', '白糖染上了红色', '原糖未脱色', '', '', 'b');
INSERT INTO `topics` VALUES ('173', '安徒生童话《海的女儿》里，小美人鱼变成人是为了见到谁？', '9', '文学', '渔夫', '王后', '王子', '', 'c');
INSERT INTO `topics` VALUES ('174', '“食色，性也”是谁说的？', '9', '文学', '孟子', '孔子', '', '', 'a');
INSERT INTO `topics` VALUES ('175', '刮痧是我国民间传统的简易治疗方法，对吗？', '7', '常识', '对', '不对', '', '', 'a');
INSERT INTO `topics` VALUES ('176', '中国农业银行发行的信用卡是', '8', '政治', '长城卡', '金穗卡', '牡丹卡', '龙卡', 'b');
INSERT INTO `topics` VALUES ('177', '古语“朵颐”中的“颐”是指', '9', '文学', '耳垂', '手腕', '面颊', '', 'c');
INSERT INTO `topics` VALUES ('178', '青蛙除了用肺外还用什么器官呼吸？', '14', '自然', '肌肉', '皮肤', '脾脏', '肝脏', 'b');
INSERT INTO `topics` VALUES ('179', '我国古代称生什么为“弄瓦”？', '9', '文学', '男孩', '女孩', '第二个孩子', '', 'b');
INSERT INTO `topics` VALUES ('180', '司机小王交通违章满12分，通过学习后，他应接受', '8', '政治', '交规和相关知识考试', '道路驾驶考试', '交规和相关知识以及道路驾驶考试', '4年级', 'c');
INSERT INTO `topics` VALUES ('181', '“总角之交”是指', '9', '文学', '顽童之交', '少年之交', '中年之交', '忘年之交', 'b');
INSERT INTO `topics` VALUES ('182', '一般天气的变化发生在', '5', '地理', '对流层', '平流层', '', '', 'a');
INSERT INTO `topics` VALUES ('183', '樱桃是樱花的果实吗？', '14', '自然', '是', '不是', '', '', 'a');
INSERT INTO `topics` VALUES ('184', '地球公转速度为每秒', '5', '地理', '10公里', '20公里', '30公里', '', 'c');
INSERT INTO `topics` VALUES ('185', '现存关于遗嘱继承的最早的法规产生于', '4', '历史', '汉代', '唐代', '宋代', '元代', 'b');
INSERT INTO `topics` VALUES ('186', '在劳动合同中写有“发生工伤事故责任自负”的条款，是否具有法律效力？', '8', '政治', '有', '没有', '', '', 'b');
INSERT INTO `topics` VALUES ('187', '凯旋门的建造是为了纪念', '5', '地理', '戴高乐', '路易十三', '拿破仑', '', 'c');
INSERT INTO `topics` VALUES ('188', '不能用开水煎中药的原因是', '11', '物理', '开水会杀死植物性中药的有效细胞', '开水会使蛋白质和淀粉凝结', '开水不能和中药溶和', '', 'b');
INSERT INTO `topics` VALUES ('189', '《钢铁是怎样炼成的》作者是谁？', '9', '文学', '马雅可夫斯基', '奥斯特洛夫斯基', '', '', 'b');
INSERT INTO `topics` VALUES ('190', '下列不适用《产品质量法》的有', '8', '政治', '建设工程', '加工品', '消费品', '制作品', 'a');
INSERT INTO `topics` VALUES ('191', '《阿里山的姑娘》是哪个少数民族的家人？', '15', '音乐', '苗族民歌', '彝族民歌', '高山族民歌', '黎族民歌', 'c');
INSERT INTO `topics` VALUES ('192', '含羞草会开花吗？', '14', '自然', '会', '不会', '', '', 'a');
INSERT INTO `topics` VALUES ('193', '戛纳电影节在哪国举办？', '9', '文学', '法国', '意大利', '英国', '德国', 'a');
INSERT INTO `topics` VALUES ('194', '马头琴是我国哪一民族的拉弦乐器？', '10', '旅游', '蒙古族', '维吾尔族', '', '', 'a');
INSERT INTO `topics` VALUES ('195', '我国最大的内陆咸水湖是:', '5', '地理', '洪泽湖', '太湖', '鄱阳湖', '青海湖', 'd');
INSERT INTO `topics` VALUES ('196', '最耐日晒的织品是哪一种？', '7', '常识', '苎麻', '腈纶', '羊毛', '涤纶', 'b');
INSERT INTO `topics` VALUES ('197', '钻石最大的产出国是', '5', '地理', '南非', '巴西', '扎伊尔', '', 'c');
INSERT INTO `topics` VALUES ('198', '我们可以用高粱酿造啤酒吗？', '7', '常识', '对', '错', '', '', 'b');
INSERT INTO `topics` VALUES ('199', '古希腊哪个国家的儿童一出世就要受到严格挑选，体质弱的会被抛之荒野？', '4', '历史', '雅典', '斯巴达', '', '', 'b');
INSERT INTO `topics` VALUES ('200', '《春秋》是按什么记事的？', '9', '文学', '年', '国', '事件', '', 'a');
INSERT INTO `topics` VALUES ('201', '一个细胞一小时分裂三个，9小时可以把一个容器装满，多少时间使分裂的细胞装到容器的1&#x2F;9。', '7', '常识', '5小时', '6小时', '7小时', '8小时', 'c');
INSERT INTO `topics` VALUES ('202', '135照相机的“135”指的是什么？', '7', '常识', '相机型号', '胶卷型号', '胶卷编号', '', 'c');
INSERT INTO `topics` VALUES ('203', '下列影片中，反映抗日战争时期革命斗争的是', '9', '文学', '《野火春风斗古城》（1943）', '《南征北战》（1947）', '《渡江侦察记》（1949）', '《战火中的青春》（1947）', 'a');
INSERT INTO `topics` VALUES ('204', '某女在离婚后发现前夫现在居住的房屋是在与其离婚前买的，离婚时，他们分割的共同财产并不包括这所房子。某女对此房屋', '8', '政治', '可以向法院提起诉讼，再次分割夫妻共有财产', '已办理离婚手续，房屋归前夫所有', '', '', 'a');
INSERT INTO `topics` VALUES ('205', '冬泳时，在下水之前饮用白酒可以御寒吗？', '7', '常识', '可以', '不可以', '', '', 'b');
INSERT INTO `topics` VALUES ('206', '“明镜高悬”的前身是', '9', '文学', '汉镜高悬', '唐镜高悬', '秦镜高悬', '', 'c');
INSERT INTO `topics` VALUES ('207', '南岳衡山的最高峰是', '5', '地理', '天都峰', '祝融峰', '莲花峰', '', 'b');
INSERT INTO `topics` VALUES ('208', '金星上会看到“旭日西升”吗？', '6', '天文', '对', '不对', '', '', 'a');
INSERT INTO `topics` VALUES ('209', '公制度量衡最初是由哪国人提出的？', '5', '地理', '英国人', '法国人', '美国人', '德国人', 'b');
INSERT INTO `topics` VALUES ('210', '含有花青素的植物叶子呈红色，它是用花青素进行光合作用的吗？', '14', '自然', '不是', '是', '', '', 'a');
INSERT INTO `topics` VALUES ('211', '国际奥林匹克集邮联合会在哪一国家成立？', '2', '体育', '瑞士', '希腊', '西班牙', '', 'a');
INSERT INTO `topics` VALUES ('212', '请问“法律”最早出现于哪个社会？', '4', '历史', '原始社会', '奴隶社会', '封建社会', '资本主义社会', 'b');
INSERT INTO `topics` VALUES ('213', '欧元什么时候正式诞生？', '4', '历史', '1999年1月1日', '1999年7月1日', '1999年12月1日', '', 'a');
INSERT INTO `topics` VALUES ('214', '我国最早提出创建监狱的人是', '4', '历史', '皋陶', '李斯', '', '', 'a');
INSERT INTO `topics` VALUES ('215', '&quot;一狐之腋”比喻', '9', '文学', '微小的事物', '珍贵的事物', '有气味的事物', '', 'b');
INSERT INTO `topics` VALUES ('216', '《本草纲目》的作者是', '9', '文学', '孙思邈', '李时珍', '', '', 'b');
INSERT INTO `topics` VALUES ('217', '我国是什么时候采用公历的？', '4', '历史', '鸦片战争时期', '辛亥革命时期', '建国前夕', '建国后', 'c');
INSERT INTO `topics` VALUES ('218', '设立股份有限公司，应有几个以上发起人？', '8', '政治', '3个', '5个', '2个', '7个', 'b');
INSERT INTO `topics` VALUES ('219', '旗袍是根据哪个民族的服装发展而来的？', '10', '旅游', '蒙古族', '藏族', '满族', '', 'c');
INSERT INTO `topics` VALUES ('220', '郭沫若的诗集是', '9', '文学', '《死水》', '《野草》', '《女神》', '《红烛》', 'c');
INSERT INTO `topics` VALUES ('221', '以下哪件事是《水浒》中梁山好汉武松所为？', '9', '文学', '倒拔垂杨柳', '汴京城卖刀', '醉打蒋门神', '', 'c');
INSERT INTO `topics` VALUES ('222', '挑选虾米时应挑选身体', '14', '自然', '弯曲的', '挺直的', '', '', 'a');
INSERT INTO `topics` VALUES ('223', '所有的公司在设立时都要经过审批', '8', '政治', '是', '不是', '', '', 'b');
INSERT INTO `topics` VALUES ('224', '火车机车的发明者是', '13', '科技', '瓦特', '史蒂芬逊', '', '', 'b');
INSERT INTO `topics` VALUES ('225', '成语“跋前疐后”形容的是哪种动物', '14', '自然', '狗', '狼', '狐狸', '', 'b');
INSERT INTO `topics` VALUES ('226', '通常情况下，中秋节晚上的月亮总是比第二天晚上的月亮亮吗？', '6', '天文', '是', '不是', '', '', 'b');
INSERT INTO `topics` VALUES ('227', '发生在北京卢沟桥的历史事变名叫？', '4', '历史', '华北事变', '戊戌政变', '七七事变', '皖南事变', 'c');
INSERT INTO `topics` VALUES ('228', '樱桃白兰地是用樱桃作原料酿制的，对不对？', '3', '化学', '对', '不对', '', '', 'a');
INSERT INTO `topics` VALUES ('229', '属于儒家思想的是', '9', '文学', '仁者爱人', '无为而治', '法不阿贵', '兼爱、非攻', 'a');
INSERT INTO `topics` VALUES ('230', '行驶在支路的轿车A未让行驶在干路的轿车B导致两车在路口相撞，则', '8', '政治', '轿车A负主要责任', '双方各负一半责任', '轿车A负全部责任', '', 'c');
INSERT INTO `topics` VALUES ('231', '蒸馏酒源于中国古代的', '4', '历史', '炼丹术', '造纸术', '印刷术', '', 'a');
INSERT INTO `topics` VALUES ('232', '文学史上魔幻现实主义流派的代表人物是', '9', '文学', '卡夫卡', '扎米亚京', '马尔克斯', '拉尔斯·吉伦斯坦', 'c');
INSERT INTO `topics` VALUES ('233', '电影《刘三姐》是反映-什么民族的生活故事？', '9', '文学', '壮族', '黎族', '瑶族', '苗族', 'a');
INSERT INTO `topics` VALUES ('234', '公元前594年，实行“初税亩”，按亩收税的国家是', '4', '历史', '楚国', '鲁国', '郑国', '魏国', 'b');
INSERT INTO `topics` VALUES ('235', '&quot;户枢不蠹”的“不蠹”是什么意思？', '9', '文学', '不损耗', '不生虫', '', '', 'b');
INSERT INTO `topics` VALUES ('236', '下列属于哺乳动物的是?', '14', '自然', '恐龙', '蝙蝠', '文昌鱼', '麻雀', 'b');
INSERT INTO `topics` VALUES ('237', '世界上最长的山脉是', '5', '地理', '比利牛斯山', '喜马拉雅山', '安第斯山', '乞力马扎罗山', 'c');
INSERT INTO `topics` VALUES ('238', '下列鱼中，对水中的氧气含量要求最高的是', '14', '自然', '海水冷水鱼', '淡水冷水鱼', '淡水热带鱼', '海水热带鱼', 'd');
INSERT INTO `topics` VALUES ('239', '热带鱼一般生活在', '14', '自然', '咸水中', '淡水中', '', '', 'b');
INSERT INTO `topics` VALUES ('240', '以下哪一位曾被称为“药王”？', '4', '历史', '孙思邈', '张仲景', '李时珍', '扁鹊', 'a');
INSERT INTO `topics` VALUES ('241', '亚硝胺是食品中致癌的因素，但是可以多吃什么来抑制人体对亚硝胺的吸收和合成？', '3', '化学', '鱼子酱', '火腿', '大白菜', '花生', 'c');
INSERT INTO `topics` VALUES ('242', '被称作东方威尼斯的是', '5', '地理', '杭州', '苏州', '', '', 'b');
INSERT INTO `topics` VALUES ('243', '貂熊又被称为“飞熊”。是因为什么？', '14', '自然', '奔跑速度', '尾巴', '', '', 'b');
INSERT INTO `topics` VALUES ('244', '公司的年度检验在每年的何时进行？', '8', '政治', '2月1日至4月30日', '1月1日至1月30日', '1月1日至4月30日', '1月1日至3月30日', 'c');
INSERT INTO `topics` VALUES ('245', '我国法律承认双重国籍吗？', '8', '政治', '承认', '不承认', '', '', 'b');
INSERT INTO `topics` VALUES ('246', '第一次鸦片战争发生的时间是', '4', '历史', '1839年3月', '1840年6月', '1841年1月', '', 'b');
INSERT INTO `topics` VALUES ('247', '世界最早的公用电话亭是在', '4', '历史', '银行内', '公园内', '商店内', '电话公司内', 'd');
INSERT INTO `topics` VALUES ('248', '红色霓虹灯里填充的气体是', '3', '化学', '氢', '氖', '氮', '氧', 'b');
INSERT INTO `topics` VALUES ('249', '古代著名的水利工程都江堰是谁设计的？', '4', '历史', '大禹', '李冰父子', '', '', 'b');
INSERT INTO `topics` VALUES ('250', '下列成语中，有错别字的是', '9', '文学', '黄粱美梦', '再接再厉', '按部就班', '破斧沉舟', 'd');
INSERT INTO `topics` VALUES ('251', '根据有关规定，职工的试用期最长不得超过', '8', '政治', '3个月', '6个月', '一年', '两年', 'b');
INSERT INTO `topics` VALUES ('252', '有人认为消费者通常有购买惰性，只要厂商努力推销，消费者就会购买或大量购买。这种观念会促使厂商做什么？', '8', '政治', '产品更新研究', '推销研究', '提高产品质量', '', 'b');
INSERT INTO `topics` VALUES ('253', '菜刀生锈，除锈的方法最好用', '3', '化学', '用水洗', '用干布擦拭', '用洗涤精擦洗', '用切开的葱头擦拭', 'd');
INSERT INTO `topics` VALUES ('254', '下列电影中，哪一部是由达利和布努艾尔共同导演的', '9', '文学', '一个国家的诞生', '处女泉', '安达鲁的狗', '党同伐异', 'c');
INSERT INTO `topics` VALUES ('255', '杜鹃鸟不做窝，她把蛋下到其他鸟的鸟巢里对吗？', '14', '自然', '对', '不对', '', '', 'a');
INSERT INTO `topics` VALUES ('256', '以下哪一作法不利于新生儿更多地看到玩具？', '7', '常识', '把玩具悬挂在孩子头的正上方', '使光线变暗些', '把玩具与孩子眼睛的距离控制在20cm', '', 'a');
INSERT INTO `topics` VALUES ('257', '“才自精明志自高”是《红楼梦》中对谁的判词？', '9', '文学', '元春', '熙凤', '宝钗', '探春', 'd');
INSERT INTO `topics` VALUES ('258', '小王欲将1500美元现钞汇到国外用于劳务支出，应', '8', '政治', '直接到银行办理', '由外管局审核后到银行办理', '由海关审核后到银行办理', '', 'a');
INSERT INTO `topics` VALUES ('259', '牙膏的泡沫是越多越好吗？', '7', '常识', '是', '不是', '', '', 'b');
INSERT INTO `topics` VALUES ('260', '规模较小的有限责任公司，可以不设董事会吗？', '8', '政治', '可以', '不可以', '', '', 'a');
INSERT INTO `topics` VALUES ('261', '世界上最深的湖是:', '5', '地理', '苏必利尔湖', '里海', '贝加尔湖', '', 'c');
INSERT INTO `topics` VALUES ('262', '世界上第一辆摩托车其主要材料是', '4', '历史', '塑料', '木头', '铁皮', '自行车', 'b');
INSERT INTO `topics` VALUES ('263', '“初出茅庐”中的“茅庐”本意是指谁的的住处？', '9', '文学', '诸葛亮', '司马迁', '司马光', '刘备', 'a');
INSERT INTO `topics` VALUES ('264', '合伙企业申请营业执照时下列哪项不是必须提交的？', '8', '政治', '申请书', '合伙协议', '合伙人身份证明', '合伙人出资证明', 'd');
INSERT INTO `topics` VALUES ('265', '世界上最后进入元旦的是', '5', '地理', '斐济', '西萨摩亚群岛', '汤加', '', 'b');
INSERT INTO `topics` VALUES ('266', '血液中的红细胞可以活', '14', '自然', '7天', '120天', '一生', '', 'b');
INSERT INTO `topics` VALUES ('267', '被称为&quot;命运交响曲&quot;的是贝多芬的', '15', '音乐', '第三交响曲', '第五交响曲', '第九交响曲', '第六交响曲', 'b');
INSERT INTO `topics` VALUES ('268', '一个帝王陵区只有一个主神道，一般修在谁的陵前？', '4', '历史', '第一个埋葬者', '年龄最大者', '统治时间最长者', '国力最昌盛者', 'a');
INSERT INTO `topics` VALUES ('269', '正规围棋比赛的棋盘大小是', '2', '体育', '13乘13', '15乘15', '19乘19', '21乘21', 'c');
INSERT INTO `topics` VALUES ('270', '北极星处于天空中的', '6', '天文', '大熊星座', '小熊星座', '', '', 'b');
INSERT INTO `topics` VALUES ('271', '茶叶的含水量高于8%会导致什么后果？', '3', '化学', '茶叶味道更好', '发生霉变', '', '', 'b');
INSERT INTO `topics` VALUES ('272', '受委托代理销售房屋的房地产中介机构除有工商执照外还应有', '8', '政治', '营业执照', '税务登记', '资质证书', '', 'c');
INSERT INTO `topics` VALUES ('273', '有一尊青铜镀金像，其造型是一位手握长剑、屹立在一盘电影胶片上的健美勇士，它是', '9', '文学', '金棕榈奖', '奥斯卡金像奖', '金熊奖', '金狮奖', 'b');
INSERT INTO `topics` VALUES ('274', '居住在蒙古与内蒙古地区的民族联合，并自称“蒙古”，起于何时？', '5', '地理', '耶律亿', '成吉思汗', '', '', 'b');
INSERT INTO `topics` VALUES ('275', '宪法规定公民有受教育的', '8', '政治', '权利', '义务', '权力和义务', '权利和义务', 'd');
INSERT INTO `topics` VALUES ('276', '最早的四冲程内燃机用的是什么燃料？', '11', '物理', '酒精', '煤气', '汽油', '柴油', 'b');
INSERT INTO `topics` VALUES ('277', '可以用厚纸做容器来把水烧开吗？', '7', '常识', '可以', '不可以', '', '', 'a');
INSERT INTO `topics` VALUES ('278', '第一届世界杯足球赛是在哪里举办的？', '2', '体育', '乌拉圭', '墨西哥', '阿根廷', '意大利', 'a');
INSERT INTO `topics` VALUES ('279', '古人说的“酢”指的是今天的', '9', '文学', '酱油', '豆油', '醋', '酒', 'c');
INSERT INTO `topics` VALUES ('280', '北京圆明园由哪三园构成？', '5', '地理', '圆明、长春和万春', '圆明、清漪和谐趣', '', '', 'a');
INSERT INTO `topics` VALUES ('281', '在下列哪一年Internet网延伸入中国？', '4', '历史', '93年', '94年', '95年', '96年', 'b');
INSERT INTO `topics` VALUES ('282', '按图索骥中的“骥”本意指的是', '9', '文学', '马', '一个叫骥的人', '牛', '', 'a');
INSERT INTO `topics` VALUES ('283', '太阳的年龄约有多大？', '6', '天文', '30亿岁', '50亿岁', '80亿岁', '100亿岁', 'b');
INSERT INTO `topics` VALUES ('284', '下列哪种人最适宜坚持慢跑？', '7', '常识', '肺病', '肝病', '心脏病', '', 'c');
INSERT INTO `topics` VALUES ('285', '举办过夏季奥运会次数最多的国家是那一个国家？', '2', '体育', '英国', '希腊', '美国', '意大利', 'c');
INSERT INTO `topics` VALUES ('286', '婴儿一般在多大时添加辅助食品比较好？', '14', '自然', '2、3个月', '5、6个月', '7、8个月', '9、10个月', 'b');
INSERT INTO `topics` VALUES ('287', '某显示器分辨率为640*480，则其水平分辨率为', '12', '电脑', '640点', '480点', '', '', 'a');
INSERT INTO `topics` VALUES ('288', '月球地球转一周与其自转一周的时间相比', '6', '天文', '要长些', '要短些', '一样长', '', 'c');
INSERT INTO `topics` VALUES ('289', '破产企业甲曾与乙企业共同出资合办一法人企业丙，则甲出资投入丙的财产', '8', '政治', '应作为破产财产', '不应作为破产财产', '', '', 'a');
INSERT INTO `topics` VALUES ('290', '左脑损伤可能导致', '14', '自然', '失语症', '空间定向障碍', '', '', 'a');
INSERT INTO `topics` VALUES ('291', '人体消化道中最长的器官是', '14', '自然', '大肠', '小肠', '', '', 'b');
INSERT INTO `topics` VALUES ('292', '“惊天动地”作为成语，原本是形容', '9', '文学', '火药发明的作用', '唐太宗驾崩的消息', '李白诗文的影响力', '', 'c');
INSERT INTO `topics` VALUES ('293', '吸烟不会引起心脏病，对吗？', '7', '常识', '对', '错', '', '', 'b');
INSERT INTO `topics` VALUES ('294', '汉字“廿”是表示', '9', '文学', '十', '二十', '', '', 'b');
INSERT INTO `topics` VALUES ('295', '防风林要达到最好的防风效果，应由', '5', '地理', '5―10行树组成', '10行以上树组成', '', '', 'b');
INSERT INTO `topics` VALUES ('296', '桃子属于什么种类水果？', '14', '自然', '仁果类', '核果类', '复果类', '', 'b');
INSERT INTO `topics` VALUES ('297', '杜甫的诗《江南逢李龟年》中的李龟年是哪个朝代的人？', '9', '文学', '唐朝', '宋朝', '明朝', '', 'a');
INSERT INTO `topics` VALUES ('298', '下列行星中，卫星最多的是', '6', '天文', '水星', '地球', '土星', '', 'c');
INSERT INTO `topics` VALUES ('299', '以下哪一个不是伦敦名胜?', '5', '地理', '托威尔城堡', '白金汗宫', '威斯敏斯特教堂', '卢浮宫', 'd');
INSERT INTO `topics` VALUES ('300', '汉白玉是什么', '7', '常识', '一种名贵的石头', '一种玉', '', '', 'a');
INSERT INTO `topics` VALUES ('301', '阿里山是一座山吗？', '7', '常识', '是', '否', '', '', 'b');
INSERT INTO `topics` VALUES ('302', '电影界“百花奖”的主办单位是', '9', '文学', '《大众电影》杂志社', '中国电影家协会', '', '', 'a');
INSERT INTO `topics` VALUES ('303', '我国国防系统最高学府是下列哪所大学？', '8', '政治', '清华大学', '北京航空航天大学', '北京大学', '国防大学', 'd');
INSERT INTO `topics` VALUES ('304', '《思想者》是谁的雕塑作品？', '9', '文学', '罗丹', '罗曼·罗兰', '罗素', '', 'a');
INSERT INTO `topics` VALUES ('305', '纳税人所在地为县城，城市维护建设税的税率为', '8', '政治', '7%', '5%', '1%', '0.5%', 'b');
INSERT INTO `topics` VALUES ('306', '&quot;紫毫”是用什么动物的毛做成的毛笔？', '7', '常识', '黄鼠狼', '兔', '羊', '', 'b');
INSERT INTO `topics` VALUES ('307', 'ISO14000认证是哪一方面的认证?', '7', '常识', '商业', '交通', '环保', '能源', 'c');
INSERT INTO `topics` VALUES ('308', '&quot;马拉松赛跑”是为了纪念公元前490年希腊战士菲迪皮跑步报捷累死的故事，请问他报捷跑步的路线是？', '2', '体育', '从雅典到马拉松', '从马拉松到雅典', '', '', 'b');
INSERT INTO `topics` VALUES ('309', '中国在国际货币基金组织中属于', '8', '政治', '观察员', '正式成员', '准成员', '非成员', 'b');
INSERT INTO `topics` VALUES ('310', '标志中国法制向半殖民地半封建法制过渡和确立的法律是', '8', '政治', '《大清律》', '《大清新刑法》', '《六法全书》', '《中华民国约法》', 'c');
INSERT INTO `topics` VALUES ('311', '&quot;粉刺”就是', '7', '常识', '疥疮', '痤疮', '疣', '', 'b');
INSERT INTO `topics` VALUES ('312', '有“五海三洲之地”之称的是', '5', '地理', '西亚', '南亚', '中亚', '东亚', 'a');
INSERT INTO `topics` VALUES ('313', '我们什么时候能看到更多的流星？', '6', '天文', '上半夜', '下半夜', '', '', 'b');
INSERT INTO `topics` VALUES ('314', '少年韩寒中学肄业却出了一本叫做《三重门》的书，这本书的体裁是', '9', '文学', '散文', '小说', '', '', 'b');
INSERT INTO `topics` VALUES ('315', '成语“卑以自牧”中“牧”指的是', '9', '文学', '放牧', '放松', '养性', '', 'c');
INSERT INTO `topics` VALUES ('316', '蜘蛛大量吐丝结网预示着', '14', '自然', '天要转晴', '天要下雨', '', '', 'a');
INSERT INTO `topics` VALUES ('317', '在高速公路上行驶的机动车辆如果遇到能见度小于50米的大雾，最高时速不得超过多少？', '7', '常识', '20公里', '25公里', '30公里', '35公里', 'a');
INSERT INTO `topics` VALUES ('318', '称为我国岭南四大名果之一、古人叫它“长腰黄果”的是', '10', '旅游', '柑橙', '菠萝', '香蕉', '', 'c');
INSERT INTO `topics` VALUES ('319', '电鳗是一种鳗鱼吗？', '14', '自然', '是', '不是', '', '', 'b');
INSERT INTO `topics` VALUES ('320', '我国最早的字典是', '9', '文学', '《说文解字》', '《康熙字典》', '《辞海》', '', 'a');
INSERT INTO `topics` VALUES ('321', '人体内易于疲劳的肌肉是', '14', '自然', '平滑肌', '心肌', '骨骼肌', '', 'c');
INSERT INTO `topics` VALUES ('322', '抗战时期，“八路军”下辖3个师和一个直属队，刘伯承在', '4', '历史', '115师', '120师', '129师', '直属队', 'c');
INSERT INTO `topics` VALUES ('323', '就体裁而言，正史都是', '9', '文学', '纪传体史书', '编年体史书', '纪事本末体史书', '典志体史书', 'a');
INSERT INTO `topics` VALUES ('324', '下列对清明两代“乡试”考试地点解释正确的是', '4', '历史', '在本乡', '在各县县城', '在各省省城', '在京城书院', 'c');
INSERT INTO `topics` VALUES ('325', '下列山脉中，既是地势阶梯分界，又是省区界线的是', '5', '地理', '巫山', '天山', '长白山', '武夷山', 'a');
INSERT INTO `topics` VALUES ('326', '麋鹿被称为“四不象”。它们中的哪种性别长有鹿角？', '14', '自然', '雄性', '两种都长', '雌性', '', 'b');
INSERT INTO `topics` VALUES ('327', '自行车的红色尾灯只是个装饰品吗？', '7', '常识', '是', '不是', '', '', 'b');
INSERT INTO `topics` VALUES ('328', '“沧海桑田”的沧海应是', '9', '文学', '东海', '南海', '黄海', '渤海', 'a');
INSERT INTO `topics` VALUES ('329', '公安交通管理部门对机动车驾驶员实施交通违章记分管理办法适用于下列哪一项？', '8', '政治', '全国的机动车驾驶员', '北京的机动车驾驶', '部分特大城市的机动车驾驶员', '', 'a');
INSERT INTO `topics` VALUES ('330', '穿什么颜色的衣服的人更容易挨蚊子叮？', '7', '常识', '黑色', '白色', '', '', 'a');
INSERT INTO `topics` VALUES ('331', '哈雷慧星的最早记录是哪国人留下的？', '4', '历史', '埃及人', '希腊人', '中国人', '波斯人', 'c');
INSERT INTO `topics` VALUES ('332', '寒潮将至的时候，蜘蛛会', '14', '自然', '大量吐丝结网', '不再吐丝结网', '', '', 'a');
INSERT INTO `topics` VALUES ('333', '别名“詹氏车钩”的火车自动挂钩', '13', '科技', '是詹天佑发明的', '不是詹天佑发明的', '', '', 'b');
INSERT INTO `topics` VALUES ('334', '某人去年买一股票跌了20%，问今年需上涨多少才能保持原值？', '8', '政治', '20%', '24%', '25%', '', 'c');
INSERT INTO `topics` VALUES ('335', '世界上最狭长的国家是', '5', '地理', '智利', '俄罗斯', '加拿大', '巴西', 'a');
INSERT INTO `topics` VALUES ('336', '在江浙一带最流行的地方戏曲是', '5', '地理', '越剧', '黄梅戏', '京剧', '昆曲', 'a');
INSERT INTO `topics` VALUES ('337', '人体最大的细胞是', '14', '自然', '卵细胞', '小脑颗粒细胞', '神经细胞', '', 'a');
INSERT INTO `topics` VALUES ('338', '海龟是', '14', '自然', '两栖动物', '爬行动物', '哺乳动物', '', 'b');
INSERT INTO `topics` VALUES ('339', '美术作品&lt;&lt;开国大典&gt;&gt; 是一幅', '9', '文学', '国画', '水粉画', '水彩画', '油画', 'd');
INSERT INTO `topics` VALUES ('340', '“临风舒四翼，映水作双身”描写的是:', '9', '文学', '蜻蜓', '燕子', '蝴蝶', '', 'a');
INSERT INTO `topics` VALUES ('341', '玉米受潮后产生的致癌物质是', '3', '化学', '黄曲霉毒素', '氯霉素', '', '', 'a');
INSERT INTO `topics` VALUES ('342', '鲨鱼用什么呼吸？', '14', '自然', '肺', '鳃', '', '', 'b');
INSERT INTO `topics` VALUES ('343', '进行京剧表演的戏院，在清朝最早叫', '9', '文学', '茶园', '梨园', '剧院', '剧场', 'a');
INSERT INTO `topics` VALUES ('344', '目前人类已知的最软的石头是', '4', '历史', '磷灰石', '石膏', '方解石', '滑石', 'd');
INSERT INTO `topics` VALUES ('345', '易卜生曾写过', '9', '文学', '《玩偶之家》', '《尤里西斯》', '', '', 'a');
INSERT INTO `topics` VALUES ('346', '因纳税人、扣缴义务人计算等错误，未缴或少缴税款的，税务机关的追征期最长为', '8', '政治', '3年', '5年', '8年', '10年', 'd');
INSERT INTO `topics` VALUES ('347', '巴林在东半球的哪个地区？', '5', '地理', '东南亚', '波斯湾', '红海', '澳洲', 'b');
INSERT INTO `topics` VALUES ('348', '陆军棋有多少枚棋子？', '2', '体育', '50', '60', '40', '70', 'a');
INSERT INTO `topics` VALUES ('349', '世界最深的洼地是', '5', '地理', '地中海', '死海', '红海', '黑海', 'b');
INSERT INTO `topics` VALUES ('350', '涮羊肉起源于', '4', '历史', '清朝', '元朝', '', '', 'b');
INSERT INTO `topics` VALUES ('351', '马铃薯的薯块是', '14', '自然', '根', '茎', '', '', 'b');
INSERT INTO `topics` VALUES ('352', '“打假”获赔要交纳个人所得税吗？', '8', '政治', '需要', '不需要', '', '', 'b');
INSERT INTO `topics` VALUES ('353', '以郁金香而闻名世界的“欧洲花园”是', '5', '地理', '英国', '法国', '荷兰', '', 'c');
INSERT INTO `topics` VALUES ('354', '泥娃娃“大阿福”的老家是', '5', '地理', '江苏无锡', '江西景德镇', '浙江杭州', '浙江龙泉', 'a');
INSERT INTO `topics` VALUES ('355', '下面哪类证券公司可以从事证券自营业务？', '8', '政治', '综合类证券公司', '经纪类证券公司', '', '', 'a');
INSERT INTO `topics` VALUES ('356', 'INTERNET的中文名称是', '12', '电脑', '因特网', '以太网', '令牌环网', '计算机网', 'a');
INSERT INTO `topics` VALUES ('357', '当你面朝南时，左面是', '7', '常识', '东', '西', '', '', 'a');
INSERT INTO `topics` VALUES ('358', '手心和大腿相比，汗腺比较多的部位是', '14', '自然', '手心', '大腿', '', '', 'b');
INSERT INTO `topics` VALUES ('359', '不是《诗经》分类方法的是', '9', '文学', '风', '雅', '赋', '颂', 'c');
INSERT INTO `topics` VALUES ('360', '“加农炮”的“加农”是音译词，意为', '9', '文学', '坦克', '低射', '炮', '', 'c');
INSERT INTO `topics` VALUES ('361', '火山喷发时大量岩浆喷涌而出，岩浆作用的发源地是', '5', '地理', '地壳', '上地幔', '下地幔', '地核', 'b');
INSERT INTO `topics` VALUES ('362', '下列哪种植物不能在一块地连续种植？', '14', '自然', '水稻', '亚麻', '西瓜', '马铃薯', 'c');
INSERT INTO `topics` VALUES ('363', '以下三种材料中最耐腐蚀的是', '3', '化学', '聚四氟乙烯', '不锈钢', '陶瓷', '', 'a');
INSERT INTO `topics` VALUES ('364', '之所以把鸽子喻为象征和平安宁源于', '5', '地理', '圣经故事', '世界和平大会的会徽图案', '民歌&lt;&lt;鸽子&gt;&gt;', '', 'a');
INSERT INTO `topics` VALUES ('365', '旅客办理的行李包裹托运，铁路行李房应该送货上门吗？', '10', '旅游', '应该', '不应该', '', '', 'b');
INSERT INTO `topics` VALUES ('366', '茶叶依发酵程度不同分为三种，是', '3', '化学', '绿茶、花茶和红茶', '绿茶、乌龙茶和红茶', '新茶、炒青和凤眉', '', 'b');
INSERT INTO `topics` VALUES ('367', '胡萝卜呈黄色是因为含有', '3', '化学', '胡萝卜素', '叶黄素', '', '', 'b');
INSERT INTO `topics` VALUES ('368', '冰球比赛中每队上场', '2', '体育', '6人', '7人', '8人', '', 'a');
INSERT INTO `topics` VALUES ('369', '符号“&amp;&quot;的中文意思是', '12', '电脑', '的', '也', '和', '但', 'c');
INSERT INTO `topics` VALUES ('370', '在我国内地驾驶车辆，必须遵守', '7', '常识', '右侧通行的原则', '左侧通行的原则', '中间通行的原则', '', 'a');
INSERT INTO `topics` VALUES ('371', '歌剧《茶花女》谁的作品？', '9', '文学', '威尔第', '普契尼', '比才', '瓦格纳', 'a');
INSERT INTO `topics` VALUES ('372', '狗的鼻尖为什么经常是湿乎乎的？', '14', '自然', '滋润嗅觉细胞的分泌物', '经常喝水而弄湿的', '鼻子怕冷而冻出来的', '经常用唾液清洗', 'a');
INSERT INTO `topics` VALUES ('373', '&quot;龟纹”在哪种工艺品中出现？', '10', '旅游', '刺绣', '蜡染', '扎染', '', 'b');
INSERT INTO `topics` VALUES ('374', '人体缺少哪种元素会造成甲状腺肿大', '3', '化学', '钙', '锌', '碘', '', 'c');
INSERT INTO `topics` VALUES ('375', '唐高祖武德四年的开元通宝，开元所代表的意思为', '4', '历史', '开辟新纪元', '年号', '', '', 'a');
INSERT INTO `topics` VALUES ('376', '深海海底生命的源泉是', '5', '地理', '阳光', '海底热泉', '海底矿物', '', 'b');
INSERT INTO `topics` VALUES ('377', '引起人体休克的原因很多，但都具有一个共同点，就是', '14', '自然', '电解质代谢失常', '有效循环血量减少', '体液丢失', '', 'b');
INSERT INTO `topics` VALUES ('378', '一个标准的足球，它的周长大概有', '2', '体育', '50-60cm', '60-70cm', '70-80cm', '', 'a');
INSERT INTO `topics` VALUES ('379', '为什么鱼儿喜欢成群结队地在水中游动？', '14', '自然', '为了对抗外敌', '为了游动省力', '为了捕食', '为了求偶', 'b');
INSERT INTO `topics` VALUES ('380', '人类古代的“掠夺婚”产生于哪个时期？', '4', '历史', '母权制初期', '父权制初期', '对偶婚时期', '', 'b');
INSERT INTO `topics` VALUES ('381', '因房屋产权问题引起的诉讼，由', '8', '政治', '原告所在地法院管辖', '被告所在地法院管辖', '房屋所在地法院管辖', '原告经常居住地法院管辖', 'c');
INSERT INTO `topics` VALUES ('382', '以下哪一种东西，是川菜的常用调料？', '7', '常识', '孜然', '紫苏', '豆瓣', '香椿', 'c');
INSERT INTO `topics` VALUES ('383', '“波谲云诡”最初是用来形容', '9', '文学', '气候', '战场', '房屋', '', 'c');
INSERT INTO `topics` VALUES ('384', '秦朝开始推行郡县制度，在全国设', '4', '历史', '24郡', '36郡', '20郡', '40郡', 'b');
INSERT INTO `topics` VALUES ('385', '自控能力过分不足，注意力无法集中是什么儿童的主要表现', '7', '常识', '超常儿童', '天才儿童', '多动症儿童', '早熟儿童', 'c');
INSERT INTO `topics` VALUES ('386', '“打蛇打七寸”的七寸是指', '9', '文学', '咽喉', '心脏', '', '', 'b');
INSERT INTO `topics` VALUES ('387', '宋代的&quot;学象生&quot;同现代的', '4', '历史', '口技', '相声', '舞狮子', '', 'a');
INSERT INTO `topics` VALUES ('388', '古代五音——宫、商、角、徵、羽，相当于现行简谱上的', '15', '音乐', '1、2、3、4 、5', '1、2、3、5、6', '1、2、3、4、7', '', 'b');
INSERT INTO `topics` VALUES ('389', '世界上最大的宫殿是', '5', '地理', '故宫', '白宫', '爱丽舍宫', '克里姆林宫', 'a');
INSERT INTO `topics` VALUES ('390', '王利曾以汽车为张海的债务提供抵押担保，若张海不能偿还债务，且将王利的汽车变卖后，仍不足清偿，则不足部分应由谁来清偿？', '8', '政治', '王利', '张海', '', '', 'a');
INSERT INTO `topics` VALUES ('391', '中国不产狮子却有“舞狮”传统，那么中国人在兴起舞狮前舞什么？', '10', '旅游', '麒麟', '虎', '牛', '', 'b');
INSERT INTO `topics` VALUES ('392', '缴纳增值税的纳税人，其税务登记管理由哪负责？', '8', '政治', '国税局', '地税局', '', '', 'a');
INSERT INTO `topics` VALUES ('393', '第一次国际“大运会”在哪国举行?', '2', '体育', '希腊', '法国', '英国', '美国', 'b');
INSERT INTO `topics` VALUES ('394', '《藤王阁序》的作者是', '9', '文学', '卢照邻', '骆宾王', '杨炯', '王勃', 'd');
INSERT INTO `topics` VALUES ('395', '贷款买车，如在还款期间银行利率发生变化，还款利息', '8', '政治', '不变', '随利率调整，一年一定', '', '', 'b');
INSERT INTO `topics` VALUES ('396', '预防颈椎病，下列哪种方法是错误的？', '14', '自然', '低枕睡眠', '睡软床', '按摩颈部肌肉', '注意颈部旋转屈伸活动', 'b');
INSERT INTO `topics` VALUES ('397', '以下哪种动物的血压最高？', '14', '自然', '长颈鹿', '斑马', '大象', '', 'a');
INSERT INTO `topics` VALUES ('398', '继承人在继承遗产时，要不要继承被继承人的债务？', '8', '政治', '要', '不要', '', '', 'a');
INSERT INTO `topics` VALUES ('399', '液晶是液态的晶体吗？', '11', '物理', '是', '不是', '', '', 'a');
INSERT INTO `topics` VALUES ('400', '汽油有不同的品种（如90号、93号等），这些数字表示的汽油标号是其', '3', '化学', '甲烷值指标', '辛烷值指标', '丁烷值指标', '', 'b');
INSERT INTO `topics` VALUES ('401', '中国最早的地理学家是？', '5', '地理', '刘微', '郦道元', '徐霞客', '徐光启', 'b');
INSERT INTO `topics` VALUES ('402', '保险责任开始后，投保人要求解除合同的，保险人可以', '8', '政治', '收取全部保险费', '要求投保人支付违约金', '收取手续费', '收取部分保险费', 'd');
INSERT INTO `topics` VALUES ('403', '著名的“响尾蛇”空对空导弹是采用', '13', '科技', '雷达制导系统', '红外线制导系统', '激光制导系统', '', 'b');
INSERT INTO `topics` VALUES ('404', '世界上第一种基因移植作物是', '4', '历史', '番茄', '烟草', '白菜', '', 'b');
INSERT INTO `topics` VALUES ('405', '以下哪种人，不属于古代日耳曼民族？', '4', '历史', '西哥特人', '萨克森人', '希洛人', '法兰克人', 'c');
INSERT INTO `topics` VALUES ('406', '“活化石”银杏又叫“公孙树”，这是因为银杏', '14', '自然', '盘根错节', '生长缓慢', '枝叶茂盛', '树皮粗糙', 'b');
INSERT INTO `topics` VALUES ('407', '蜜蜂中的“蜂王”是', '14', '自然', '雌蜂', '雄蜂', '', '', 'a');
INSERT INTO `topics` VALUES ('408', '《老人河》是', '15', '音乐', '俄国歌曲', '美国歌曲', '日本歌曲', '法国歌曲', 'b');
INSERT INTO `topics` VALUES ('409', '夫妻因感情不和分居满几年的，且调解无效的，应准予离婚？', '8', '政治', '1年', '2年', '3年', '4年', 'b');
INSERT INTO `topics` VALUES ('410', '法国画家大卫的《马拉之死》是一幅', '9', '文学', '肖像画', '历史画', '', '', 'b');
INSERT INTO `topics` VALUES ('411', '据考古资料显示，我国的钻孔技术开始于', '4', '历史', '山顶洞人时代', '母系氏族繁荣时期', '父系氏族时期', '夏朝', 'a');
INSERT INTO `topics` VALUES ('412', '为什么麻雀经常在地上蹦来蹦去，而燕子很少下地活动？', '14', '自然', '燕子怕冷', '燕子怕脏', '燕子在空中觅食', '', 'c');
INSERT INTO `topics` VALUES ('413', '碳、石墨和钻石的原子组成', '11', '物理', '相同', '不同', '', '', 'a');
INSERT INTO `topics` VALUES ('414', '蒙古族姑娘出嫁前要吃', '10', '旅游', '羊胸脯肉', '牛里脊肉', '马肉', '野兔肉', 'a');
INSERT INTO `topics` VALUES ('415', '海河是扇形水系吗？', '5', '地理', '是', '不是', '', '', 'a');
INSERT INTO `topics` VALUES ('416', '王某明知李某制造毒品但仍为其提供制造毒品的原料，按何罪论处？', '8', '政治', '以非法贩卖制毒物品罪论处', '以非法提供毒品罪论处', '以制造毒品罪的共犯论处', '以制造毒品罪论处', 'c');
INSERT INTO `topics` VALUES ('417', '馒头是谁发明的？', '4', '历史', '李冰', '诸葛亮', '曹操', '', 'b');
INSERT INTO `topics` VALUES ('418', '评剧起源于', '9', '文学', '北京农村流行的“对口莲花落”', '“唐山落子”', '“奉天落子”', '', 'a');
INSERT INTO `topics` VALUES ('419', '购房者在购买建筑面积超出120平方米的各类商品住房时需要缴纳多少契税？', '8', '政治', '房屋成交价2%', '房屋成交价4%', '房屋成交价6%', '', 'b');
INSERT INTO `topics` VALUES ('420', '在摄氏零下40度以下，应该使用哪种温度计？', '11', '物理', '酒精温度计', '水银温度计', '', '', 'a');
INSERT INTO `topics` VALUES ('421', '干香菇怎样浸泡味更鲜？', '7', '常识', '用热水浸泡', '用凉水浸泡', '', '', 'a');
INSERT INTO `topics` VALUES ('422', '以下电影歌曲中由外国人作曲的是', '15', '音乐', '《城南旧事》插曲《送别》', '《花样年华》插曲《花样的年华》', '《大话西游》主题曲《一生中最爱》', '', 'a');
INSERT INTO `topics` VALUES ('423', '最早的春联是', '4', '历史', '刻在木上', '写在纸上', '雕在石上', '绣在绸上', 'a');
INSERT INTO `topics` VALUES ('424', '华表的柱头有一蹲兽，其中头朝外的叫', '9', '文学', '望帝归', '望帝出', '', '', 'a');
INSERT INTO `topics` VALUES ('425', '东汉时，谁既是杰出的科学家又是著名的文学家？', '4', '历史', '王充', '张衡', '', '', 'b');
INSERT INTO `topics` VALUES ('426', '保险公司可以采取下列哪项组织形式？', '8', '政治', '有限责任公司', '国有有限责任公司', '股份有限公司合有限责任公司', '股份有限公司和国有独资公司', 'd');
INSERT INTO `topics` VALUES ('427', '晚上看电视时，屋里的灯应该怎样？', '7', '常识', '全部开亮', '全部关掉', '用瓦数较低的灯', '', 'c');
INSERT INTO `topics` VALUES ('428', '目前，电子计算机处于哪个阶段？', '12', '电脑', '晶体管时代', '集成电路时代', '大规模和超大规模集成电路时代', '', 'c');
INSERT INTO `topics` VALUES ('429', '适量补充下列哪种元素可防治粉刺?', '3', '化学', '铁', '锌', '钙', '铜', 'b');
INSERT INTO `topics` VALUES ('430', '国家在对外关系上的最高代表是', '8', '政治', '国家元首', '政府首脑', '外交部长', '大使', 'a');
INSERT INTO `topics` VALUES ('431', '编舞蹈动作时，主要依据的是应该是', '15', '音乐', '音乐', '歌词', '', '', 'a');
INSERT INTO `topics` VALUES ('432', '有限责任公司的有限责任是指', '8', '政治', '公司的股东仅以出资额为限对公司的债务负责', '公司仅对债务负有限责任', '公司经理对公司债务负有限责任', '公司对其债务不负责任', 'a');
INSERT INTO `topics` VALUES ('433', '约翰内斯堡是南非最大的采矿中心，它被称为', '5', '地理', '钻石城', '白金城', '黄金城', '铀矿城', 'c');
INSERT INTO `topics` VALUES ('434', '蜘蛛是昆虫吗？', '14', '自然', '是', '不是', '', '', 'b');
INSERT INTO `topics` VALUES ('435', '近来被人们津津乐道的一种以长度单位为名称的技术叫做', '13', '科技', '忽米技术', '纳米技术', '微米技术', '', 'b');
INSERT INTO `topics` VALUES ('436', '郭沫若同志曾热情地赞美过什么树，并称其为“中国的国树”', '9', '文学', '水杉', '红豆', '银杏', '枫树', 'c');
INSERT INTO `topics` VALUES ('437', '小王家的水壶中积有大量水垢，长期饮用此壶中水的人', '3', '化学', '易得结石症', '易得心血管疾病', '易得胃溃疡', '健康不受影响', 'd');
INSERT INTO `topics` VALUES ('438', '古语中的“丹书铁券”是指', '9', '文学', '光辉的史册', '豪放的诗词', '免罪的凭证', '', 'c');
INSERT INTO `topics` VALUES ('439', '最精确的现代原子钟每170万年误差只有', '13', '科技', '1秒', '2秒', '3秒', '', 'a');
INSERT INTO `topics` VALUES ('440', '蘑菇属于菌类,它是一种', '14', '自然', '动物', '植物', '', '', 'b');
INSERT INTO `topics` VALUES ('441', '放大镜的设计原理是采用了', '11', '物理', '凸透镜', '凹透镜', '', '', 'a');
INSERT INTO `topics` VALUES ('442', '四川盆地除了&quot;红色盆地&quot;之称外，还有一个称呼是', '5', '地理', '紫色盆地', '黑色盆地', '绿色盆地', '', 'a');
INSERT INTO `topics` VALUES ('443', '我国珍稀野生动物特种纪念币系列的首枚纪念币图案是', '4', '历史', '大熊猫', '金丝猴', '扬子鳄', '白鳍豚', 'a');
INSERT INTO `topics` VALUES ('444', '“世界足球之王”贝利的球衣号为', '2', '体育', '10号', '12号', '23号', '', 'a');
INSERT INTO `topics` VALUES ('445', '“尧天禹日”是指代什么的?', '4', '历史', '改朝换代', '太平盛世', '一朝天子一朝臣', '饥荒年代', 'b');
INSERT INTO `topics` VALUES ('446', '硫能溶进酒精吗？', '3', '化学', '不溶', '微溶', '易溶', '', 'b');
INSERT INTO `topics` VALUES ('447', '鲨鱼有鱼鳔吗？', '14', '自然', '有', '没有', '', '', 'b');
INSERT INTO `topics` VALUES ('448', '如果把一个可入肺颗粒物与一个篮球相比，下面与这个比例最为相近的是', '14', '自然', '一个篮球与一个足球场相比', '一个篮球与地球相比', '一个篮球与100个足球场相比', '', 'b');
INSERT INTO `topics` VALUES ('449', '隋唐时期的官制中尚书省分为吏,户,礼,兵,刑,工六部,其中的礼部是掌管', '4', '历史', '规定礼仪,监督和教育官员和百姓懂得礼仪', '掌管国家的典章法度,祭祀,学校,科举和接待四方宾客等事务', '', '', 'b');
INSERT INTO `topics` VALUES ('450', '苔藓是植物吗？', '14', '自然', '是', '不是', '', '', 'b');
INSERT INTO `topics` VALUES ('451', '每届奥运会前夕，在奥林匹亚希腊女神赫拉庙旁，通过什么方式点燃奥运火炬？', '2', '体育', '用火柴点燃', '在“永不熄灭”的火种盆里点燃', '用凹面镜聚集日光点燃', '', 'c');
INSERT INTO `topics` VALUES ('452', '人的大肠与小肠相比', '14', '自然', '大肠长', '小肠长', '一样长', '', 'b');
INSERT INTO `topics` VALUES ('453', '潮汐主要是由什么引力而形成的？', '5', '地理', '月球', '太阳', '', '', 'a');
INSERT INTO `topics` VALUES ('454', '古语 “待字”中，“字”的意思是指', '9', '文学', '字体', '墨宝', '出嫁', '', 'c');
INSERT INTO `topics` VALUES ('455', '贫铀弹有无放射性?', '3', '化学', '有', '无', '', '', 'a');
INSERT INTO `topics` VALUES ('456', '最清洁的能源是', '11', '物理', '石油', '太阳能', '煤气', '沼气', 'b');
INSERT INTO `topics` VALUES ('457', '中国最大的湖泊是', '5', '地理', '青海湖', '洞庭湖', '鄱阳湖', '', 'a');
INSERT INTO `topics` VALUES ('458', '纽约和法兰克福外汇市场美元对马克的汇率分别为1美元=1.5马克和1美元=1.501马克,则在纽约买进1000万美元同时在法兰克福卖出1000万美元会', '8', '政治', '赚钱', '赔钱', '不赔不赚', '', 'a');
INSERT INTO `topics` VALUES ('459', '新西兰的几维鸟是曾与恐龙生活在同一时代的古老鸟类，它', '5', '地理', '有翅无尾', '有尾无翅', '无尾无翅', '有尾有翅', 'c');
INSERT INTO `topics` VALUES ('460', '亡羊补牢中的“牢”指的是', '9', '文学', '牢房', '牲口圈', '院子栅栏', '', 'b');
INSERT INTO `topics` VALUES ('461', '一些小轿车的尾部装有翘起的板，这种板可以使汽车', '11', '物理', '形成向上的升力，减少车轮与路面的摩擦，行驶得更快', '形成向下的压力，使车轮与路面的附着力增大，从而使汽车保持良好的操作性', '', '', 'b');
INSERT INTO `topics` VALUES ('462', '血液中，数量最少的是', '14', '自然', '红细胞', '白细胞', '血小板', '', 'b');
INSERT INTO `topics` VALUES ('463', '按我国中小学课程改革的规划，大中城市和县城所在镇以上小学几年级开始开设新型英语', '8', '政治', '1年级', '2年级', '3年级', '4年级', 'c');
INSERT INTO `topics` VALUES ('464', '熊猫属于食肉目还是食草目？', '14', '自然', '食肉目', '食草目', '', '', 'a');
INSERT INTO `topics` VALUES ('465', '力矩的单位是', '11', '物理', '牛顿', '米', '千克·米', '牛顿·米', 'd');
INSERT INTO `topics` VALUES ('466', '&quot;波尔卡&quot;是一种', '10', '旅游', '捷克民间舞蹈', '法国民间音乐', '', '', 'a');
INSERT INTO `topics` VALUES ('467', '被称为“乐圣”的外国音乐家为', '15', '音乐', '巴赫', '莫木扎特', '海顿', '贝多芬', 'd');
INSERT INTO `topics` VALUES ('468', '小王读完四年本科，除毕业设计外，其他功课都及格，学校按规定可发给他', '8', '政治', '毕业证', '结业证', '肄业证', '双学位证', 'b');
INSERT INTO `topics` VALUES ('469', '人类最早的“精子库”是为谁而建的？', '4', '历史', '不育男子', '参战士兵', '单身贵族', '', 'b');
INSERT INTO `topics` VALUES ('470', '国家草原所有权的取得方式有几种？', '8', '政治', '2种', '3种', '4种', '5种', 'a');
INSERT INTO `topics` VALUES ('471', '寒食节是为了纪念谁？', '10', '旅游', '重耳', '介之推', '晋文公', '魏武帝', 'b');
INSERT INTO `topics` VALUES ('472', '“汗流浃背”的典故出自西汉周勃，他 “汗流浃背”的原因是', '9', '文学', '衣服穿得过多', '劳动很卖力气', '打仗拼死厮杀', '答不出皇帝的问题', 'd');
INSERT INTO `topics` VALUES ('473', '长颈鹿的颈椎数和狗的颈椎数目一样多吗？', '14', '自然', '一样', '不一样', '', '', 'a');
INSERT INTO `topics` VALUES ('474', '内蒙古草原上的芨芨草最高可达', '5', '地理', '1.5米', '2米', '', '', 'b');
INSERT INTO `topics` VALUES ('475', '商品条形码前三位数是“690&quot;，表示什么？', '7', '常识', '商品质量', '中国生产', '制造厂商', '', 'b');
INSERT INTO `topics` VALUES ('476', '扑克牌是根据历法原理制成的，其中大小王分别代表', '7', '常识', '国王、王后', '白天、黑夜', '太阳、月亮', '春夏、秋冬', 'c');
INSERT INTO `topics` VALUES ('477', '提出“信息高速公路”的美国总统是', '5', '地理', '布什', '里根', '克林顿', '', 'c');
INSERT INTO `topics` VALUES ('478', '&quot;碧云天，黄叶地，北雁南飞&quot;语出', '9', '文学', '《墙头马上》', '《窦娥冤》', '《西厢记》', '《牡丹亭》', 'c');
INSERT INTO `topics` VALUES ('479', '显示器采用多少赫兹以上的刷新率才能基本消除屏幕闪烁对眼睛的危害？', '12', '电脑', '60 Hz', '75 Hz', '', '', 'b');
INSERT INTO `topics` VALUES ('480', '目前信息化水平居全国首位的是', '5', '地理', '北京', '上海', '广州', '', 'a');
INSERT INTO `topics` VALUES ('481', '下列哪项属于行政法律关系？', '8', '政治', '民政局小王和小李结婚', '公安局逮捕张某', '赵某违章驾车，交警对其罚款50元', '', 'c');
INSERT INTO `topics` VALUES ('482', '“来龙去脉”的成语产生于', '9', '文学', '历史研究', '风水勘探', '', '', 'b');
INSERT INTO `topics` VALUES ('483', '大兴安岭嘎仙洞石室，是古代哪个民族的发源地？', '5', '地理', '鲜卑', '匈奴', '', '', 'a');
INSERT INTO `topics` VALUES ('484', 'Internet最初用作', '12', '电脑', '军事', '工业', '民用', '', 'a');
INSERT INTO `topics` VALUES ('485', '在食用带鱼时，它身体表面的银白色物质必须洗掉吗？', '14', '自然', '必须洗掉', '不必洗掉', '', '', 'b');
INSERT INTO `topics` VALUES ('486', '李某用铁锤砸烂法院的国徽被判处有期徒刑两年，如他自愿包赔法院损失，则对其的判处', '8', '政治', '可减轻', '维持原判', '', '', 'b');
INSERT INTO `topics` VALUES ('487', '黑啤酒的突出香气是什么香？', '7', '常识', '麦芽香', '酒花清香', '', '', 'a');
INSERT INTO `topics` VALUES ('488', '“书圣”最佳含义是指', '9', '文学', '古代书法有高度成就的人', '著名作家', '著名典籍', '', 'a');
INSERT INTO `topics` VALUES ('489', '甘肃、青海一带的山歌在当地叫', '15', '音乐', '花儿', '信天游', '对花', '', 'a');
INSERT INTO `topics` VALUES ('490', '一听可口可乐的净含量是', '7', '常识', '350ml', '325ml', '355ml', '300ml', 'c');
INSERT INTO `topics` VALUES ('491', '“高官骑瘦马”的意思是', '9', '文学', '富而不显', '窝囊', '', '', 'a');
INSERT INTO `topics` VALUES ('492', '世界上最大的冰川在哪个洲？', '5', '地理', '北美洲', '亚洲', '欧洲', '南极洲', 'd');
INSERT INTO `topics` VALUES ('493', '著名雕塑《青铜时代》是谁的作品？', '9', '文学', '米开朗基罗', '贝尼尼', '罗丹', '达芬奇', 'c');
INSERT INTO `topics` VALUES ('494', '飞得最快的鸟是', '14', '自然', '信天翁', '蜂鸟', '雨燕', '', 'c');
INSERT INTO `topics` VALUES ('495', '鸡鸭在相同的条件下同时开始孵卵，小鸡先出世，对不对？', '14', '自然', '对', '不对', '', '', 'a');
INSERT INTO `topics` VALUES ('496', '夫妻离异后对未成年人子女的教育谁负有责任？', '8', '政治', '父亲负责任', '母亲负责任', '孩子随谁生活，谁负责任', '离异双方都有责任', 'd');
INSERT INTO `topics` VALUES ('497', '企业与职工的劳动合同中规定每月的5日发放工资，某月，企业在第15日才将工资发给职工，企业的这种作法是否是不允许的？', '8', '政治', '是', '否', '', '', 'a');
INSERT INTO `topics` VALUES ('498', '头发的生长周期比眉毛的生长周期长，对吗？', '14', '自然', '对', '错', '', '', 'a');
INSERT INTO `topics` VALUES ('499', '谁发现了白光是七色光组成的？', '11', '物理', '爱因斯坦', '牛顿', '阿基米德', '爱迪生', 'b');
INSERT INTO `topics` VALUES ('500', '我国家用电器使用的是', '11', '物理', '直流电', '交流电', '', '', 'b');
INSERT INTO `topics` VALUES ('501', '由宋庆龄创办的中国福利会是在哪里成立的？', '5', '地理', '广州', '香港', '', '', 'a');
INSERT INTO `topics` VALUES ('502', '根据对偶要求，下列与“孙行者”不相适合的是', '9', '文学', '唐三藏', '祖冲之', '胡适之', '孟浩然', 'a');
INSERT INTO `topics` VALUES ('503', '美国心理学家、行为学家马斯洛把人的需要分为几个层级？', '13', '科技', '3个', '5个', '6个', '4个', 'b');
INSERT INTO `topics` VALUES ('504', '欧洲最大的半岛在', '5', '地理', '北欧', '南欧', '', '', 'a');
INSERT INTO `topics` VALUES ('505', '银杏属于什么种类水果？', '14', '自然', '仁果类', '核果类', '坚果类', '复果类', 'c');
INSERT INTO `topics` VALUES ('506', '6岁的小明用石头把人打伤，谁来承担责任？', '8', '政治', '小明', '小明的父母', '', '', 'b');
INSERT INTO `topics` VALUES ('507', '哪个火山的爆发毁灭了古罗马帝国的庞贝城？', '4', '历史', '维苏威火山', '埃特纳火山', '圣海伦斯火山', '', 'a');
INSERT INTO `topics` VALUES ('508', '缫丝是要从蚕茧中去除', '14', '自然', '丝胶', '丝素', '', '', 'a');
INSERT INTO `topics` VALUES ('509', '当有水洒在材料表面上时，水滴难以侵入，称材料有憎水性。以下材料有憎水性的是？', '11', '物理', '瓦', '混凝土', '油漆', '', 'c');
INSERT INTO `topics` VALUES ('510', '&quot;海的女儿”是哪个城市的城徽？', '5', '地理', '哥本哈根', '华沙', '平壤', '广州', 'a');
INSERT INTO `topics` VALUES ('511', '下列王朝中统治时间最短的是', '4', '历史', '秦朝', '隋朝', '西晋', '元朝', 'a');
INSERT INTO `topics` VALUES ('512', '人的心脏中心房和心室共有几个？', '14', '自然', '1个', '2个', '3个', '4个', 'd');
INSERT INTO `topics` VALUES ('513', '怎样使黑色毛织物增黑？', '3', '化学', '用煮菠菜的水洗', '用盐水洗', '用碱水洗', '', 'a');
INSERT INTO `topics` VALUES ('514', '小提琴有几根弦？', '15', '音乐', '2根', '3根', '4根', '6根', 'c');
INSERT INTO `topics` VALUES ('515', '人民英雄纪念碑上的雕塑作品《五四运动》是:', '5', '地理', '浮雕', '圆雕', '', '', 'a');
INSERT INTO `topics` VALUES ('516', '2001年2月，我国几位科学家被授予国家最高科学技术奖？', '13', '科技', '1位', '2位', '3位', '4位', 'b');
INSERT INTO `topics` VALUES ('517', '雄狮每天的大部分时间用来', '14', '自然', '捕杀猎物', '在领地里巡视', '睡觉', '', 'c');
INSERT INTO `topics` VALUES ('518', '中国历史上被称为始皇帝的不是嬴政，对吗？', '4', '历史', '对', '不对', '', '', 'b');
INSERT INTO `topics` VALUES ('519', '世界上唯一没有土著居民生活的地区是', '5', '地理', '南极', '北极', '格陵兰岛', '', 'a');
INSERT INTO `topics` VALUES ('520', '我国宪法的监督权属于', '4', '历史', '国务院', '全国人大', '全国人大常委会', '全国人大法律委员会', 'c');
INSERT INTO `topics` VALUES ('521', '“河图”是指', '9', '文学', '五行图', '八卦图', '龟图', '龙马图', 'b');
INSERT INTO `topics` VALUES ('522', '负责出口产品退税管理的国家机关是', '8', '政治', '财政部', '国家税务局系统', '地方税务局系统', '海关', 'b');
INSERT INTO `topics` VALUES ('523', '当龋齿伤害到牙的什么部位时，我们就会感到疼痛？', '14', '自然', '牙釉质', '牙本质牙本质', '牙髓', '', 'c');
INSERT INTO `topics` VALUES ('524', '商业银行的工作人员不得', '8', '政治', '在本银行存款', '向本银行申请贷款', '购买本银行发行的债券', '在其他经济组织兼职', 'd');
INSERT INTO `topics` VALUES ('525', '《史记》是', '9', '文学', '纪传体通史', '编年体通史', '', '', 'a');
INSERT INTO `topics` VALUES ('526', '报道中有时会看到关于“UFO”的报道，UFO是指不明飞行物，对吗？', '7', '常识', '对', '不对', '', '', 'a');
INSERT INTO `topics` VALUES ('527', '我国第一大河长江有多长:', '5', '地理', '5480公里', '5900公里', '6300公里', '7240公里', 'c');
INSERT INTO `topics` VALUES ('528', '以下哪个不属于使馆馆长的级别？', '8', '政治', '大使', '公使', '代办', '临时代办', 'd');
INSERT INTO `topics` VALUES ('529', '世界上流经国家最多的河是哪一条？', '5', '地理', '莱茵河', '多瑙河', '雅鲁藏布江', '尼罗河', 'b');
INSERT INTO `topics` VALUES ('530', '&quot;约翰牛&quot;是哪个国家的绰号？', '5', '地理', '英国', '美国', '俄国', '法国', 'a');
INSERT INTO `topics` VALUES ('531', '舞蛇者表演时,蛇随舞蛇者舞动是因为', '7', '常识', '音乐的影响', '舞蛇者动作的影响', '', '', 'b');
INSERT INTO `topics` VALUES ('532', '从人物所处的时代角度，选出不同的一项是', '9', '文学', '王安石', '范仲淹', '欧阳修', '韩愈', 'd');
INSERT INTO `topics` VALUES ('533', '专指女性仆人的词是', '9', '文学', '奴', '婢', '妣', '孥', 'b');
INSERT INTO `topics` VALUES ('534', '有权没收假币的是', '8', '政治', '商家', '酒店', '银行', '', 'c');
INSERT INTO `topics` VALUES ('535', '《三国演义》中的“凤雏”是谁？', '9', '文学', '徐戍', '庞统', '', '', 'b');
INSERT INTO `topics` VALUES ('536', '&quot;锅庄”是下面哪一个少数民族的舞蹈？', '10', '旅游', '彝族', '羌族', '壮族', '', 'b');
INSERT INTO `topics` VALUES ('537', '民间故事《梁祝》突出反映了我国现行《婚姻法》的哪项基本制度？', '8', '政治', '男女平等', '婚姻自由', '一夫一妻', '', 'b');
INSERT INTO `topics` VALUES ('538', '新珍珠和老珍珠哪种价值高？', '11', '物理', '新珍珠', '老珍珠', '', '', 'a');
INSERT INTO `topics` VALUES ('539', '中国民间称七月初七为乞巧节。乞巧节里人们向谁乞求智巧？', '10', '旅游', '织女', '王母', '观音', '', 'a');
INSERT INTO `topics` VALUES ('540', '山西洪洞县的明代监狱，因谁的故事而著名？', '5', '地理', '白蛇', '苏三', '秦湘莲', '李香君', 'b');
INSERT INTO `topics` VALUES ('541', '在我国设立保险公司，其注册资本的最低限额为人民币', '7', '常识', '2千万元', '5千万元', '1亿元', '2亿元', 'd');
INSERT INTO `topics` VALUES ('542', '圆舞曲《春之声》的作者是', '15', '音乐', '约翰·斯特劳斯', '里查·斯特劳斯', '', '', 'a');
INSERT INTO `topics` VALUES ('543', '一些轿车车身后有2.0、2.6、2.8等阿拉伯数字，这是指', '7', '常识', '发动机的排量', '轿车车内的豪华程度', '发动机强化程度', '', 'a');
INSERT INTO `topics` VALUES ('544', '比赛中甲队要戴白帽子，乙队要戴蓝帽子，守门员要戴红帽子。这项比赛是', '2', '体育', '冰球比赛', '橄榄球比赛', '水球比赛', '', 'c');
INSERT INTO `topics` VALUES ('545', '方便面的发明者最初的愿望是', '4', '历史', '战时储备', '节约时间', '在家吃面', '提高效益', 'c');
INSERT INTO `topics` VALUES ('546', '政治中所提到的“南南合作”是指发展中中国家之间的经济合作，对吗？', '8', '政治', '对', '不对', '', '', 'a');
INSERT INTO `topics` VALUES ('547', '科学家把猪、牛、羊、马一起关在施放了有毒氯气的环境中作试验，它们中谁逃脱了厄运？', '13', '科技', '猪', '羊', '牛', '马', 'a');
INSERT INTO `topics` VALUES ('548', '小王用结婚后的工资购置的家具属于', '8', '政治', '小王与其妻按份共有', '小王与其妻共同共有', '小王所有', '', 'b');
INSERT INTO `topics` VALUES ('549', '西洋管弦乐队中唯一的拨弦乐器是', '15', '音乐', '钢琴', '竖琴', '吉它', '古筝', 'b');
INSERT INTO `topics` VALUES ('550', '火车司机夜间看到黄色指示灯左右摇摆意味着什么？', '7', '常识', '减速', '前方有停车', '不要发车', '道岔开通', 'd');
INSERT INTO `topics` VALUES ('551', '药膳中的用药都是补药，是所谓“太平药”。常吃药膳对身体有益吗？', '7', '常识', '无益', '有益', '', '', 'a');
INSERT INTO `topics` VALUES ('552', '著名的哈雷彗星命名源于', '6', '天文', '地名', '人名', '', '', 'b');
INSERT INTO `topics` VALUES ('553', '青蛙属于', '14', '自然', '变温动物', '恒温动物', '', '', 'a');
INSERT INTO `topics` VALUES ('554', '铝制器皿初次使用不宜熬下列哪一种东西', '11', '物理', '水', '粥', '肉汤', '', 'a');
INSERT INTO `topics` VALUES ('555', '下列疾病中，属于遗传病的是', '3', '化学', '白化病', '胃炎', '痢疾', '肝炎', 'a');
INSERT INTO `topics` VALUES ('556', '我国民间的“茶叶煮鸡蛋”对人体健康', '7', '常识', '有益', '无益', '', '', 'b');
INSERT INTO `topics` VALUES ('557', '世界上第一枚邮票是于哪年发行的？', '4', '历史', '1820年', '1840年', '1860年', '1900年', 'b');
INSERT INTO `topics` VALUES ('558', '牛、马的年轮长在', '14', '自然', '蹄上', '耳朵上', '鼻子上', '牙齿上', 'd');
INSERT INTO `topics` VALUES ('559', '目前地球上已知的最大陨石坑位于', '5', '地理', '亚洲', '非洲', '北美洲', '南极洲', 'c');
INSERT INTO `topics` VALUES ('560', '某公司下属的一分公司在业务范围内以自己名义对外签订的合同，其效力为', '8', '政治', '无效', '有效，其责任由分公司独立承担', '有效，其责任由总公司承担', '有效，其责任由分公司独立承担，总公司负连带责任', 'c');
INSERT INTO `topics` VALUES ('561', '香蕉果肉里的一排排褐色小点子就是香蕉的种子，用它能繁殖香蕉吗？', '14', '自然', '不能', '能', '', '', 'a');
INSERT INTO `topics` VALUES ('562', '西汉时期，经御史大夫杜周、杜延年解释的汉律，被称为“大杜律和小杜律”，他们两人的关系是', '4', '历史', '父子', '师生', '叔侄', '同朝官员', 'a');
INSERT INTO `topics` VALUES ('563', '《楚辞》中有“兰膏照烛”一句。这里点灯用的“膏”是一种', '9', '文学', '动物油', '植物油', '煤油', '树脂', 'a');
INSERT INTO `topics` VALUES ('564', '我国新研制的“先行者”的类人型机器人的特征不包括', '13', '科技', '具备了一定的语言功能', '快速行走', '具有与人相似的眼睛', '身高1.7米', 'd');
INSERT INTO `topics` VALUES ('565', '俗称“长生果”是指', '9', '文学', '花生', '腰果', '核桃', '', 'a');
INSERT INTO `topics` VALUES ('566', '&quot;AH---64&quot;是美国哪种军用飞机系列代号之一？', '13', '科技', '直升机', '歼击机', '运输机', '预警机', 'a');
INSERT INTO `topics` VALUES ('567', '“期期艾艾”这个典故讲的是西汉的周昌和西晋的邓艾两个人说话时的什么毛病？', '9', '文学', '罗嗦', '好骂人', '口吃', '好说谎', 'c');
INSERT INTO `topics` VALUES ('568', '获得第11届“中国十大杰出青年”的袁家军是', '13', '科技', '免疫与基因专家', '“神舟号”飞船系统总指挥', '南开大学教授', '', 'b');
INSERT INTO `topics` VALUES ('569', '走私、贩卖、运输、制造多少克毒品是犯罪行为？', '7', '常识', '无论数量多少', '海洛因50克以上', '', '', 'a');
INSERT INTO `topics` VALUES ('570', '近几年我国邮票上的邮政志铭是', '7', '常识', '中国人民邮政', '中国邮政', '', '', 'b');
INSERT INTO `topics` VALUES ('571', '在联合国维持和平与安全方面有权采取行动的机关是', '8', '政治', '联合国大会', '联合国安理会', '秘书处', '国际法院', 'b');
INSERT INTO `topics` VALUES ('572', '小康目前有两个标准一个是以食物消费为参照，食物消费支出降到家庭收入的50%；另一个标准', '8', '政治', '800元人民币', '800美元', '1600元人民币', '', 'b');
INSERT INTO `topics` VALUES ('573', '既是法国最大的王宫建筑，又是世界上最著名的艺术殿堂的是', '5', '地理', '卢浮宫', '凡尔塞宫', '', '', 'a');
INSERT INTO `topics` VALUES ('574', '离地面越高空气越稀薄是因为', '5', '地理', '空气受到地球引力影响', '不同气体密度不同', '高度不同温度不同', '', 'a');
INSERT INTO `topics` VALUES ('575', '软科学是指', '8', '政治', '关于软件的科学', '关于科学管理和科学决策的科学', '', '', 'b');
INSERT INTO `topics` VALUES ('576', '夏天喝什么茶最去暑？', '7', '常识', '冰茶', '热茶', '', '', 'b');
INSERT INTO `topics` VALUES ('577', '补充哪种维生素有利于儿童骨骼生长?', '3', '化学', '维生素E', '维生素D', '维生素A', '', 'b');
INSERT INTO `topics` VALUES ('578', '在古希腊神话中，爱与美的女神叫做', '9', '文学', '缪斯', '赫拉', '雅典娜', '阿芙洛狄特', 'd');
INSERT INTO `topics` VALUES ('579', '在荷马史诗当中，特洛伊战争持续了', '4', '历史', '8年', '15年', '10年', '11年', 'd');
INSERT INTO `topics` VALUES ('580', '下列哪种法律通常规定社会制度和国家制度？', '8', '政治', '刑法', '宪法', '经济法', '民法', 'b');
INSERT INTO `topics` VALUES ('581', '哪一区域是我国最大的商品性大豆和出口大豆生产基地？', '5', '地理', '东北', '华北', '', '', 'a');
INSERT INTO `topics` VALUES ('582', '在我国古代曾有一次人口普查，它是在哪个朝代进行的？', '4', '历史', '宋朝', '元朝', '明朝', '清朝', 'c');
INSERT INTO `topics` VALUES ('583', '西红柿的繁殖方法是', '14', '自然', '播种', '嫁接', '剪枝', '', 'a');
INSERT INTO `topics` VALUES ('584', '小熊猫属于哪个科？', '14', '自然', '熊科', '猫科', '浣熊科', '', 'c');
INSERT INTO `topics` VALUES ('585', '保证人与债权人未约定保证期间的，保证期间为主债务履行期届满之日起', '8', '政治', '6个月', '12个月', '18个月', '24个月', 'a');
INSERT INTO `topics` VALUES ('586', '个人与单位之间发生的所有权和林地使用权问题争议由谁处理？', '8', '政治', '县级或乡级人民政府', '派出所', '县级以上法院', '由当事人协商解决', 'a');
INSERT INTO `topics` VALUES ('587', '蚊子当中的雄蚊子靠吸食什么生活？', '14', '自然', '动物的血', '母蚊身上的分泌物', '花果液汁', '', 'c');
INSERT INTO `topics` VALUES ('588', '荷兰的中央政府所在地是', '5', '地理', '海牙', '阿姆斯特丹', '哥本哈根', '布鲁塞尔', 'a');
INSERT INTO `topics` VALUES ('589', '称为近代科学之父的是?', '13', '科技', '伽利略', '哥白尼', '亚里士多德', '牛顿', 'a');
INSERT INTO `topics` VALUES ('590', '一般来说玻璃杯是薄的容易炸裂，还是厚的？', '11', '物理', '薄的', '厚的', '', '', 'b');
INSERT INTO `topics` VALUES ('591', '下列选项不属于国家领土的是', '5', '地理', '领陆', '领水', '外层空间', '底土', 'c');
INSERT INTO `topics` VALUES ('592', '我国的集装箱长、宽、高哪个是一定的？', '7', '常识', '长', '宽', '高', '', 'b');
INSERT INTO `topics` VALUES ('593', '中国签定的第一个不平等条约是哪个？', '4', '历史', '望厦条约', '南京条约', '辛丑条约', '', 'b');

-- ----------------------------
-- Table structure for topics_cates
-- ----------------------------
DROP TABLE IF EXISTS `topics_cates`;
CREATE TABLE `topics_cates` (
  `tc_id` smallint(6) NOT NULL,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`tc_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='题目分类表';

-- ----------------------------
-- Records of topics_cates
-- ----------------------------
INSERT INTO `topics_cates` VALUES ('1', '其他', '1');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `u_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `wx_avatar` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '微信头像',
  `local_avatar` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '本地头像',
  `openid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `unionid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '微信用户的性别，值为1时是男性，值为2时是女性，值为0时是未知',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '微信用户个人资料填写的省份',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '微信普通用户个人资料填写的城市',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '国家，如中国为CN',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '-1' COMMENT '手机号码',
  `gold` mediumint(5) unsigned NOT NULL DEFAULT '0' COMMENT '用户金币',
  `exp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前经验',
  `lv_exp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '升级所需要经验',
  `lv` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '等级',
  `victory_rate` decimal(4,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '胜率',
  `victory_num` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '胜利场次',
  `defeat_num` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '失败场次',
  `flat_num` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '平手场次',
  `abstained_num` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '逃跑场次',
  `game_num` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '总场次',
  `a_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '项目ID',
  `register_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  `unique_token` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `unique_token` (`unique_token`) USING BTREE,
  KEY `openid` (`openid`),
  KEY `phone` (`phone`),
  KEY `item_id` (`a_id`),
  KEY `winner_rate` (`victory_rate`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', '肥宅日常', 'http://192.168.83.133/tnwz/web/images/avatar.png', '1.jpg', 'feizhairichang', 'feizhairichang', '0', '广东省', '广州市', '中国', '', '-1', '96046', '41', '50', '26', '0.58', '21', '2', '13', '0', '36', '1', '0', '0', '1', '0', 'unique_token');
INSERT INTO `users` VALUES ('2', '总有刁民想害朕', 'http://192.168.83.133/tnwz/web/images/avatar_2.jpg', '1.jpg', 'feizhairichang', 'feizhairichang', '0', '广东省', '广州市', '中国', '', '-1', '597', '6', '50', '17', '0.06', '2', '21', '13', '0', '36', '1', '0', '0', '1', '0', 'unique_token2');

-- ----------------------------
-- Table structure for _topics
-- ----------------------------
DROP TABLE IF EXISTS `_topics`;
CREATE TABLE `_topics` (
  `t_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` smallint(5) unsigned NOT NULL COMMENT '类型',
  `cate_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `question` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '问题',
  `img` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片题',
  `a` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'A答案',
  `b` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'B答案',
  `c` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'C答案',
  `d` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'D答案',
  `answer` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '答案选项',
  `status` tinyint(1) NOT NULL COMMENT '-1删除 0下架 1上架',
  `create_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`t_id`),
  KEY `cate_id` (`cate_id`),
  KEY `question` (`question`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of _topics
-- ----------------------------
INSERT INTO `_topics` VALUES ('1', '1', '其他', '大煮干丝”是哪个菜系的代表菜之一', '', '四川菜系', '山东菜系', '广东菜系', '淮扬菜系', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('2', '1', '其他', '红茶属于_____茶', '', '半发酵', '发酵', '不发酵', '微发酵', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('3', '1', '其他', '满汉全席起兴于', '', '清代', '唐代', '宋代', '两汉', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('4', '1', '其他', '吃冰淇淋不解渴主要是因为它', '', '含蛋白质', '含脂肪', '含糖', '', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('5', '1', '其他', '下列哪项是人体的造血器官', '', '心脏', '骨髓', '肾脏', '', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('6', '1', '其他', '老三届指的是那几年毕业的初、高中毕业生', '', '1964-1966', '1966-1968', '1969-1971', '', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('7', '1', '其他', '博士作为官名最早出现在', '', '秦 ', '汉', '唐', '', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('8', '1', '其他', '“谬种流传”最早是宋朝人批评当时的', '', '官场黑暗', '科举制度', '社会风气', '诗词风格', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('9', '1', '其他', '《在那遥远的地方》是哪里的民歌', '', '四川民歌', '江苏民歌', '蒙古民歌', '青海民歌', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('10', '1', '其他', '人体含水量百分比最高的器官是', '', '肝', '肾', '眼球', '心脏', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('11', '1', '其他', '人体最大的解毒器官是', '', '胃', '肾脏', '肝脏', '脾', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('12', '1', '其他', '下半旗是把旗子下降到', '', '旗杆的一半处', '下降1米', '下降1.5米', '距离杆顶的1/3处', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('13', '1', '其他', '下列地点与电影奖搭配不正确的是', '', '戛纳-金棕榈', '柏林-圣马克金狮', '洛杉矶-奥斯卡 ', '中国-金鸡 ', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('14', '1', '其他', '下列哪种邮件如果丢失了，邮局不负赔偿责任', '', '平信', '挂号信', '非保价邮包', '特快专递邮件', 'a', '1', '0');
INSERT INTO `_topics` VALUES ('15', '1', '其他', '面哪种酸，人在品尝时不是酸味的', '', '琥珀酸', '苹果酸 ', '柠檬酸', '单宁酸', 'a', '1', '0');
