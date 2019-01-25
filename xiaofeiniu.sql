set names utf8;
drop database if exists xiaofeiniu;
create database xiaofeiniu charset=utf8;
use xiaofeiniu;

#管理员信息表
create table xfn_admin(
    aid int primary key auto_increment,#管理员编号
    aname varchar(32) unique,#管理员用户名
    apwd varchar(64)#管理员密码
);
insert into xfn_admin values
(null,'admin',password('123456')),
(null,'boss',password('999999'));


#项目全局设置
create table xfn_settings(
    sid int primary key auto_increment,#编号
    appName varchar(32),#店家名称
    apiUrl varchar(64),#数据PI子系统地址
    adminUrl varchar(64),#管理后台子系统地址
    appUrl varchar(64),#顾客app子系统地址
    icp varchar(64),#系统备案号
    copyright varchar(128)#系统版权声明
);
insert into xfn_settings values
(null,'小肥牛','http://127.0.0.1:8090','http://127.0.0.1:8091','http://127.0.0.1:8092','京ICP备12003709号-3','Copyright © 2002-2019 北京达内金桥科技有限公司版权所有');

#桌台信息表
create table xfn_table(
    tid int primary key auto_increment,#桌台编号
    tname varchar(32),#桌台昵称
    type varchar(32),#桌台类型，如3-4人桌
    status int#当前状态
);
insert into xfn_table values
(null,'福满堂','6-8人桌',1),
(null,'金镶玉','4人桌',2),
(null,'寿比天','10人桌',3),
(null,'猪八戒','2人桌',0);

#桌台预定信息表
create table xfn_reservation(
    rid int primary key auto_increment,
    contactName varchar(32),#联系人姓名
    phone varchar(16),#联系电话
    contactTime bigint,#联系时间
    dinnerTime bigint#预约的用餐时间
);
insert into xfn_reservation values
(null,'丁丁','13502159731',1548404879649,1548410400000),
(null,'当当','13507312159',1548404879649,1548410400000),
(null,'东东','13559021731',1548404879649,1548410400000);

#菜品分类表
create table xfn_category(
    cid int primary key auto_increment,#类别编号
    cname varchar(32)#类别名称
);
insert into xfn_category values
(null,'肉类'),
(null,'丸滑类'),
(null,'海鲜河鲜'),
(null,'菌菇类'),
(null,'蔬菜豆制品');

#菜品信息表
create table xfn_dish(
    did int primary key auto_increment,#菜品编号，起始值为100000
    title varchar(32),#菜品名称
    imgUrl varchar(128),#图片地址
    price decimal(6,2),#菜品价格
    detail varchar(128),#详细描述
    categoryId int,
    foreign key(categoryId) references xfn_category(cid)
);
insert into xfn_dish values
(100000,'草鱼片','r9470.2975695e.jpg',35,'选鲜活草鱼，切出鱼片冷鲜保存。锅开后再煮1分钟左右即可食用。',1),
(null,'脆皮肠','r9017.73c6111e.jpg',35,'锅开后再煮3分钟左右即可食用。',1),
(null,'酥肉','r4760.967a2577.jpg',35,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮3分钟左右即可食用。',1),
(null,'牛百叶','r9302.e0b0e236.jpg',35,'毛肚切丝后，配以调味料腌制而成。锅开后再煮2分钟左右即可食用。',1),
(null,'腰花','r9711.cd193b71.jpg',35,'选用大型厂家冷鲜腰花，经过解冻、清洗、切片而成。锅开后涮30秒左右即可食用。',1),
(null,'猪脑花','r9470.2975695e.jpg',35,'选用大型厂家冷鲜猪脑经过清洗，过水、撕膜而成。肉质细腻，锅开后再煮8分钟左右即可食用。',1);

#订单表
create table xfn_order(
    oid int primary key auto_increment,#订单编号
    startTime bigint,#开始用餐时间
    endTime bigint,#结束用餐时间
    customerCount int,#用餐人数
    tableId int,#桌号
    foreign key(tableId) references xfn_table(tid)
);
insert into xfn_order values
(1,1548404810420,1548404850420,3,1);

#订单详情表
create table xfn_order_detail(
    oid int primary key auto_increment,#订单编号
    dishId int,#菜单编号
    dishCount int,#菜品数量
    customerName varchar(32),#下单用户名
    orderId int,#订单编号
    foreign key(dishId) references xfn_dish(did),
    foreign key(orderId) references xfn_order(oid)
);
insert into xfn_order_detail values
(null,100001,1,'丁丁',1);