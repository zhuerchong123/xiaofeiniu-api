SET NAMES UTF8;
DROP database if exists xiaofeiniu;
create database xiaofeiniu charset=utf8;
use xiaofeiniu;

#管理员信息表
create table xfn_admin{
    aid INT PRIMARY KEY auto_increment, #管理员编号
    aname varchar(32) only, #管理员用户名
    apwd varchar(64)  #管理员密码
}

#项目全局设置
create table xfn_settings{
    sid int primary key auto_increment, #编号
    appName varchar(32), #店家名称
    apiUrl varchar(64), #数据PI 子系统地址
    adminUrl varchar(64), #管理后台子系统地址
    appUrl varchar(64), #顾客app子系统地址
    icp varchar(64), #系统备案号
    copyright varchar(128) #系统版权声明
}

#桌台信息表
create table xfn_table{
    tid int primary key auto_increment, #桌台编号
    tname varchar(64), #桌台昵称
    type varchar(16), #桌台类型，如3-4人桌
    status int, #当前状态
}

#桌台预定信息表
create table xfn_reservation{
    rid int primary key auto_increment,
    contactName varchar(64), #联系人姓名
    phone varchar(16), #联系人电话
    contactTime bigint, #练习时间
    dinnerTime bigint  #预约的用餐时间
}

#菜品分类表
create table xfn_category{
    cid int primary key auto_increment, #类别编号
    cname varchar(32) #类别名称
}


#菜品信息表
create table xfn_dish{
    did int primary key auto_increment, #菜品编号，起始值为100000
    title varchar(32), #菜品名称/标题
    imgUrl varchar(128), #图片地址
    price decimal(6,2), #菜品的描述信息
    detail varchar(128), #详细描述
    categoryId int,   #所属类别的编号
    foreign key (categoryId) references xfn_category(cid)  #外键
}

#订单表
create table xfn_order{
    oid int primary key auto_increment, #订单编号
    startTime bigint, #开始用餐时间
    endTime bigint, #用餐结束时间
    customerCount int, #用餐人数
    tableId int, #桌台id
    foreign key (tableId) references xfn_table (tid) #外键
}

#订单详情表
create tableId xfn_order_detail{
    did int primary key auto_increment, #订单编号
    dishId int,  #菜品编号
    dishCount int, #菜品数量
    customerName varchar(64), #点餐用户的称呼
    orderId int, #订单编号，指明所有订单
    foreign key (dishId) references xfn_dish (did),
    foreign key (orderId) references xfn_order(oid)
}