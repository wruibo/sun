/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016/12/7 16:15:39                           */
/*==============================================================*/

create database if not exists db_system default character set=utf8 collate=utf8_general_ci;

/*==============================================================*/
/* Table: tb_log                                                */
/*==============================================================*/
create table tb_log
(
   log_id               integer not null auto_increment,
   module_code          varchar(32) not null,
   module_name          varchar(32) not null,
   brief                text not null,
   user_id              integer not null,
   create_time          bigint not null,
   primary key (log_id)
);

/*==============================================================*/
/* Table: tb_module                                             */
/*==============================================================*/
create table tb_module
(
   module_id            integer not null auto_increment,
   parent_id            integer default NULL,
   code                 varchar(32) not null,
   name                 varchar(32) not null,
   icon                 text not null,
   path                 text not null,
   `desc`               text default NULL,
   `order`              integer not null default 0,
   disable              boolean not null default false,
   creater              integer not null,
   create_time          bigint not null,
   primary key (module_id),
   unique key AK_Key_2 (code)
);

/*==============================================================*/
/* Table: tb_notice                                             */
/*==============================================================*/
create table tb_notice
(
   notice_id            integer not null auto_increment,
   user_id              integer not null,
   title                varchar(32) not null,
   content              text not null,
   topped               boolean not null default true,
   deleted              boolean not null default false,
   creater              integer not null,
   create_time          bigint not null default 0,
   primary key (notice_id)
);

/*==============================================================*/
/* Table: tb_role                                               */
/*==============================================================*/
create table tb_role
(
   role_id              integer not null auto_increment,
   name                 varchar(32) not null,
   `desc`               text default NULL,
   creater              integer not null,
   create_time          bigint not null,
   primary key (role_id),
   unique key AK_Key_2 (name)
);

/*==============================================================*/
/* Table: tb_role_module                                        */
/*==============================================================*/
create table tb_role_module
(
   role_id              integer not null,
   module_id            integer not null,
   creater              integer not null,
   create_time          bigint not null,
   primary key (role_id, module_id)
);

/*==============================================================*/
/* Table: tb_user                                               */
/*==============================================================*/
create table tb_user
(
   user_id              integer not null auto_increment,
   account              varchar(32) not null,
   password             varchar(32) not null comment '原始密码的sha1值',
   name                 varchar(32) not null,
   email                varchar(64) default NULL,
   disable              boolean not null default false,
   creater              integer not null,
   create_time          bigint not null,
   primary key (user_id),
   unique key AK_Key_2 (account)
);

/*==============================================================*/
/* Table: tb_user_role                                          */
/*==============================================================*/
create table tb_user_role
(
   role_id              integer not null,
   user_id              integer not null,
   creater              integer not null,
   create_time          bigint not null,
   primary key (role_id, user_id)
);

alter table tb_log add constraint FK_Reference_153 foreign key (user_id)
      references tb_user (user_id) on delete restrict on update restrict;

alter table tb_module add constraint FK_Reference_9 foreign key (parent_id)
      references tb_module (module_id) on delete restrict on update restrict;

alter table tb_notice add constraint FK_Reference_154 foreign key (user_id)
      references tb_user (user_id) on delete restrict on update restrict;

alter table tb_role_module add constraint FK_Reference_7 foreign key (module_id)
      references tb_module (module_id) on delete restrict on update restrict;

alter table tb_role_module add constraint FK_ref_role foreign key (role_id)
      references tb_role (role_id) on delete restrict on update restrict;

alter table tb_user_role add constraint FK_ref_role foreign key (role_id)
      references tb_role (role_id) on delete restrict on update restrict;

alter table tb_user_role add constraint FK_ref_user foreign key (user_id)
      references tb_user (user_id) on delete restrict on update restrict;

