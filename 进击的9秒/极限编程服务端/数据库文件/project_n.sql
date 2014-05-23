/*
SQLyog Trial v11.25 (64 bit)
MySQL - 5.5.34 : Database - project_n
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`project_n` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `project_n`;

/*Table structure for table `tb_buff_buff` */

DROP TABLE IF EXISTS `tb_buff_buff`;

CREATE TABLE `tb_buff_buff` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '记录的ID',
  `buffId` int(10) NOT NULL DEFAULT '0' COMMENT 'buff的ID',
  `tbuffId` int(10) NOT NULL DEFAULT '0' COMMENT '能与之产生效果的buff的ID',
  `nbuffId` int(10) NOT NULL DEFAULT '0' COMMENT '新产生的buff的ID',
  `nstack` int(10) NOT NULL DEFAULT '1' COMMENT '新产生的buff的层叠数',
  `effect` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '产生效果后生产的效果',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6003 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `tb_buff_buff` */

/*Table structure for table `tb_buff_effect` */

DROP TABLE IF EXISTS `tb_buff_effect`;

CREATE TABLE `tb_buff_effect` (
  `buffEffectID` int(10) NOT NULL COMMENT 'buff的特效id',
  `attributeType` int(10) NOT NULL DEFAULT '0' COMMENT 'buff属性 1物理 2魔法',
  `effectTriggerCondition` varchar(255) NOT NULL DEFAULT '' COMMENT 'buff触发条件',
  `triggerEffectFormula` varchar(255) DEFAULT '' COMMENT '被动触发的buff或debuff效果计算公式',
  `triggerDotHotFormula` varchar(255) DEFAULT '' COMMENT '被动触发的Dot或hot效果计算公式',
  `effectFormula` varchar(255) NOT NULL DEFAULT '' COMMENT 'buff或debuff的效果计算公式',
  `dotHotFormula` varchar(255) DEFAULT '' COMMENT 'Dot或hot效果公式',
  `effectDropFormula` varchar(255) NOT NULL DEFAULT '' COMMENT '技能消失时的效果（技能效果添加的逆运算）',
  `addBuffId` int(20) NOT NULL DEFAULT '0' COMMENT 'buff触发buff的ID',
  PRIMARY KEY (`buffEffectID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tb_buff_effect` */

/*Table structure for table `tb_buff_info` */

DROP TABLE IF EXISTS `tb_buff_info`;

CREATE TABLE `tb_buff_info` (
  `buffId` int(10) NOT NULL DEFAULT '0' COMMENT 'buff的ID',
  `buffName` varchar(50) NOT NULL DEFAULT '' COMMENT 'buff的名称',
  `buffDes` varchar(255) DEFAULT '这是个灰常NB的buff' COMMENT 'buff的描述',
  `traceCD` int(10) NOT NULL DEFAULT '1' COMMENT 'buff的持续回合数',
  `replaceBuff` varchar(50) NOT NULL DEFAULT '' COMMENT '可替换的buff的id',
  `buffType` int(10) NOT NULL DEFAULT '0' COMMENT 'buff的类型',
  `maxStack` int(10) NOT NULL DEFAULT '1' COMMENT 'buff的最大堆叠层数',
  `buffEffectID` int(10) NOT NULL DEFAULT '0' COMMENT 'buff的效果的id',
  `buffEffectResource` int(10) NOT NULL DEFAULT '0' COMMENT 'buff的资源id',
  `buffIcon` int(10) NOT NULL DEFAULT '0' COMMENT 'buff的图标ID',
  PRIMARY KEY (`buffId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_buff_info` */

/*Table structure for table `tb_buff_skill` */

DROP TABLE IF EXISTS `tb_buff_skill`;

CREATE TABLE `tb_buff_skill` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '记录的ID',
  `buffId` int(10) NOT NULL DEFAULT '0' COMMENT 'buff的ID',
  `skillId` int(10) NOT NULL DEFAULT '0' COMMENT 'buff的ID',
  `addition` float NOT NULL DEFAULT '0' COMMENT '效果的加成',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=100031 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `tb_buff_skill` */

/*Table structure for table `tb_character` */

DROP TABLE IF EXISTS `tb_character`;

CREATE TABLE `tb_character` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '角色的id号',
  `nickname` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '角色的昵称',
  `createtime` datetime NOT NULL COMMENT '创建日期',
  `coin` int(20) NOT NULL DEFAULT '10000' COMMENT '角色的金币',
  `score` int(20) NOT NULL DEFAULT '0' COMMENT '角色的积分',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1000067 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `tb_character` */

insert  into `tb_character`(`id`,`nickname`,`createtime`,`coin`,`score`) values (1000065,'test135','2013-10-28 18:32:23',10000,0),(1000064,'test122','2013-10-28 18:29:32',10000,0),(1000063,'test134','2013-10-28 18:28:28',10040,40),(1000062,'test111','2013-10-28 17:42:10',10000,0),(1000061,'test457','2013-10-25 20:53:53',10000,0),(1000066,'test222','2013-10-29 14:50:47',10000,0);

/*Table structure for table `tb_character_matrix` */

DROP TABLE IF EXISTS `tb_character_matrix`;

CREATE TABLE `tb_character_matrix` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `characterId` int(10) NOT NULL DEFAULT '0' COMMENT '角色的id',
  `matrixId` int(10) NOT NULL DEFAULT '0' COMMENT '阵法的id',
  `eyes_1` int(10) NOT NULL DEFAULT '0' COMMENT '阵法1的战斗单元ID，0表示角色自身',
  `eyes_2` int(10) DEFAULT '0',
  `eyes_3` int(10) DEFAULT '0',
  `eyes_4` int(10) DEFAULT '0',
  `eyes_5` int(10) DEFAULT '0',
  `eyes_6` int(10) DEFAULT '0',
  `eyes_7` int(10) DEFAULT '0',
  `eyes_8` int(10) DEFAULT '0',
  `eyes_9` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8544 DEFAULT CHARSET=utf8;

/*Data for the table `tb_character_matrix` */

insert  into `tb_character_matrix`(`id`,`characterId`,`matrixId`,`eyes_1`,`eyes_2`,`eyes_3`,`eyes_4`,`eyes_5`,`eyes_6`,`eyes_7`,`eyes_8`,`eyes_9`) values (8543,0,0,-1,-1,-1,-1,0,-1,-1,-1,-1),(8541,1000066,0,0,0,0,3000050,3000051,3000052,0,0,0),(8540,1000065,0,0,0,0,3000047,3000048,3000049,0,0,0),(8539,1000064,0,0,0,0,3000046,3000045,3000044,0,0,0),(8538,1000063,0,0,0,0,3000043,3000042,3000041,0,0,0),(8537,1000059,0,-1,-1,-1,-1,0,-1,-1,-1,-1),(8536,1000062,0,0,0,0,3000040,3000039,3000038,0,0,0),(8535,1000061,0,0,0,0,3000037,3000036,3000035,0,0,0);

/*Table structure for table `tb_character_skill` */

DROP TABLE IF EXISTS `tb_character_skill`;

CREATE TABLE `tb_character_skill` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '已经学习的技能记录',
  `character_id` int(10) NOT NULL COMMENT '角色的id',
  `skillId` int(10) NOT NULL COMMENT '技能的ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `tb_character_skill` */

insert  into `tb_character_skill`(`id`,`character_id`,`skillId`) values (2,1000063,1001),(3,1000063,1002),(5,1000063,1003);

/*Table structure for table `tb_pet` */

DROP TABLE IF EXISTS `tb_pet`;

CREATE TABLE `tb_pet` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '宠物的ID',
  `owner` int(10) NOT NULL DEFAULT '0' COMMENT '拥有者的ID，角色的ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '宠物的名称',
  `templateID` int(10) NOT NULL DEFAULT '0' COMMENT '宠物的模板ID即怪物的模板ID',
  `skill_1` int(10) DEFAULT '0' COMMENT '宠物的技能栏1（主动）',
  `skill_2` int(10) DEFAULT '0' COMMENT '宠物的技能栏2',
  `skill_3` int(10) DEFAULT '0' COMMENT '宠物的技能栏3',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3000053 DEFAULT CHARSET=utf8;

/*Data for the table `tb_pet` */

insert  into `tb_pet`(`id`,`owner`,`name`,`templateID`,`skill_1`,`skill_2`,`skill_3`) values (3000046,1000064,'',0,0,0,0),(3000045,1000064,'',0,0,0,0),(3000044,1000064,'',0,0,0,0),(3000043,1000063,'',0,1002,0,0),(3000042,1000063,'',0,0,0,0),(3000041,1000063,'',0,0,0,0),(3000040,1000062,'',0,0,0,0),(3000039,1000062,'',0,0,0,0),(3000038,1000062,'',0,0,0,0),(3000037,1000061,'',0,0,0,0),(3000036,1000061,'',0,0,0,0),(3000035,1000061,'',0,0,0,0),(3000047,1000065,'',0,0,0,0),(3000048,1000065,'',0,0,0,0),(3000049,1000065,'',0,0,0,0),(3000050,1000066,'',0,0,0,0),(3000051,1000066,'',0,0,0,0),(3000052,1000066,'',0,0,0,0);

/*Table structure for table `tb_register` */

DROP TABLE IF EXISTS `tb_register`;

CREATE TABLE `tb_register` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '用户注册邮箱',
  `characterId` int(10) DEFAULT '0' COMMENT '用户的角色ID',
  `pid` int(11) DEFAULT '0' COMMENT '邀请人的角色id',
  `lastonline` datetime NOT NULL DEFAULT '2012-06-05 00:00:00' COMMENT '最后在线时间',
  `logintimes` int(11) NOT NULL DEFAULT '0' COMMENT '登陆次数',
  `enable` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否可以登录',
  PRIMARY KEY (`id`,`username`)
) ENGINE=MyISAM AUTO_INCREMENT=1927 DEFAULT CHARSET=utf8;

/*Data for the table `tb_register` */

insert  into `tb_register`(`id`,`username`,`password`,`email`,`characterId`,`pid`,`lastonline`,`logintimes`,`enable`) values (1925,'test135','111111','',1000065,0,'2012-06-05 00:00:00',0,1),(1924,'test122','111111','',1000064,0,'2012-06-05 00:00:00',0,1),(1923,'test134','111111','',1000063,0,'2012-06-05 00:00:00',0,1),(1922,'test111','111111','',1000062,0,'2012-06-05 00:00:00',0,1),(1921,'test457','111111','',1000061,0,'2012-06-05 00:00:00',0,1),(1926,'test222','222222','',1000066,0,'2012-06-05 00:00:00',0,1);

/*Table structure for table `tb_skill_effect` */

DROP TABLE IF EXISTS `tb_skill_effect`;

CREATE TABLE `tb_skill_effect` (
  `effectId` int(10) unsigned NOT NULL COMMENT '技能的特效ID',
  `formula` varchar(255) NOT NULL DEFAULT '' COMMENT '技能效果计算公式',
  `clearBuffId` int(10) NOT NULL DEFAULT '0' COMMENT '清除buff的ID',
  `clearRate` int(10) NOT NULL DEFAULT '100' COMMENT '清除buff的概率',
  `addBuffId` int(10) NOT NULL DEFAULT '0' COMMENT '添加buff的ID',
  `addRate` int(10) NOT NULL DEFAULT '100' COMMENT '添加buff的概率',
  PRIMARY KEY (`effectId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tb_skill_effect` */

insert  into `tb_skill_effect`(`effectId`,`formula`,`clearBuffId`,`clearRate`,`addBuffId`,`addRate`) values (610101,'attack=actor[\'physicalAttack\']*1.0',0,100,0,100),(10005,'attack=actor[\'physicalAttack\']*1.5',0,0,0,0),(10004,'（PhyAtt-MaxHp）*0.5',0,0,0,0),(10003,'（PhyAtt-MaxHp）*1.8',0,0,0,0),(10002,'attack=actor[\'physicalAttack\']*1.5',0,0,0,0),(10001,'attack=actor[\'physicalAttack\']*1.5',0,0,0,0);

/*Table structure for table `tb_skill_info` */

DROP TABLE IF EXISTS `tb_skill_info`;

CREATE TABLE `tb_skill_info` (
  `skillId` int(10) NOT NULL COMMENT '技能的ID',
  `skillName` varchar(255) NOT NULL DEFAULT '' COMMENT '技能的名称',
  `skillGroup` int(10) NOT NULL DEFAULT '0' COMMENT '技能组的id',
  `level` int(10) DEFAULT '1' COMMENT '技能的等级',
  `icon` int(20) NOT NULL DEFAULT '0' COMMENT '技能图标',
  `type` int(20) NOT NULL DEFAULT '0' COMMENT '技能图标类型',
  `skillType` int(20) NOT NULL DEFAULT '3' COMMENT '技能类型 0主动技能1被动技能2应用技能3战斗技能',
  `profession` int(20) NOT NULL DEFAULT '0' COMMENT '职业限制 0无限制 1战士 2法师 3游侠 4牧师 6怪物 9所有角色普通攻击技能',
  `skillDescript` varchar(255) NOT NULL DEFAULT '' COMMENT '技能的描述',
  `weaponRequied` int(10) NOT NULL DEFAULT '0' COMMENT '技能所需武器',
  `releaseType` int(10) NOT NULL DEFAULT '1' COMMENT '技能释放类型 1主动 2被动',
  `levelRequired` int(10) NOT NULL DEFAULT '1' COMMENT '技能需求等级',
  `itemRequired` int(10) NOT NULL DEFAULT '20030061' COMMENT '技能物品需求',
  `itemCountRequired` int(10) NOT NULL DEFAULT '1' COMMENT '技能物品个数需求',
  `levelUpMoney` int(10) NOT NULL DEFAULT '0' COMMENT '技能需要钱数',
  `releaseCD` int(10) NOT NULL DEFAULT '0' COMMENT '技能CD时间（回合数）',
  `distanceType` int(10) NOT NULL DEFAULT '2' COMMENT '技能的距离类型 1远程 2近身',
  `rangeType` int(10) NOT NULL DEFAULT '1' COMMENT '技能的范围类型 1单体 2全体 ..',
  `attributeType` int(10) NOT NULL DEFAULT '1' COMMENT '技能的属性类型 1物理 2魔法',
  `targetType` int(10) NOT NULL DEFAULT '3' COMMENT '技能的目标类型 1=自己 2=队友 3=敌方',
  `expendPower` int(10) NOT NULL DEFAULT '0' COMMENT '技能能量消耗',
  `expendHp` int(10) NOT NULL DEFAULT '0' COMMENT '技能血量消耗',
  `effect` int(10) NOT NULL DEFAULT '0' COMMENT '技能的效果ID',
  `releaseEffect` int(10) NOT NULL DEFAULT '0' COMMENT '技能的释放特效',
  `bearEffect` int(10) NOT NULL DEFAULT '0' COMMENT '技能的承受特效',
  `throwEffectId` int(10) NOT NULL DEFAULT '0' COMMENT '技能的投射特效',
  `aoeEffectId` int(10) NOT NULL DEFAULT '0' COMMENT '全屏特效',
  PRIMARY KEY (`skillId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tb_skill_info` */

insert  into `tb_skill_info`(`skillId`,`skillName`,`skillGroup`,`level`,`icon`,`type`,`skillType`,`profession`,`skillDescript`,`weaponRequied`,`releaseType`,`levelRequired`,`itemRequired`,`itemCountRequired`,`levelUpMoney`,`releaseCD`,`distanceType`,`rangeType`,`attributeType`,`targetType`,`expendPower`,`expendHp`,`effect`,`releaseEffect`,`bearEffect`,`throwEffectId`,`aoeEffectId`) values (610101,'普通攻击',6101,1,0,0,0,0,'',0,1,0,0,0,0,0,2,1,1,2,0,0,610101,0,0,0,0),(1013,'斩杀',0,1,0,0,1,0,'斩杀：10%概率造成十倍伤害',0,0,0,0,0,999,0,0,0,1,1,0,0,0,0,0,0,0),(1012,'巨力',0,1,0,0,1,0,'巨力：30%概率造成三倍伤害',0,0,0,0,0,280,0,0,0,1,1,0,0,0,0,0,0,0),(1011,'暴击',0,1,0,0,1,0,'暴击：50%概率造成双倍伤害',0,0,0,0,0,120,0,0,0,1,1,0,0,0,0,0,0,0),(1010,'招架',0,1,0,0,1,0,'招架：免疫所有技能，并对目标造成自身攻击*150%点伤害',0,0,0,0,0,500,0,0,0,1,1,0,0,0,0,0,0,0),(1009,'格挡',0,1,0,0,1,0,'格挡：50%概率格挡伤害（伤害减半）',0,0,0,0,0,120,0,0,0,1,1,0,0,0,0,0,0,0),(1007,'强力',0,1,0,0,1,0,'强力：攻击+20',0,0,0,0,0,30,0,0,0,1,1,0,0,0,0,0,0,0),(1008,'闪避',0,1,0,0,1,0,'闪避：10%概率闪避伤害（0伤害）',0,0,0,0,0,80,0,0,0,1,1,0,0,0,0,0,0,0),(1006,'强体',0,1,0,0,1,0,'强体：生命+100',0,0,0,0,0,30,0,0,0,1,1,0,0,0,0,0,0,0),(1005,'倒转乾坤',0,1,0,0,0,0,'倒转乾坤：对目标造成130%的伤害，并吸取30点生命值',0,1,0,0,0,80,0,2,1,1,3,0,0,10005,0,0,0,0),(1004,'天下无双',0,1,0,0,0,0,'天下无双：对全体目标造成（自身血量-自身攻击）*50%的伤害',0,1,0,0,0,500,0,2,2,1,3,0,0,10004,0,0,0,0),(1003,'致命一击',0,1,0,0,0,0,'致命一击：对目标造成（自身血量-自身攻击）*1.8的伤害',0,1,0,0,0,200,0,2,1,1,3,0,0,10003,0,0,0,0),(1002,'横扫千军',0,1,0,0,0,0,'横扫千军：对目标及所在列造成自身攻击*150%的竖排伤害',0,1,0,0,0,35,0,2,3,1,3,0,0,10002,0,0,0,0),(1000,'直捣黄龙',0,1,0,0,0,0,'直捣黄龙：对目标及所在行造成自身攻击*150%的横排伤害',0,1,0,0,0,35,0,2,4,1,3,0,0,10001,0,0,0,0);

/*Table structure for table `tb_skill_template` */

DROP TABLE IF EXISTS `tb_skill_template`;

CREATE TABLE `tb_skill_template` (
  `id` int(10) NOT NULL COMMENT '技能的id',
  `name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '技能的名称',
  `effect` varchar(1024) COLLATE utf8_unicode_ci DEFAULT '{}' COMMENT '技能效果',
  `skillid` int(10) DEFAULT '0' COMMENT '对应到主动技能的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `tb_skill_template` */

insert  into `tb_skill_template`(`id`,`name`,`effect`,`skillid`) values (1001,'直捣黄龙','{}',1001),(1002,'横扫千军','{}',1002),(1003,'致命一击','{}',1003),(1004,'天下无双','{}',1004),(1005,'倒转乾坤','{}',1005),(1006,'强体','{\"MaxHp\":100}',0),(1007,'强力','{\"PhyAtt\":20}',0),(1008,'闪避','{\"Dodge\":10}',0),(1009,'格挡','{\"Block\":50}',0),(1010,'招架','{\"MaxHp\":100}',0),(1011,'暴击','{\"PhyAtt\":20}',0),(1012,'巨力','{\"Dodge\":10}',0),(1013,'斩杀','{\"Dodge\":10}',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
