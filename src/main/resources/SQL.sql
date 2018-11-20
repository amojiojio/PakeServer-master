/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : pake

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2018-11-20 14:37:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for api_log
-- ----------------------------
DROP TABLE IF EXISTS `api_log`;
CREATE TABLE `api_log` (
  `id` varchar(80) NOT NULL,
  `url` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `param` varchar(1000) DEFAULT NULL COMMENT '传入参数',
  `startTimeMillis` bigint(20) DEFAULT NULL COMMENT '开始时间',
  `endTimeMillis` bigint(20) DEFAULT NULL COMMENT '结束时间',
  `seTimeMillis` int(11) DEFAULT NULL COMMENT '耗时',
  `returnCode` varchar(20) DEFAULT NULL COMMENT '返回码',
  `message` varchar(255) DEFAULT NULL COMMENT '描述信息',
  `isSuccess` varchar(6) DEFAULT NULL COMMENT '成功标识',
  `fromSource` varchar(20) DEFAULT NULL COMMENT '来源',
  `ip` varchar(20) DEFAULT NULL COMMENT 'ip地址',
  `method` varchar(5) DEFAULT NULL COMMENT '请求方式',
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_log
-- ----------------------------
INSERT INTO `api_log` VALUES ('a9f0d709ec8e11e8b1d900163e042402', '/wxapi/jsTicket.html', '{\"url\":[\"http://www.wanxunkj.com/weChat/userInfo\"]}', '1542695812153', '1542695812154', '1', null, null, null, 'weChat', '118.114.71.10', 'POST', '2018-11-20 14:36:52');
INSERT INTO `api_log` VALUES ('abebc287ec8e11e8b1d900163e042402', '/wxapi/wxceb9b4cc8cce903b/message.html', '{\"signature\":[\"d6075614b77885522c82ed3d2aedd15141ab193d\"],\"timestamp\":[\"1542695815\"],\"nonce\":[\"1347264641\"],\"openid\":[\"od4xq1TAUwe4txAXC1FqXkNSfAKo\"]}', '1542695815475', '1542695815476', '1', null, null, null, 'PC', '223.166.222.109', 'POST', '2018-11-20 14:36:55');
INSERT INTO `api_log` VALUES ('abfd20c9ec8e11e8b1d900163e042402', '/wxapi/jsTicket.html', '{\"url\":[\"http://www.wanxunkj.com/weChat/userInfo\"]}', '1542695815590', '1542695815590', '0', null, null, null, 'weChat', '118.114.71.10', 'POST', '2018-11-20 14:36:55');

-- ----------------------------
-- Table structure for pake_admin
-- ----------------------------
DROP TABLE IF EXISTS `pake_admin`;
CREATE TABLE `pake_admin` (
  `id` varchar(100) NOT NULL,
  `userName` varchar(100) DEFAULT NULL,
  `passWord` varchar(100) DEFAULT NULL,
  `openId` varchar(100) DEFAULT NULL,
  `nikeName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pake_admin
-- ----------------------------
INSERT INTO `pake_admin` VALUES ('a0ebd76a507d57d3afe36fc073a0b669', 'admin', 'admin', 'admin', 'admin');

-- ----------------------------
-- Table structure for pake_run
-- ----------------------------
DROP TABLE IF EXISTS `pake_run`;
CREATE TABLE `pake_run` (
  `id` varchar(32) NOT NULL,
  `openId` varchar(100) DEFAULT NULL COMMENT '微信开放ID',
  `goodsType` varchar(5) DEFAULT NULL COMMENT '购买商品类型',
  `note` varchar(36) DEFAULT NULL COMMENT '备注信息',
  `startUserNote` varchar(80) DEFAULT NULL COMMENT '购买地址',
  `endUserNote` varchar(80) DEFAULT NULL COMMENT '收货地址',
  `endUserName` varchar(10) DEFAULT NULL COMMENT '收货人',
  `endPhone` varchar(11) DEFAULT NULL COMMENT '收货人联系电话',
  `goodsMoney` varchar(10) DEFAULT NULL COMMENT '商品价钱',
  `sendType` int(1) DEFAULT NULL COMMENT '是否就近购买 1：否 5：是',
  `isSubscribe` int(1) DEFAULT NULL COMMENT '是否立即购买 0 是 1 否',
  `subscribeTime` datetime DEFAULT NULL COMMENT '购买时间',
  `state` int(1) DEFAULT NULL COMMENT '1待接单 2已接单 3已完成',
  `transactionId` varchar(100) DEFAULT NULL COMMENT '微信订单号',
  `payState` int(1) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pake_run
-- ----------------------------

-- ----------------------------
-- Table structure for pake_takebyqu
-- ----------------------------
DROP TABLE IF EXISTS `pake_takebyqu`;
CREATE TABLE `pake_takebyqu` (
  `id` varchar(32) NOT NULL,
  `openId` varchar(100) DEFAULT NULL COMMENT '微信开放ID',
  `sms` varchar(200) DEFAULT NULL COMMENT '短信',
  `note` varchar(36) DEFAULT NULL COMMENT '备注信息',
  `endUserNote` varchar(80) DEFAULT NULL COMMENT '收件地址',
  `endUserName` varchar(10) DEFAULT NULL COMMENT '收件人',
  `endPhone` varchar(11) DEFAULT NULL COMMENT '收件人联系电话',
  `isSubscribe` int(1) DEFAULT NULL COMMENT '是否预约收件 0 是 1 否',
  `subscribeTime` datetime DEFAULT NULL COMMENT '预约时间',
  `state` int(1) DEFAULT NULL COMMENT '1待接单 2已接单 3已完成',
  `createDate` datetime DEFAULT NULL,
  `payState` int(1) DEFAULT '0',
  `transactionId` varchar(255) DEFAULT NULL,
  `messageTime` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pake_takebyqu
-- ----------------------------
INSERT INTO `pake_takebyqu` VALUES ('1000000000437232', 'od4xq1cYKPAhcX15Rwl68wYJoGEs', '【熊猫快收】亲圆通速递A22-1-5003已到传媒综合配送服务中心请于当日7点前领取，电话18109015000取件带证件', null, '女生公寓六栋622', '白玉晗', '17340042365', '0', null, '3', '2018-10-20 09:21:44', '1', '4200000177201810209070334538', '昨天');
INSERT INTO `pake_takebyqu` VALUES ('1000000001293489', 'od4xq1V_8YnXwOg3hOPE9lI4_ovY', '【熊猫快收】亲圆通速递A22-7-3012已到传媒综合配送服务中心请于当日7点前领取，电话18109015000取件带证件', null, '24栋267', '罗予晨', '17738701801', '0', null, '3', '2018-10-21 12:09:53', '1', '4200000187201810217516845477', '三天前');
INSERT INTO `pake_takebyqu` VALUES ('1000000001655325', 'od4xq1Rx0whMLO4J8bcQ0o27h9Ok', '【百世邻里】凭货号517013请19点前到传媒东门右拐300米百世快递点领取百世快递单号*0934', null, '女生院6栋631', '王佩娴', '18335807980', '0', null, '3', '2018-11-05 12:53:12', '1', '4200000211201811057072891438', '今天');
INSERT INTO `pake_takebyqu` VALUES ('1000000002407240', 'od4xq1XFy8SbTX2u0diBH3c-FZLQ', '【菜鸟驿站】您的申通包裹到四川传媒学院菜鸟驿站，请19:00前凭12-7-6001尽快取，询18109015000，感谢理解', null, '女生苑4208 011', '赵文淇', '15941990898', '0', null, '3', '2018-11-17 14:54:29', '1', '4200000229201811173057854076', '今天');
INSERT INTO `pake_takebyqu` VALUES ('1000000003024075', 'od4xq1VMZFeCVfwqugf69sG0g2ns', '【菜鸟驿站】您的圆通包裹到四川传媒学院菜鸟驿站，请19:00前凭20-2-4254尽快取，询18109015000，感谢理解', null, '11栋116', '陈瑞琦', '17665360403', '0', null, '3', '2018-11-15 18:44:43', '1', '4200000209201811150397056642', '今天');
INSERT INTO `pake_takebyqu` VALUES ('1000000003118488', 'od4xq1eiogdahEtksbL2Lp-0ilcI', '【熊猫快收】亲申通快递A12-4-7111已到传媒综合配送服务中心请于当日7点前领取，电话18109015000取件带证件', null, '18栋303号宿舍', '黄思睿', '18720262030', '0', null, '3', '2018-10-21 13:12:09', '1', '4200000173201810216117680084', '今天');
INSERT INTO `pake_takebyqu` VALUES ('1000000003361084', 'od4xq1TE-2Jrho8M8FSkChrC8nJQ', '【熊猫快收】亲圆通速递A27-4-3044已到传媒综合配送服务中心请于当日7点前领取，电话18109015000取件带证件', null, '四川传媒学院学生公寓21栋618', '汤晓雨', '15221584012', '0', null, '3', '2018-10-12 12:04:21', '1', '4200000183201810126891385756', '今天');
INSERT INTO `pake_takebyqu` VALUES ('1000000003880148', 'od4xq1WQEUOgEVFyz2oGQgKPSgCM', '【熊猫快收】亲申通快递A13-6-7003已到传媒综合配送服务中心请于当日7点前领取，电话18109015000取件带证件', null, '17栋342', '韩一凡', '17360073623', '0', null, '3', '2018-10-21 17:07:55', '1', '4200000187201810218672294626', '今天');


-- ----------------------------
-- Table structure for pake_takebysong
-- ----------------------------
DROP TABLE IF EXISTS `pake_takebysong`;
CREATE TABLE `pake_takebysong` (
  `id` varchar(32) NOT NULL,
  `openId` varchar(100) DEFAULT NULL COMMENT '微信开放ID',
  `goodsType` varchar(5) DEFAULT NULL COMMENT '购买商品类型',
  `note` varchar(36) DEFAULT NULL COMMENT '备注信息',
  `endUserNote` varchar(80) DEFAULT NULL COMMENT '取件地址',
  `endUserName` varchar(10) DEFAULT NULL COMMENT '取件人',
  `endPhone` varchar(11) DEFAULT NULL COMMENT '取件人联系电话',
  `isSubscribe` int(1) DEFAULT NULL COMMENT '是否预约收件 0 是 1 否',
  `subscribeTime` datetime DEFAULT NULL COMMENT '预约时间',
  `state` int(1) DEFAULT NULL COMMENT '1待接单 2已接单 3已完成',
  `courierNumber` varchar(50) DEFAULT NULL COMMENT '快递单号',
  `courierCompany` varchar(50) DEFAULT NULL COMMENT '快递公司',
  `createDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pake_takebysong
-- ----------------------------
INSERT INTO `pake_takebysong` VALUES ('1000000001868913', 'od4xq1RXXpOn3expWaoXdzA0BvZY', '服饰', '', '17栋534', '周旖静', '17396243603', '0', null, '3', '1', '天天快递', '2018-10-07 17:18:12');
INSERT INTO `pake_takebysong` VALUES ('1000000002827763', 'od4xq1eHN2TbseTinXzmUCMzJyyw', '服饰', '', '23栋148寝室', '耿一航', '17396240805', '1', '2018-11-18 12:02:00', '3', '3385958966114', '申通速递', '2018-11-18 11:33:00');
INSERT INTO `pake_takebysong` VALUES ('1000000010833016', 'od4xq1Rc613t27JGELD-Kffv_ZRk', '服饰', '带袋子', '一栋416', '陈丽瑶 陈瑶瑶', '17381590484', '1', '2018-10-27 15:04:00', '3', '802294372323103200', '圆通速递', '2018-10-26 21:46:02');

-- ----------------------------
-- Table structure for pake_user_address
-- ----------------------------
DROP TABLE IF EXISTS `pake_user_address`;
CREATE TABLE `pake_user_address` (
  `id` varchar(255) NOT NULL,
  `openId` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pake_user_address
-- ----------------------------

-- ----------------------------
-- Table structure for t_wxcms_account
-- ----------------------------
DROP TABLE IF EXISTS `t_wxcms_account`;
CREATE TABLE `t_wxcms_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `account` varchar(100) NOT NULL,
  `appid` varchar(100) DEFAULT NULL,
  `appsecret` varchar(100) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `msgCount` int(11) DEFAULT '1',
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wxcms_account
-- ----------------------------
INSERT INTO `t_wxcms_account` VALUES ('3', null, 'wxceb9b4cc8cce903b', 'wxceb9b4cc8cce903b', 'bab2b0eae8819cb38edd7f046e6ef6f2', 'http://www.wanxunkj.com/wxapi/wxceb9b4cc8cce903b/message.html', '72597b9628704ab09e8b9e8cbe9b540a', '1', '2015-01-27 21:38:31');

-- ----------------------------
-- Table structure for t_wxcms_account_fans
-- ----------------------------
DROP TABLE IF EXISTS `t_wxcms_account_fans`;
CREATE TABLE `t_wxcms_account_fans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) DEFAULT NULL,
  `subscribeStatus` int(1) DEFAULT '1',
  `subscribeTime` varchar(50) DEFAULT NULL,
  `nickname` varbinary(50) DEFAULT NULL,
  `gender` tinyint(4) DEFAULT '1',
  `language` varchar(50) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  `province` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `headimgurl` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `remark` varchar(50) DEFAULT NULL,
  `wxid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7444 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wxcms_account_fans
-- ----------------------------
INSERT INTO `t_wxcms_account_fans` VALUES ('435', 'ooCsFwmSW25FR1A_gfEAifwVmbzE', null, null, 0x736576656E20656C6576656E, '1', 'zh_CN', '中国', '四川', '成都', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoibAfzl40ByBO4IqZGZSsGpR5cjNa6xo6VjQhRAPQALa4LiaM1YDIbQsU40qbrPHAogFtXrjoGH9qA/132', '2018-05-15 13:39:38', '1', null, null);
INSERT INTO `t_wxcms_account_fans` VALUES ('436', 'od4xq1RzhU1uXpqS4eqMZQA6vD-g', null, null, 0x736576656E20656C6576656E, '1', 'zh_CN', '中国', '四川', '成都', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqNS69NKbVofwURRbml6icsCwQeFOGHwVS1Iu52CfdCCYliaMTGvl3xWdfQQoPA6jABibrIe87NKOCibg/132', '2018-08-31 10:50:48', '1', null, null);

-- ----------------------------
-- Table structure for t_wxcms_account_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_wxcms_account_menu`;
CREATE TABLE `t_wxcms_account_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mtype` varchar(50) DEFAULT NULL,
  `eventType` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `inputCode` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `msgId` varchar(100) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wxcms_account_menu
-- ----------------------------
INSERT INTO `t_wxcms_account_menu` VALUES ('34', 'click', 'suta', '苏。', '', '', '1', '0', '', '2017-12-23 20:58:59', '143');
INSERT INTO `t_wxcms_account_menu` VALUES ('35', 'view', 'fix', '取送件', '', 'http://pake.free.ngrok.cc/weChat/take', '1', '0', '', '2018-04-14 18:05:11', '144');
INSERT INTO `t_wxcms_account_menu` VALUES ('36', 'view', 'fix', '代跑腿', '', 'http://pake.free.ngrok.cc/weChat/run', '1', '0', '', '2018-04-14 18:03:12', '144');
INSERT INTO `t_wxcms_account_menu` VALUES ('37', 'view', 'fix', '我的派客', '', 'http://pake.free.ngrok.cc/weChat/userInfo', '1', '0', '', '2018-04-14 18:03:25', '144');

-- ----------------------------
-- Table structure for t_wxcms_account_menu_group
-- ----------------------------
DROP TABLE IF EXISTS `t_wxcms_account_menu_group`;
CREATE TABLE `t_wxcms_account_menu_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wxcms_account_menu_group
-- ----------------------------
INSERT INTO `t_wxcms_account_menu_group` VALUES ('143', 'V1.0', '0', '2017-12-23 20:58:46');
INSERT INTO `t_wxcms_account_menu_group` VALUES ('144', 'V2.0', '1', '2017-12-23 21:03:11');

-- ----------------------------
-- Table structure for t_wxcms_msg_base
-- ----------------------------
DROP TABLE IF EXISTS `t_wxcms_msg_base`;
CREATE TABLE `t_wxcms_msg_base` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msgType` varchar(20) DEFAULT NULL,
  `inputCode` varchar(20) DEFAULT NULL,
  `rule` varchar(20) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `readCount` int(11) DEFAULT '0',
  `favourCount` int(11) unsigned zerofill DEFAULT '00000000000',
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wxcms_msg_base
-- ----------------------------
INSERT INTO `t_wxcms_msg_base` VALUES ('160', 'text', 'subscribe', null, null, null, null, '2017-11-23 19:45:08');
INSERT INTO `t_wxcms_msg_base` VALUES ('165', 'text', '', null, null, null, null, '2017-11-23 23:52:29');
INSERT INTO `t_wxcms_msg_base` VALUES ('166', 'text', '1', null, null, null, null, '2017-11-30 15:14:54');
INSERT INTO `t_wxcms_msg_base` VALUES ('167', 'text', '2', null, null, null, null, '2017-11-30 15:14:58');
INSERT INTO `t_wxcms_msg_base` VALUES ('168', 'text', '3', null, null, null, null, '2017-11-30 15:15:03');
INSERT INTO `t_wxcms_msg_base` VALUES ('169', 'text', '4', null, null, null, null, '2017-11-30 15:15:07');
INSERT INTO `t_wxcms_msg_base` VALUES ('170', 'text', '5', null, null, null, null, '2017-11-30 15:15:10');
INSERT INTO `t_wxcms_msg_base` VALUES ('171', 'text', '6', null, null, null, null, '2017-11-30 15:15:15');
INSERT INTO `t_wxcms_msg_base` VALUES ('172', 'text', '7', null, null, null, null, '2017-11-30 15:15:20');
INSERT INTO `t_wxcms_msg_base` VALUES ('173', 'text', '8', null, null, null, null, '2017-11-30 15:15:25');
INSERT INTO `t_wxcms_msg_base` VALUES ('174', 'text', '9', null, null, null, null, '2017-11-30 15:15:30');
INSERT INTO `t_wxcms_msg_base` VALUES ('175', 'text', '10', null, null, null, null, '2017-11-30 15:15:35');
INSERT INTO `t_wxcms_msg_base` VALUES ('176', 'text', 'subscribe', null, null, null, null, '2018-03-30 23:09:32');

-- ----------------------------
-- Table structure for t_wxcms_msg_news
-- ----------------------------
DROP TABLE IF EXISTS `t_wxcms_msg_news`;
CREATE TABLE `t_wxcms_msg_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `brief` varchar(255) DEFAULT NULL,
  `description` longtext,
  `picPath` varchar(255) DEFAULT NULL,
  `showPic` int(11) DEFAULT '0',
  `url` varchar(255) DEFAULT NULL,
  `fromurl` varchar(255) DEFAULT NULL,
  `base_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wxcms_msg_news
-- ----------------------------

-- ----------------------------
-- Table structure for t_wxcms_msg_text
-- ----------------------------
DROP TABLE IF EXISTS `t_wxcms_msg_text`;
CREATE TABLE `t_wxcms_msg_text` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `base_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wxcms_msg_text
-- ----------------------------
INSERT INTO `t_wxcms_msg_text` VALUES ('1', '谢谢你\r\n长的这么好看还来关注我', '176');
