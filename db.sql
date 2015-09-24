/*
Navicat MySQL Data Transfer

Source Server         : 航道局
Source Server Version : 50543
Source Host           : 115.28.136.150:3306
Source Database       : task

Target Server Type    : MYSQL
Target Server Version : 50543
File Encoding         : 65001

Date: 2015-09-15 22:21:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `evaluate` int(255) DEFAULT NULL COMMENT '该部门是否参与评价',
  `evauser` int(255) DEFAULT NULL COMMENT '考核人',
  `evausername` varchar(255) DEFAULT NULL COMMENT '考核人姓名',
  PRIMARY KEY (`id`),
  KEY `fk_dept_eva_user` (`evauser`) USING BTREE,
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`evauser`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '安调部（安全）', '0', null, null);
INSERT INTO `department` VALUES ('2', '工程技术部', '0', '8', null);
INSERT INTO `department` VALUES ('3', '合同预算部', '0', '8', null);
INSERT INTO `department` VALUES ('4', '财务部', '0', '8', null);
INSERT INTO `department` VALUES ('5', '综合办公室', '0', '8', null);
INSERT INTO `department` VALUES ('6', '安调部（调度）', '0', '8', null);
INSERT INTO `department` VALUES ('7', '领导班子', '0', null, null);
INSERT INTO `department` VALUES ('8', '船机部', '0', null, null);

-- ----------------------------
-- Table structure for eva_type
-- ----------------------------
DROP TABLE IF EXISTS `eva_type`;
CREATE TABLE `eva_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `coefficient` float(255,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eva_type
-- ----------------------------
INSERT INTO `eva_type` VALUES ('1', '分管领导考核', '0.60');
INSERT INTO `eva_type` VALUES ('2', '其他领导考核', '0.20');
INSERT INTO `eva_type` VALUES ('3', '各部门考核', '0.20');

-- ----------------------------
-- Table structure for evaluation
-- ----------------------------
DROP TABLE IF EXISTS `evaluation`;
CREATE TABLE `evaluation` (
  `id` int(11) NOT NULL,
  `user` int(255) DEFAULT NULL COMMENT '被评价人',
  `evauser` int(255) DEFAULT NULL COMMENT '评价人',
  `score` int(255) DEFAULT NULL COMMENT '分数',
  `type` int(255) DEFAULT NULL COMMENT '0: 本部门领导; 1: 外部门领导; 2:外部门考核人',
  `complete` int(255) DEFAULT NULL COMMENT '是否完成',
  `evadate` date DEFAULT NULL COMMENT '评价日期',
  PRIMARY KEY (`id`),
  KEY `fk_evaluation_user` (`user`) USING BTREE,
  KEY `fk_evaluation_evauser` (`evauser`) USING BTREE,
  KEY `fk_evaluation_type` (`type`) USING BTREE,
  CONSTRAINT `evaluation_ibfk_1` FOREIGN KEY (`evauser`) REFERENCES `user` (`id`),
  CONSTRAINT `evaluation_ibfk_2` FOREIGN KEY (`type`) REFERENCES `eva_type` (`id`),
  CONSTRAINT `evaluation_ibfk_3` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluation
-- ----------------------------

-- ----------------------------
-- Table structure for evaluation_detail
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_detail`;
CREATE TABLE `evaluation_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(255) DEFAULT NULL,
  `leader` float(255,2) DEFAULT NULL,
  `otherLeader` float(255,2) DEFAULT NULL,
  `otherDept` float(255,2) DEFAULT NULL,
  `total` float(255,2) DEFAULT NULL,
  `report` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_eva_detail_report` (`report`) USING BTREE,
  KEY `fk_eva_detail_user` (`user`) USING BTREE,
  CONSTRAINT `evaluation_detail_ibfk_1` FOREIGN KEY (`report`) REFERENCES `evaluation_report` (`id`),
  CONSTRAINT `evaluation_detail_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluation_detail
-- ----------------------------

-- ----------------------------
-- Table structure for evaluation_report
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_report`;
CREATE TABLE `evaluation_report` (
  `id` int(11) NOT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `type` int(255) DEFAULT NULL COMMENT '0: 月考核结果；1：周考核结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluation_report
-- ----------------------------

-- ----------------------------
-- Table structure for leader
-- ----------------------------
DROP TABLE IF EXISTS `leader`;
CREATE TABLE `leader` (
  `id` int(11) NOT NULL,
  `leader` int(11) NOT NULL COMMENT '领导',
  `dept` int(11) NOT NULL COMMENT '部门',
  `title` varchar(255) DEFAULT NULL COMMENT '职务',
  PRIMARY KEY (`id`),
  KEY `fk_leader_user_1` (`leader`) USING BTREE,
  KEY `fk_leader_department_1` (`dept`) USING BTREE,
  CONSTRAINT `leader_ibfk_1` FOREIGN KEY (`dept`) REFERENCES `department` (`id`),
  CONSTRAINT `leader_ibfk_2` FOREIGN KEY (`leader`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of leader
-- ----------------------------
INSERT INTO `leader` VALUES ('1', '30', '7', '项目经理');
INSERT INTO `leader` VALUES ('3', '32', '1', '项目书记');
INSERT INTO `leader` VALUES ('4', '32', '5', '项目书记');
INSERT INTO `leader` VALUES ('5', '33', '2', '副经理');
INSERT INTO `leader` VALUES ('6', '33', '6', '副经理');
INSERT INTO `leader` VALUES ('7', '34', '2', '总工程师');
INSERT INTO `leader` VALUES ('8', '35', '3', '副经理');
INSERT INTO `leader` VALUES ('9', '36', '4', '财务总监');
INSERT INTO `leader` VALUES ('18', '15', '2', '工程主管');
INSERT INTO `leader` VALUES ('19', '15', '2', '');
INSERT INTO `leader` VALUES ('25', '42', '5', '');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `pubtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES ('1', '测试公告', '<p>这里是公告内容</p><p></p>', '2015-04-25 15:17:00');
INSERT INTO `news` VALUES ('2', 'test', '<p>tttt</p>', '2015-07-14 22:50:37');
INSERT INTO `news` VALUES ('3', 'test1', null, '2015-07-25 01:13:16');

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(255) NOT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `replyuser` int(255) DEFAULT NULL,
  `task` int(255) NOT NULL,
  `pubtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user` (`user`) USING BTREE,
  KEY `fk_reply` (`replyuser`) USING BTREE,
  KEY `fk_task` (`task`) USING BTREE,
  CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`replyuser`) REFERENCES `user` (`id`),
  CONSTRAINT `reply_ibfk_2` FOREIGN KEY (`task`) REFERENCES `task` (`id`),
  CONSTRAINT `reply_ibfk_3` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES ('1', '9', '任务进行中', null, '26', '2015-05-21 13:51:16');
INSERT INTO `reply` VALUES ('2', '33', '任务进行中', null, '26', '2015-05-21 14:22:47');
INSERT INTO `reply` VALUES ('3', '18', '啥也没有啊 ', null, '26', '2015-05-24 19:33:54');
INSERT INTO `reply` VALUES ('4', '18', '啥也没有啊 ', null, '27', '2015-05-24 19:34:17');
INSERT INTO `reply` VALUES ('5', '18', '啥也没有啊 ', null, '28', '2015-05-24 19:34:23');
INSERT INTO `reply` VALUES ('6', '18', '啥也没有啊 ', null, '29', '2015-05-24 19:34:28');
INSERT INTO `reply` VALUES ('7', '22', '路过', null, '26', '2015-05-24 19:36:11');
INSERT INTO `reply` VALUES ('8', '22', '....', null, '29', '2015-05-31 09:49:15');
INSERT INTO `reply` VALUES ('9', '35', '已完成，跟踪各部门的执行情况', null, '34', '2015-08-17 11:14:53');
INSERT INTO `reply` VALUES ('10', '35', '已完成，跟踪各部门的执行情况', null, '34', '2015-08-17 11:15:00');
INSERT INTO `reply` VALUES ('11', '8', '9月14日对水工施工现场、疏浚施工现场进行安全巡视。对合昌238船、天鸥船进行整改复查，以上两船整改复查合格。对津航艇33船进行安全检查，共发现两项需整改项，分别为：甲板油桶未绑扎牢固；消防皮龙箱禁止用绳索等物品绑扎，现绑扎的绳子需要拆除。水工施工现场进行拢口合拢的的吹砂作业，参与施工作业人员全部按规定穿戴好劳保防护用品。', null, '41', '2015-09-14 20:55:55');
INSERT INTO `reply` VALUES ('12', '8', '9月14日对水工施工现场、疏浚施工现场进行安全巡视。对合昌238船、天鸥船进行整改复查，以上两船整改复查合格。对津航艇33船进行安全检查，共发现两项需整改项，分别为：甲板油桶未绑扎牢固；消防皮龙箱禁止用绳索等物品绑扎，现绑扎的绳子需要拆除。水工施工现场进行拢口合拢的的吹砂作业，参与施工作业人员全部按规定穿戴好劳保防护用品。', null, '41', '2015-09-14 20:56:19');

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `leader` int(11) NOT NULL,
  `comment` text COMMENT '评语',
  `status` int(255) DEFAULT NULL COMMENT '0 待完成; 1 已完成; 2 已评价',
  `pubDate` date DEFAULT NULL,
  `type` int(255) DEFAULT NULL,
  `month` int(255) unsigned zerofill NOT NULL COMMENT '0 : 周任务； 1：月任务',
  PRIMARY KEY (`id`),
  KEY `fk_task_user_1` (`leader`) USING BTREE,
  KEY `task_task_type` (`type`) USING BTREE,
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`leader`) REFERENCES `user` (`id`),
  CONSTRAINT `task_ibfk_2` FOREIGN KEY (`type`) REFERENCES `task_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('26', '5月5日-5月10安全管理工作总体安排', '1.完成避让措施的编写（张桂海）\r\n2.做好现场船舶的安全检查，尤其是新进场船舶（全体人员）\r\n3.梳理内业资料，迎接检查（杨彬）\r\n4.开始着手编写演习计划（张桂海）\r\n5.做好现场管线吊装等重大安全风险工作的检查、旁站（全体人员）\r\n6.其他', '2015-05-05', '2015-05-10', '32', null, '0', '2015-05-05', '3', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('27', '1111111', 'qqweeeee', '2015-05-21', '2015-05-22', '32', null, '0', '2015-05-21', '1', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('28', 'xxxxxx', '1111', '2015-05-21', '2015-05-22', '32', null, '0', '2015-05-21', '1', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('29', '测试任务', '这里是任务描述', '2015-05-23', '2015-05-26', '32', null, '0', '2015-05-21', '1', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('30', '7月份安全管理工作安排', '', '2015-07-01', '2015-07-31', '32', null, '0', '2015-06-30', '3', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('31', '7月安全管理工作', '', '2015-06-30', '2015-07-30', '32', null, '0', '2015-06-30', '3', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('32', '测试任务', '任务描述', '2015-07-12', '2015-07-13', '7', null, '2', '2015-07-12', '1', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('33', '测试任务2', '测试任务2', '2015-07-12', '2015-07-14', '7', null, '2', '2015-07-12', '2', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('34', '8月份部门成本计划', '8月份部门成本计划', '2015-07-27', '2015-07-29', '35', null, '0', '2015-07-27', '4', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('35', '落实港池及航道0+0~2+0段清淤及施工方案', '1、确定施工方案；2、落实施工单位；3、落实公司自有绞吸船。\r\n', '2015-07-27', '2015-07-31', '30', null, '1', '2015-07-31', '1', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('36', '解决3万吨航道项目5月份工程进度款审计计量问题', '略。', '2015-07-28', '2015-07-31', '30', null, '0', '2015-07-31', '1', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('37', '负责推进与业主签订隔堰合同。', '找业主领导沟通，确定隔堰合同的签订方式，加快推进合同签订工作。', '2015-07-27', '2015-07-31', '30', null, '0', '2015-07-31', '1', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('38', '8月份党群主要工作安排', '1、按照公司下达的《8月份党群工作推进计划表》要求，提前完成各项工作。书记审阅后，上报公司。\r\n2、组织好业主篮球赛事宜，主力队员保证参赛，以及后勤支持。\r\n3、按照公司要求（技术部），按月上报信息化平台的相关报表、总结。', '2015-08-12', '2015-08-31', '32', null, '0', '2015-08-12', '3', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('39', '8月份主要安全管理工作安排', '1、做好艇38调遣相关工作，与公司及时联系，必要时请公司参加联检。\r\n2、组织召开月度安全生产例会。\r\n3、做好安全检查工作。\r\n4、重点关注实习生上下船、防护用品穿戴等情况，加强安全教育。', '2015-08-12', '2015-08-31', '32', null, '0', '2015-08-12', '3', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('40', 'test', 'aaa', '2015-08-01', '2015-08-29', '32', null, '0', '2015-08-14', '1', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001');
INSERT INTO `task` VALUES ('41', '9月份安全管理主要工作', '1、做好船舶退场的手续办理工作。\r\n2、梳理内业资料，做好体系外审迎检准备。\r\n3、做好船舶安全检查、气象预警等工作。\r\n4、加强水工现场安全旁站。\r\n5、安全标准化、制度化文件的出台。\r\n6、制定《边通航边施工方案》初稿。\r\n7、组织开展第三季度安全演习。\r\n8、召开月度安全生产例会。', '2015-09-05', '2015-09-30', '32', null, '0', '2015-09-05', '3', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001');
INSERT INTO `task` VALUES ('42', '9月份党群主要工作', '1、按照公司“9月份党群工作推进计划表”要求开展各项工作。\r\n2、组织参加“建港杯”篮球赛，力争优异成绩。\r\n3、梳理职工书屋借阅书籍的统计台账。\r\n4、中秋节相关活动的筹划工作。\r\n', '2015-09-05', '2015-09-30', '32', null, '0', '2015-09-05', '9', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001');
INSERT INTO `task` VALUES ('43', '完成3万吨航道工程施工组织设计及分部分项审批。', '', '2015-09-05', '2015-09-15', '34', null, '0', '2015-09-05', '2', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('44', '局质量检查问题整改及反馈', '疏浚工程和水工工程各自按问题整改，后统一由水工部门出整改反馈报告。', '2015-09-02', '2015-09-10', '34', null, '0', '2015-09-05', '2', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
INSERT INTO `task` VALUES ('45', '围堰图纸的修改', '9月2号已与设计沟通围堰图纸修改事项，现需跟踪修改进度，尽快完成修改并出正式蓝图。', '2015-09-03', '2015-09-10', '34', null, '0', '2015-09-05', '2', '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');

-- ----------------------------
-- Table structure for task_type
-- ----------------------------
DROP TABLE IF EXISTS `task_type`;
CREATE TABLE `task_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '项目类型名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_type
-- ----------------------------
INSERT INTO `task_type` VALUES ('1', '进度');
INSERT INTO `task_type` VALUES ('2', '质量');
INSERT INTO `task_type` VALUES ('3', '安全');
INSERT INTO `task_type` VALUES ('4', '成本');
INSERT INTO `task_type` VALUES ('5', '船机管理');
INSERT INTO `task_type` VALUES ('6', '材料管理');
INSERT INTO `task_type` VALUES ('7', '资金管理');
INSERT INTO `task_type` VALUES ('8', '合同管理');
INSERT INTO `task_type` VALUES ('9', '党群工作');
INSERT INTO `task_type` VALUES ('10', '考勤管理');
INSERT INTO `task_type` VALUES ('11', '五化一出');

-- ----------------------------
-- Table structure for taskuser
-- ----------------------------
DROP TABLE IF EXISTS `taskuser`;
CREATE TABLE `taskuser` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `taskid` int(11) NOT NULL,
  `detail` text,
  `comment` text COMMENT '评语',
  `status` int(255) DEFAULT NULL COMMENT '提交状态 0：未提交 1：已提交 2：已评价',
  `subdate` date DEFAULT NULL COMMENT '任务提交时间',
  `report` text COMMENT '工作报告',
  `evadate` date DEFAULT NULL COMMENT '评价时间',
  PRIMARY KEY (`id`),
  KEY `fk_task-user_user_1` (`userid`) USING BTREE,
  KEY `fk_task-user_task_1` (`taskid`) USING BTREE,
  CONSTRAINT `taskuser_ibfk_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`id`),
  CONSTRAINT `taskuser_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of taskuser
-- ----------------------------
INSERT INTO `taskuser` VALUES ('7', '8', '26', '', null, null, null, null, null);
INSERT INTO `taskuser` VALUES ('8', '9', '26', '', null, null, null, null, null);
INSERT INTO `taskuser` VALUES ('9', '10', '26', '', null, null, null, null, null);
INSERT INTO `taskuser` VALUES ('10', '11', '26', '', null, null, null, null, null);
INSERT INTO `taskuser` VALUES ('11', '12', '27', 'qwwrerr', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('12', '10', '28', '', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('13', '10', '29', '描述2', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('14', '12', '29', '描述1', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('15', '10', '30', '1.做好内业资料整理，迎接公司7月6日考核。\r\n2.做好7月份船舶进退场工作。', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('16', '11', '30', '做好7月份安全检查工作。', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('17', '10', '31', '111111', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('18', '11', '31', '22222', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('19', '7', '32', '', '干的不错，继续努力', '2', '2015-07-13', '任务1 已经完成，没什么其他情况。', '2015-07-13');
INSERT INTO `taskuser` VALUES ('20', '7', '33', '任务描述2', '很好啦', '2', '2015-07-13', '活干完了', '2015-07-14');
INSERT INTO `taskuser` VALUES ('21', '26', '34', '8月份部门成本计划，限期内签定责任书', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('22', '33', '35', '1、制定施工方案；2、负责跟黄三角工程公司沟通，明确其施工任务；3、找公司落实绞吸船。', null, '1', '2015-08-29', '已完成', null);
INSERT INTO `taskuser` VALUES ('23', '35', '36', '通过与审计单位及审计局沟通确定工程款计量。', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('24', '35', '37', '', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('25', '12', '38', '1、按照公司下达的《8月份党群工作推进计划表》要求，提前完成各项工作。书记审阅后，上报公司。\r\n2、组织好业主篮球赛事宜，主力队员保证参赛，以及后勤支持。\r\n3、按照公司要求（技术部），按月上报信息化平台的相关报表、总结。', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('26', '8', '39', '1、做好艇38调遣相关工作，与公司及时联系，必要时请公司参加联检。\r\n2、组织召开月度安全生产例会。\r\n3、做好安全检查工作。\r\n4、重点关注实习生上下船、防护用品穿戴等情况，加强安全教育。', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('27', '10', '39', '1、做好艇38调遣相关工作，与公司及时联系，必要时请公司参加联检。\r\n2、组织召开月度安全生产例会。\r\n3、做好安全检查工作。\r\n4、重点关注实习生上下船、防护用品穿戴等情况，加强安全教育。', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('28', '11', '39', '1、做好艇38调遣相关工作，与公司及时联系，必要时请公司参加联检。\r\n2、组织召开月度安全生产例会。\r\n3、做好安全检查工作。\r\n4、重点关注实习生上下船、防护用品穿戴等情况，加强安全教育。', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('29', '42', '40', '', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('30', '8', '41', '1、做好船舶退场的手续办理工作。\r\n2、梳理内业资料，做好体系外审迎检准备。\r\n3、做好船舶安全检查、气象预警等工作。\r\n4、加强水工现场安全旁站。\r\n5、制定《边通航边施工方案》初稿。\r\n6、组织开展第三季度安全演习。\r\n7、召开月度安全生产例会。', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('31', '10', '41', '1、做好船舶退场的手续办理工作。\r\n2、梳理内业资料，做好体系外审迎检准备。\r\n3、安全标准化、制度化文件的出台。\r\n', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('32', '11', '41', '1、做好船舶退场的手续办理工作。\r\n2、梳理内业资料，做好体系外审迎检准备。\r\n3、做好船舶安全检查、气象预警等工作。\r\n4、加强水工现场安全旁站。\r\n', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('33', '42', '42', '1、按照公司“9月份党群工作推进计划表”要求开展各项工作。\r\n2、组织参加“建港杯”篮球赛，力争优异成绩。\r\n3、梳理职工书屋借阅书籍的统计台账。\r\n4、中秋节相关活动的筹划工作。\r\n', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('34', '17', '43', '', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('35', '15', '44', '', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('36', '17', '44', '', null, '0', null, null, null);
INSERT INTO `taskuser` VALUES ('37', '19', '45', '', null, '0', null, null, null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `realname` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `higher` int(11) DEFAULT NULL COMMENT '上级',
  `admin` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_user_department_1` (`higher`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`higher`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('7', 'root', '系统管理员', '', '123456', null, '1');
INSERT INTO `user` VALUES ('8', 'zgh', '张桂海', '', '123465', '1', '0');
INSERT INTO `user` VALUES ('9', 'wzq', '王志庆', '', '123456', '1', '0');
INSERT INTO `user` VALUES ('10', 'yb', '杨彬', '', '123456', '1', '0');
INSERT INTO `user` VALUES ('11', 'lh', '李宏', '', '123456', '1', '0');
INSERT INTO `user` VALUES ('12', 'smq', '宋孟岐', '', '123456', '5', '0');
INSERT INTO `user` VALUES ('13', 'wz', '王钊', '', '123456', '6', '0');
INSERT INTO `user` VALUES ('15', 'zz', '张卓', '', '123456', '2', '0');
INSERT INTO `user` VALUES ('16', 'lcb', '李春波', '', '123456', '2', '0');
INSERT INTO `user` VALUES ('17', 'lyd', '卢永东', '', '123456', '2', '0');
INSERT INTO `user` VALUES ('18', 'yl', '岳磊', '', '123456', '2', '0');
INSERT INTO `user` VALUES ('19', 'syb', '宋迎宾', '', '123456', '2', '0');
INSERT INTO `user` VALUES ('20', 'ssj', '宋盛君', '', '123456', '2', '0');
INSERT INTO `user` VALUES ('21', 'lc', '刘宸', '', '123456', '2', '0');
INSERT INTO `user` VALUES ('22', 'lsy', '陆书勇', '', '546112', '2', '0');
INSERT INTO `user` VALUES ('24', 'yinli', '尹力', '', '123456', '2', '0');
INSERT INTO `user` VALUES ('25', 'liuchao', '刘超', '', '123456', '2', '0');
INSERT INTO `user` VALUES ('26', 'yy', '岳岩', '', '123456', '3', '0');
INSERT INTO `user` VALUES ('27', 'lt', '李桐', '', '123456', '3', '0');
INSERT INTO `user` VALUES ('29', 'liuhuan', '刘欢', '', '123456', '4', '0');
INSERT INTO `user` VALUES ('30', 'lq', '鲁琦', '项目经理', '123456', null, '0');
INSERT INTO `user` VALUES ('31', 'wtd', '汪铁东', '常务副经理', 'aaaaaa', '7', '0');
INSERT INTO `user` VALUES ('32', 'wc', '王超', '项目书记', '123456', '7', '0');
INSERT INTO `user` VALUES ('33', 'ycy', '杨朝元', '副经理', '123456', '7', '0');
INSERT INTO `user` VALUES ('34', 'dy', '邓宇', '总工程师', '123456', '7', '0');
INSERT INTO `user` VALUES ('35', 'lk', '李凯', '副经理', '858891', '7', '0');
INSERT INTO `user` VALUES ('36', 'skl', '宋凯立', '财务总监', '123456', '7', '0');
INSERT INTO `user` VALUES ('40', 'wg', '文革', '', '123456', '6', '0');
INSERT INTO `user` VALUES ('41', 'wtl', '吴铁链', '', '123465', '8', '0');
INSERT INTO `user` VALUES ('42', 'sy', '盛阳', '', '123456', '5', '0');

-- ----------------------------
-- Procedure structure for updatetask
-- ----------------------------
DROP PROCEDURE IF EXISTS `updatetask`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updatetask`()
BEGIN
	UPDATE task set status = 1 where status = 0 and endDate < now();
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for taskstatusupdate
-- ----------------------------
DROP EVENT IF EXISTS `taskstatusupdate`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` EVENT `taskstatusupdate` ON SCHEDULE EVERY 1 DAY STARTS '2015-04-18 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO call updatetask()
;;
DELIMITER ;
