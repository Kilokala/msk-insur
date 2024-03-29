CREATE TABLE b_lang
(
	LID char(2) not null,
	SORT int(18) not null default '100',
	DEF char(1) not null default 'N',
	ACTIVE char(1) not null default 'Y',
	NAME varchar(50) not null,
	DIR varchar(50) not null,
	FORMAT_DATE varchar(50) not null,
	FORMAT_DATETIME varchar(50) not null,
	FORMAT_NAME varchar(255),
	WEEK_START int(1) null default 1,
	CHARSET varchar(255),
	LANGUAGE_ID char(2) not null,
	DOC_ROOT varchar(255),
	DOMAIN_LIMITED char(1) not null default 'N',
	SERVER_NAME varchar(255),
	SITE_NAME varchar(255),
	EMAIL varchar(255),
	PRIMARY KEY (LID)
);

CREATE TABLE b_language
(
	LID char(2) not null,
	SORT int not null default '100',
	DEF char(1) not null default 'N',
	ACTIVE char(1) not null default 'Y',
	NAME varchar(50) not null,
	FORMAT_DATE varchar(50) not null,
	FORMAT_DATETIME varchar(50) not null,
	FORMAT_NAME varchar(255),
	WEEK_START int(1) null default 1,
	CHARSET varchar(255),
	DIRECTION char(1) not null default 'Y',
	PRIMARY KEY (LID)
);

CREATE TABLE b_lang_domain
(
	LID char(2) not null,
	DOMAIN varchar(255) not null,
	PRIMARY KEY (LID, DOMAIN)
);

CREATE TABLE b_event_type
(
	ID INT(18) not null auto_increment,
	LID char(2) not null,
	EVENT_NAME varchar(255) not null,
	NAME varchar(100),
	DESCRIPTION text,
	SORT INT(18) not null default '150',
	PRIMARY KEY (ID),
	UNIQUE ux_1 (EVENT_NAME, LID)
);

CREATE TABLE b_event_message
(
	ID INT(18) not null auto_increment,
	TIMESTAMP_X timestamp,
	EVENT_NAME varchar(255) not null,
	LID char(2),
	ACTIVE char(1) not null default 'Y',
	EMAIL_FROM varchar(255) not null default '#EMAIL_FROM#',
	EMAIL_TO varchar(255) not null default '#EMAIL_TO#',
	SUBJECT varchar(255),
	MESSAGE text,
	BODY_TYPE varchar(4) not null default 'text',
	BCC text,
	REPLY_TO varchar(255),
	CC varchar(255),
	IN_REPLY_TO varchar(255),
	PRIORITY varchar(50),
	FIELD1_NAME varchar(50),
	FIELD1_VALUE varchar(255),
	FIELD2_NAME varchar(50),
	FIELD2_VALUE varchar(255),
	PRIMARY KEY (ID),
	INDEX ix_b_event_message_name (EVENT_NAME(50))
);

CREATE TABLE b_event
(
	ID INT(18) not null auto_increment,
	EVENT_NAME varchar(255) not null,
	MESSAGE_ID int(18),
	LID varchar(255) not null,
	C_FIELDS longtext,
	DATE_INSERT datetime,
	DATE_EXEC datetime,
	SUCCESS_EXEC char(1) not null default 'N',
	DUPLICATE char(1) not null default 'Y',
	PRIMARY KEY (ID),
	INDEX ix_success (SUCCESS_EXEC),
	INDEX ix_b_event_date_exec (DATE_EXEC)
);

CREATE TABLE b_group
(
	ID int(18) not null auto_increment,
	TIMESTAMP_X timestamp,
	ACTIVE char(1) not null default 'Y',
	C_SORT int(18) not null default '100',
	ANONYMOUS char(1) not null default 'N',
	NAME varchar(255) not null,
	DESCRIPTION varchar(255),
	SECURITY_POLICY text,
	STRING_ID varchar(255),
	PRIMARY KEY (ID)
);

CREATE TABLE b_user
(
	ID int(18) not null auto_increment,
	TIMESTAMP_X timestamp,
	LOGIN varchar(50) not null,
	`PASSWORD` varchar(50) not null,
	CHECKWORD varchar(50),
	ACTIVE char(1) not null default 'Y',
	NAME varchar(50),
	LAST_NAME varchar(50),
	EMAIL varchar(255) not null,
	LAST_LOGIN datetime,
	DATE_REGISTER datetime not null,
	LID char(2),
	PERSONAL_PROFESSION varchar(255),
	PERSONAL_WWW varchar(255),
	PERSONAL_ICQ varchar(255),
	PERSONAL_GENDER char(1),
	PERSONAL_BIRTHDATE varchar(50),
	PERSONAL_PHOTO int(18),
	PERSONAL_PHONE varchar(255),
	PERSONAL_FAX varchar(255),
	PERSONAL_MOBILE varchar(255),
	PERSONAL_PAGER varchar(255),
	PERSONAL_STREET text,
	PERSONAL_MAILBOX varchar(255),
	PERSONAL_CITY varchar(255),
	PERSONAL_STATE varchar(255),
	PERSONAL_ZIP varchar(255),
	PERSONAL_COUNTRY varchar(255),
	PERSONAL_NOTES text,
	WORK_COMPANY varchar(255),
	WORK_DEPARTMENT varchar(255),
	WORK_POSITION varchar(255),
	WORK_WWW varchar(255),
	WORK_PHONE varchar(255),
	WORK_FAX varchar(255),
	WORK_PAGER varchar(255),
	WORK_STREET text,
	WORK_MAILBOX varchar(255),
	WORK_CITY varchar(255),
	WORK_STATE varchar(255),
	WORK_ZIP varchar(255),
	WORK_COUNTRY varchar(255),
	WORK_PROFILE text,
	WORK_LOGO int(18),
	WORK_NOTES text,
	ADMIN_NOTES text,
	STORED_HASH varchar(32),
	XML_ID varchar(255),
	PERSONAL_BIRTHDAY date,
	EXTERNAL_AUTH_ID varchar(255),
	CHECKWORD_TIME datetime,
	SECOND_NAME varchar(50),
	CONFIRM_CODE varchar(8),
	LOGIN_ATTEMPTS int(18),
	LAST_ACTIVITY_DATE datetime,
	AUTO_TIME_ZONE char(1),
	TIME_ZONE varchar(50),
	TIME_ZONE_OFFSET int(18),
	PRIMARY KEY (ID),
	UNIQUE ix_login (LOGIN, EXTERNAL_AUTH_ID),
	INDEX ix_b_user_email (EMAIL),
	INDEX ix_b_user_activity_date (LAST_ACTIVITY_DATE),
	INDEX IX_B_USER_XML_ID (XML_ID)
);

CREATE TABLE b_user_group
(
	USER_ID INT(18) not null,
	GROUP_ID INT(18) not null,
	DATE_ACTIVE_FROM datetime,
	DATE_ACTIVE_TO datetime,
	UNIQUE ix_user_group (USER_ID, GROUP_ID),
	INDEX ix_user_group_group (GROUP_ID)
);

CREATE TABLE b_module
(
	ID VARCHAR(50) not null,
	DATE_ACTIVE timestamp not null,
	PRIMARY KEY (ID)
);

CREATE TABLE b_option
(
	MODULE_ID VARCHAR(50),
	NAME VARCHAR(50) not null,
	VALUE TEXT,
	DESCRIPTION VARCHAR(255),
	SITE_ID CHAR(2),
	UNIQUE ix_option(MODULE_ID, NAME, SITE_ID),
	INDEX ix_option_name(NAME)
);

CREATE TABLE b_module_to_module
(
	ID int not null auto_increment,
	TIMESTAMP_X TIMESTAMP not null,
	SORT INT(18) not null default '100',
	FROM_MODULE_ID VARCHAR(50) not null,
	MESSAGE_ID VARCHAR(50) not null,
	TO_MODULE_ID VARCHAR(50) not null,
	TO_PATH VARCHAR(255),
	TO_CLASS VARCHAR(50),
	TO_METHOD VARCHAR(50),
	TO_METHOD_ARG varchar(255),
	PRIMARY KEY (ID),
	INDEX ix_module_to_module(FROM_MODULE_ID, MESSAGE_ID, TO_MODULE_ID, TO_CLASS, TO_METHOD)
);

CREATE TABLE b_agent
(
	ID INT(18) not null auto_increment,
	MODULE_ID varchar(50),
	SORT INT(18) not null default '100',
	NAME text null,
	ACTIVE char(1) not null default 'Y',
	LAST_EXEC datetime,
	NEXT_EXEC datetime not null,
	DATE_CHECK datetime,
	AGENT_INTERVAL INT(18) default '86400',
	IS_PERIOD char(1) default 'Y',
	USER_ID INT(18),
	PRIMARY KEY (ID),
	INDEX ix_act_next_exec(ACTIVE, NEXT_EXEC),
	INDEX ix_agent_user_id(USER_ID)
);

CREATE TABLE b_file
(
	ID INT(18) not null auto_increment,
	TIMESTAMP_X TIMESTAMP not null,
	MODULE_ID varchar(50),
	HEIGHT INT(18),
	WIDTH INT(18),
	FILE_SIZE INT(18) not null,
	CONTENT_TYPE VARCHAR(255) default 'IMAGE',
	SUBDIR VARCHAR(255),
	FILE_NAME VARCHAR(255) not null,
	ORIGINAL_NAME VARCHAR(255),
	DESCRIPTION VARCHAR(255),
	HANDLER_ID VARCHAR(50),
	PRIMARY KEY (ID)
);

CREATE TABLE b_module_group
(
	ID int(11) not null auto_increment,
	MODULE_ID varchar(50) not null,
	GROUP_ID int(11) not null,
	G_ACCESS varchar(255) not null,
	SITE_ID char(2),
	PRIMARY KEY (ID),
	UNIQUE UK_GROUP_MODULE(MODULE_ID, GROUP_ID, SITE_ID)
);

CREATE TABLE b_favorite
(
	ID int(18) not null auto_increment,
	TIMESTAMP_X datetime,
	DATE_CREATE datetime,
	C_SORT int(18) not null default '100',
	MODIFIED_BY int(18),
	CREATED_BY int(18),
	MODULE_ID varchar(50),
	NAME varchar(255),
	URL text,
	COMMENTS text,
	LANGUAGE_ID char(2),
	USER_ID int null,
	CODE_ID int(18),
	COMMON char(1) not null default 'Y',
	PRIMARY KEY (ID)
);

CREATE TABLE b_user_stored_auth
(
	ID int(18) not null auto_increment,
	USER_ID int(18) not null,
	DATE_REG datetime not null,
	LAST_AUTH datetime not null,
	STORED_HASH varchar(32) not null,
	TEMP_HASH char(1) not null default 'N',
	IP_ADDR int(10) unsigned not null,
	PRIMARY KEY (ID),
	INDEX ux_user_hash (USER_ID)
);

CREATE TABLE b_site_template
(
	ID int not null auto_increment,
	SITE_ID char(2) not null,
	`CONDITION` varchar(255),
	SORT int not null default '500',
	TEMPLATE varchar(50) not null,
	PRIMARY KEY (ID)
);
ALTER TABLE b_site_template ADD UNIQUE INDEX UX_B_SITE_TEMPLATE(SITE_ID, `CONDITION`, TEMPLATE);

CREATE TABLE b_event_message_site
(
	EVENT_MESSAGE_ID int not null,
	SITE_ID char(2) not null,
	PRIMARY KEY (EVENT_MESSAGE_ID, SITE_ID)
);

CREATE TABLE b_user_option
(
	ID int not null auto_increment,
	USER_ID int null,
	CATEGORY varchar(50) not null,
	NAME varchar(255) not null,
	VALUE text null,
	COMMON char(1) not null default 'N',
	PRIMARY KEY (ID),
	INDEX ix_user_option_param(CATEGORY, NAME),
	INDEX ix_user_option_user(USER_ID)
);

CREATE TABLE b_captcha
(
	ID varchar(32) not null,
	CODE varchar(20) not null,
	IP varchar(15) not null,
	DATE_CREATE datetime not null,
	UNIQUE UX_B_CAPTCHA(ID)
);

CREATE TABLE b_user_field
(
	ID int(11) not null auto_increment,
	ENTITY_ID varchar(20),
	FIELD_NAME varchar(20),
	USER_TYPE_ID varchar(50),
	XML_ID varchar(255),
	SORT int,
	MULTIPLE char(1) not null default 'N',
	MANDATORY char(1) not null default 'N',
	SHOW_FILTER char(1) not null default 'N',
	SHOW_IN_LIST char(1) not null default 'Y',
	EDIT_IN_LIST char(1) not null default 'Y',
	IS_SEARCHABLE char(1) not null default 'N',
	SETTINGS text,
	PRIMARY KEY (ID),
	UNIQUE ux_user_type_entity(ENTITY_ID, FIELD_NAME)
);

CREATE TABLE b_user_field_lang
(
	USER_FIELD_ID int(11),
	LANGUAGE_ID char(2),
	EDIT_FORM_LABEL varchar(255),
	LIST_COLUMN_LABEL varchar(255),
	LIST_FILTER_LABEL varchar(255),
	ERROR_MESSAGE varchar(255),
	HELP_MESSAGE varchar(255),
	PRIMARY KEY (USER_FIELD_ID, LANGUAGE_ID)
);

CREATE TABLE if not exists b_user_field_enum
(
	ID int(11) not null auto_increment,
	USER_FIELD_ID int(11),
	VALUE varchar(255) not null,
	DEF char(1) not null default 'N',
	SORT int(11) not null default 500,
	XML_ID varchar(255) not null,
	PRIMARY KEY (ID),
	UNIQUE ux_user_field_enum(USER_FIELD_ID, XML_ID)
);

CREATE TABLE b_task
(
	ID int(18) not null auto_increment,
	NAME varchar(100) not null,
	LETTER char(1),
	MODULE_ID varchar(50) not null,
	SYS char(1) not null,
	DESCRIPTION varchar(255),
	BINDING varchar(50) default 'module',
	PRIMARY KEY (ID),
	INDEX ix_task(MODULE_ID, BINDING, LETTER, SYS)
);

CREATE TABLE b_group_task
(
	GROUP_ID int(18) not null,
	TASK_ID int(18) not null,
	EXTERNAL_ID varchar(50) default '',
	PRIMARY KEY (GROUP_ID,TASK_ID)
);

CREATE TABLE b_operation
(
	ID int(18) not null auto_increment,
	NAME varchar(50) not null,
	MODULE_ID varchar(50) not null,
	DESCRIPTION varchar(255),
	BINDING varchar(50) default 'module',
	PRIMARY KEY (ID)
);

CREATE TABLE b_task_operation
(
	TASK_ID int(18) not null,
	OPERATION_ID int(18) not null,
	PRIMARY KEY (TASK_ID,OPERATION_ID)
);

CREATE TABLE b_group_subordinate(
	ID int(18) not null,
	AR_SUBGROUP_ID varchar(255) not null,
	PRIMARY KEY (ID)
);

CREATE TABLE b_rating
(
	ID int(11) not null auto_increment,
	ACTIVE char(1) not null,
	NAME varchar(512) not null,
	ENTITY_ID varchar(50) not null,
	CALCULATION_METHOD varchar(3) not null default 'SUM',
	CREATED datetime,
	LAST_MODIFIED datetime,
	LAST_CALCULATED datetime,
	POSITION char(1) null default 'N',
	AUTHORITY char(1) null default 'N',
	CALCULATED char(1) not null default 'N',
	CONFIGS text,
	PRIMARY KEY (ID)
);

CREATE TABLE b_rating_component
(
	ID int(11) not null auto_increment,
	RATING_ID int(11) not null,
	ACTIVE char(1) not null default 'N',
	ENTITY_ID varchar(50) not null,
	MODULE_ID varchar(50) not null,
	RATING_TYPE varchar(50) not null,
	NAME varchar(50) not null,
	COMPLEX_NAME varchar(200) not null,
	CLASS varchar(255) not null,
	CALC_METHOD varchar(255) not null,
	EXCEPTION_METHOD varchar(255),
	LAST_MODIFIED datetime,
	LAST_CALCULATED datetime,
	NEXT_CALCULATION datetime,
	REFRESH_INTERVAL int(11) not null,
	CONFIG text,
	PRIMARY KEY (ID),
	KEY IX_RATING_ID_1 (RATING_ID, ACTIVE, NEXT_CALCULATION)
);

CREATE TABLE b_rating_component_results
(
	ID int(11) not null auto_increment,
	RATING_ID int(11) not null,
	ENTITY_TYPE_ID varchar(50) not null,
	ENTITY_ID int(11) not null,
	MODULE_ID varchar(50) not null,
	RATING_TYPE varchar(50) not null,
	NAME varchar(50) not null,
	COMPLEX_NAME varchar(200) not null,
	CURRENT_VALUE decimal(18,4),
	PRIMARY KEY (ID),
	KEY IX_ENTITY_TYPE_ID (ENTITY_TYPE_ID),
	KEY IX_COMPLEX_NAME (COMPLEX_NAME),
	KEY IX_RATING_ID_2 (RATING_ID, COMPLEX_NAME)
);

CREATE TABLE b_rating_results
(
	ID int(11) not null auto_increment,
	RATING_ID int(11) not null,
	ENTITY_TYPE_ID varchar(50) not null,
	ENTITY_ID int(11) not null,
	CURRENT_VALUE decimal(18,4),
	PREVIOUS_VALUE decimal(18,4),
	CURRENT_POSITION int(11) null default '0',
	PREVIOUS_POSITION int(11) null default '0',
	PRIMARY KEY (ID),
	KEY IX_RATING_3 (RATING_ID, ENTITY_TYPE_ID, ENTITY_ID),
	KEY IX_RATING_4 (RATING_ID, ENTITY_ID)
);

CREATE TABLE b_rating_vote
(
	ID int(11) not null auto_increment,
	RATING_VOTING_ID int(11) not null,
	ENTITY_TYPE_ID varchar(50) not null,
	ENTITY_ID int(11) not null,
	OWNER_ID int(11) not null,
	VALUE decimal(18,4) not null,
	ACTIVE char(1) not null,
	CREATED datetime not null,
	USER_ID int(11) not null,
	USER_IP varchar(64) not null,
	PRIMARY KEY (ID),
	KEY IX_RAT_VOTE_ID (RATING_VOTING_ID, USER_ID),
	KEY IX_RAT_VOTE_ID_2 (ENTITY_TYPE_ID, ENTITY_ID, USER_ID),
	KEY IX_RAT_VOTE_ID_3 (OWNER_ID, CREATED),
	KEY IX_RAT_VOTE_ID_4 (USER_ID),
	KEY IX_RAT_VOTE_ID_5 (CREATED, VALUE),
	KEY IX_RAT_VOTE_ID_6 (ACTIVE),
	KEY IX_RAT_VOTE_ID_7 (RATING_VOTING_ID, CREATED),
	KEY IX_RAT_VOTE_ID_8 (ENTITY_TYPE_ID, CREATED),
	KEY IX_RAT_VOTE_ID_9 (CREATED, USER_ID)
);

CREATE TABLE b_rating_voting
(
	ID int(11) not null auto_increment,
	ENTITY_TYPE_ID varchar(50) not null,
	ENTITY_ID int(11) not null,
	OWNER_ID int(11) not null,
	ACTIVE char(1) not null,
	CREATED datetime,
	LAST_CALCULATED datetime,
	TOTAL_VALUE decimal(18,4) not null,
	TOTAL_VOTES int(11) not null,
	TOTAL_POSITIVE_VOTES int(11) not null,
	TOTAL_NEGATIVE_VOTES int(11) not null,
	PRIMARY KEY (ID),
	KEY IX_ENTITY_TYPE_ID_2 (ENTITY_TYPE_ID, ENTITY_ID, ACTIVE),
	KEY IX_ENTITY_TYPE_ID_4 (TOTAL_VALUE)
);

CREATE TABLE b_rating_voting_prepare
(
	ID int(11) not null auto_increment,
	RATING_VOTING_ID int(11) not null,
	TOTAL_VALUE decimal(18,4) not null,
	TOTAL_VOTES int(11) not null,
	TOTAL_POSITIVE_VOTES int(11) not null,
	TOTAL_NEGATIVE_VOTES int(11) not null,
	PRIMARY KEY (ID),
	KEY IX_RATING_VOTING_ID (RATING_VOTING_ID)
);

CREATE TABLE b_rating_prepare
(
	ID int(11) NULL
);

CREATE TABLE b_rating_rule
(
	ID int(11) not null auto_increment,
	ACTIVE char(1) not null default 'N',
	NAME varchar(256) not null,
	ENTITY_TYPE_ID varchar(50) not null,
	CONDITION_NAME varchar(200) not null,
	CONDITION_MODULE varchar(50),
	CONDITION_CLASS varchar(255) not null,
	CONDITION_METHOD varchar(255) not null,
	CONDITION_CONFIG text not null,
	ACTION_NAME varchar(200) not null,
	ACTION_CONFIG text not null,
	ACTIVATE char(1) not null default 'N',
	ACTIVATE_CLASS varchar(255) not null,
	ACTIVATE_METHOD varchar(255) not null,
	DEACTIVATE char(1) not null default 'N',
	DEACTIVATE_CLASS varchar(255) not null,
	DEACTIVATE_METHOD varchar(255) not null,
	CREATED datetime,
	LAST_MODIFIED datetime,
	LAST_APPLIED datetime,
	PRIMARY KEY (ID)
);

CREATE TABLE b_rating_rule_vetting
(
	ID int(11) not null auto_increment,
	RULE_ID int(11) not null,
	ENTITY_TYPE_ID varchar(50) not null,
	ENTITY_ID int(11) not null,
	ACTIVATE char(1) not null default 'N',
	APPLIED char(1) not null default 'N',
	PRIMARY KEY (ID),
	KEY RULE_ID (RULE_ID,ENTITY_TYPE_ID,ENTITY_ID)
);

CREATE TABLE b_rating_user
(
	ID int(11) not null auto_increment,
	RATING_ID int(11) not null,
	ENTITY_ID int(11) not null,
	BONUS decimal(18,4) null default '0.0000',
	VOTE_WEIGHT decimal(18,4) null default '0.0000',
	VOTE_COUNT int(11) null default '0',
	PRIMARY KEY (ID),
	KEY RATING_ID (RATING_ID,ENTITY_ID)
);

CREATE TABLE b_rating_vote_group
(
	ID int(11) not null auto_increment,
	GROUP_ID int(11) not null,
	TYPE char(1) not null,
	PRIMARY KEY (ID),
	KEY RATING_ID (GROUP_ID, TYPE)
);

CREATE TABLE b_rating_weight
(
	ID int(11) not null auto_increment,
	RATING_FROM decimal(18,4) not null,
	RATING_TO decimal(18,4) not null,
	WEIGHT decimal(18,4) default '0',
	COUNT int(11) default '0',
	PRIMARY KEY (ID)
);
insert into b_rating_weight (RATING_FROM, RATING_TO, WEIGHT, COUNT) VALUES (-1000000, 1000000, 1, 10);

insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(1,'view_own_profile','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(2,'view_subordinate_users','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(3,'view_all_users','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(4,'view_groups','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(5,'view_tasks','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(6,'view_other_settings','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(7,'edit_own_profile','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(8,'edit_all_users','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(9,'edit_subordinate_users','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(10,'edit_groups','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(11,'edit_tasks','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(12,'edit_other_settings','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(13,'cache_control','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(14,'edit_php','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(15,'fm_view_permission','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(16,'fm_edit_permission','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(17,'fm_edit_existent_folder','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(18,'fm_create_new_file','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(19,'fm_edit_existent_file','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(20,'fm_create_new_folder','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(21,'fm_delete_file','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(22,'fm_delete_folder','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(23,'fm_view_file','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(24,'fm_view_listing','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(25,'fm_edit_in_workflow','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(26,'fm_rename_file','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(27,'fm_rename_folder','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(28,'fm_upload_file','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(29,'fm_add_to_menu','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(30,'fm_download_file','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(31,'fm_lpa','main',null,'file');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(32,'lpa_template_edit','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(33,'view_event_log','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(34,'edit_ratings','main',null,'module');
insert into b_operation (ID,NAME,MODULE_ID,DESCRIPTION,BINDING) values(35,'manage_short_uri','main',null,'module');

insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(1,'main_denied','D','main','Y',null,'module');
insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(2,'main_change_profile','P','main','Y',null,'module');
insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(3,'main_view_all_settings','R','main','Y',null,'module');
insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(4,'main_view_all_settings_change_profile','T','main','Y',null,'module');
insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(5,'main_edit_subordinate_users','V','main','Y',null,'module');
insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(6,'main_full_access','W','main','Y',null,'module');
insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(7,'fm_folder_access_denied','D','main','Y',null,'file');
insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(8,'fm_folder_access_read','R','main','Y',null,'file');
insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(9,'fm_folder_access_write','W','main','Y',null,'file');
insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(10,'fm_folder_access_full','X','main','Y',null,'file');
insert into b_task (ID,NAME,LETTER,MODULE_ID,SYS,DESCRIPTION,BINDING) values(11,'fm_folder_access_workflow','U','main','Y',null,'file');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('2','1');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('2','7');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('3','1');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('3','3');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('3','4');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('3','5');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('3','6');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('4','1');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('4','3');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('4','4');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('4','5');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('4','6');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('4','7');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('5','1');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('5','2');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('5','4');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('5','5');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('5','6');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('5','7');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('5','9');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','1');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','3');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','4');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','5');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','6');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','7');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','8');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','10');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','11');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','12');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','13');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','32');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','33');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('6','34');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('8','15');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('8','23');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('8','24');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','15');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','17');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','18');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','19');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','20');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','21');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','22');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','23');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','24');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','25');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','26');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','27');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','28');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','29');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','30');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('9','31');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','15');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','16');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','17');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','18');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','19');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','20');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','21');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','22');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','23');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','24');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','25');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','26');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','27');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','28');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','29');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','30');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('10','31');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('11','15');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('11','19');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('11','23');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('11','24');
insert into b_task_operation (TASK_ID,OPERATION_ID) VALUES ('11','25');

CREATE TABLE b_event_log
(
	/*SYSTEM GENERATED*/
	ID INT(18) not null auto_increment,
	TIMESTAMP_X TIMESTAMP not null,

	/*CALLER INFO*/
	SEVERITY VARCHAR(50) not null, /*SECURITY, WARNING, NOTICE*/
	AUDIT_TYPE_ID VARCHAR(50) not null, /*LOGIN_OK, LOGIN_WRONG_PASSWORD*/
	MODULE_ID VARCHAR(50) not null, /*main, iblock, main.register */
	ITEM_ID VARCHAR(255) not null, /*user login, element id*/

	/*FROM $_SERVER*/
	REMOTE_ADDR VARCHAR(40),
	USER_AGENT TEXT, /*2000 for oracle and mssql*/
	REQUEST_URI TEXT, /*2000 for oracle and mssql*/

	/*FROM CONSTANTS AND VARIABLES*/
	SITE_ID CHAR(2), /*if defined*/
	USER_ID INT(18), /*if logged in*/
	GUEST_ID INT(18), /* if statistics installed*/

	/*ADDITIONAL*/
	DESCRIPTION MEDIUMTEXT,
	PRIMARY KEY (ID),
	INDEX ix_b_event_log_time(TIMESTAMP_X)
);

CREATE TABLE b_cache_tag
(
	SITE_ID char(2),
	CACHE_SALT char(4),
	RELATIVE_PATH varchar(255),
	TAG varchar(100),
	INDEX ix_b_cache_tag_0 (SITE_ID, CACHE_SALT, RELATIVE_PATH(50)),
	INDEX ix_b_cache_tag_1 (TAG)
);

CREATE TABLE b_user_hit_auth
(
	ID int(18) not null auto_increment,
	USER_ID int(18) not null,
	HASH varchar(32) not null,
	URL varchar(255) not null,
	SITE_ID char(2),
	TIMESTAMP_X datetime not null,
	PRIMARY KEY (ID),
	INDEX IX_USER_HIT_AUTH_1(HASH),
	INDEX IX_USER_HIT_AUTH_2(USER_ID),
	INDEX IX_USER_HIT_AUTH_3(TIMESTAMP_X)
);

CREATE TABLE b_undo
(
	ID varchar(255) not null,
	MODULE_ID varchar(50),
	UNDO_TYPE varchar(50),
	UNDO_HANDLER varchar(255),
	CONTENT mediumtext,
	USER_ID int,
	TIMESTAMP_X int,
	PRIMARY KEY (ID)
);

CREATE TABLE b_user_digest
(
	USER_ID int not null,
	DIGEST_HA1 varchar(32) not null,
	PRIMARY KEY (USER_ID)
);

CREATE TABLE b_checklist
(
	ID int(11) not null AUTO_INCREMENT,
	DATE_CREATE varchar(255),
	TESTER varchar(50),
	COMPANY_NAME varchar(255),
	PICTURE int(11),
	TOTAL int(11),
	SUCCESS int(11),
	FAILED int(11),
	PENDING int(11),
	SKIP int(11),
	STATE longtext,
	REPORT_COMMENT text,
	REPORT char(1) default 'Y',
	PRIMARY KEY (ID)
);

CREATE TABLE b_short_uri
(
	ID int(18) not null auto_increment,
	URI varchar(250) not null,
	URI_CRC int(18) not null,
	SHORT_URI varbinary(250) not null,
	SHORT_URI_CRC int(18) not null,
	STATUS int(18) not null default 301,
	MODIFIED timestamp not null,
	LAST_USED timestamp,
	NUMBER_USED int(18) not null default 0,
	PRIMARY KEY (ID),
	INDEX ux_b_short_uri_1 (SHORT_URI_CRC),
	INDEX ux_b_short_uri_2 (URI_CRC)
);

CREATE TABLE b_user_access
(
	USER_ID int(11),
	PROVIDER_ID varchar(50),
	ACCESS_CODE varchar(100),
	INDEX ix_ua_user_provider (USER_ID, PROVIDER_ID),
	INDEX ix_ua_user_access (USER_ID, ACCESS_CODE)
);

insert into b_user_access (USER_ID, PROVIDER_ID, ACCESS_CODE) values (0, 'group', 'G2');

CREATE TABLE b_user_access_check
(
	USER_ID int(11),
	PROVIDER_ID varchar(50),
	INDEX ix_uac_user_provider (USER_ID, PROVIDER_ID)
);

CREATE TABLE b_user_counter
(
	USER_ID int(18) not null,
	SITE_ID char(2) not null default '**',
	CODE varchar(50) not null,
	CNT int(18) not null default 0,
	LAST_DATE datetime,
	TAG varchar(255),
	PARAMS text,
	PRIMARY KEY (USER_ID, SITE_ID, CODE),
	INDEX ix_buc_tag (TAG)
);

CREATE TABLE b_hot_keys_code
(
	ID int(18) not null AUTO_INCREMENT,
	CLASS_NAME varchar(50),
	CODE varchar(255),
	NAME varchar(255),
	COMMENTS varchar(255),
	TITLE_OBJ varchar(50),
	URL varchar(255),
	IS_CUSTOM tinyint(1) not null default '1',
	PRIMARY KEY (ID),
	INDEX ix_hot_keys_code_cn (CLASS_NAME),
	INDEX ix_hot_keys_code_url (URL)
);

INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(3, 'CAdminTabControl', 'NextTab();', 'HK_DB_CADMINTC', 'HK_DB_CADMINTC_C', 'tab-container', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(5, 'btn_new', 'var d=BX (''btn_new''); if (d) location.href = d.href;', 'HK_DB_BUT_ADD', 'HK_DB_BUT_ADD_C', 'btn_new', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(6, 'btn_excel', 'var d=BX(''btn_excel''); if (d) location.href = d.href;', 'HK_DB_BUT_EXL', 'HK_DB_BUT_EXL_C', 'btn_excel', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(7, 'btn_settings', 'var d=BX(''btn_settings''); if (d) location.href = d.href;', 'HK_DB_BUT_OPT', 'HK_DB_BUT_OPT_C', 'btn_settings', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(8, 'btn_list', 'var d=BX(''btn_list''); if (d) location.href = d.href;', 'HK_DB_BUT_LST', 'HK_DB_BUT_LST_C', 'btn_list', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(9, 'Edit_Save_Button', 'var d=BX .findChild(document, {attribute: {''name'': ''save''}}, true );  if (d) d.click();', 'HK_DB_BUT_SAVE', 'HK_DB_BUT_SAVE_C', 'Edit_Save_Button', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(10, 'btn_delete', 'var d=BX(''btn_delete''); if (d) location.href = d.href;', 'HK_DB_BUT_DEL', 'HK_DB_BUT_DEL_C', 'btn_delete', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(12, 'CAdminFilter', 'var d=BX .findChild(document, {attribute: {''name'': ''find''}}, true ); if (d) d.focus();', 'HK_DB_FLT_FND', 'HK_DB_FLT_FND_C', 'find', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(13, 'CAdminFilter', 'var d=BX .findChild(document, {attribute: {''name'': ''set_filter''}}, true );  if (d) d.click();', 'HK_DB_FLT_BUT_F', 'HK_DB_FLT_BUT_F_C', 'set_filter', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(14, 'CAdminFilter', 'var d=BX .findChild(document, {attribute: {''name'': ''del_filter''}}, true );  if (d) d.click();', 'HK_DB_FLT_BUT_CNL', 'HK_DB_FLT_BUT_CNL_C', 'del_filter', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(15, 'bx-panel-admin-button-help-icon-id', 'var d=BX(''bx-panel-admin-button-help-icon-id''); if (d) location.href = d.href;', 'HK_DB_BUT_HLP', 'HK_DB_BUT_HLP_C', 'bx-panel-admin-button-help-icon-id', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(17, 'Global', 'BXHotKeys.ShowSettings();', 'HK_DB_SHW_L', 'HK_DB_SHW_L_C', 'bx-panel-hotkeys', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(19, 'Edit_Apply_Button', 'var d=BX .findChild(document, {attribute: {''name'': ''apply''}}, true );  if (d) d.click();', 'HK_DB_BUT_APPL', 'HK_DB_BUT_APPL_C', 'Edit_Apply_Button', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(20, 'Edit_Cancel_Button', 'var d=BX .findChild(document, {attribute: {''name'': ''cancel''}}, true );  if (d) d.click();', 'HK_DB_BUT_CANCEL', 'HK_DB_BUT_CANCEL_C', 'Edit_Cancel_Button', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(78, 'top_panel_templ_site', '', '-=AUTONAME=-', NULL, 'top_panel_templ_site', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(77, 'top_panel_templ_templ_css', '', '-=AUTONAME=-', NULL, 'top_panel_templ_templ_css', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(76, 'top_panel_templ_site_css', '', '-=AUTONAME=-', NULL, 'top_panel_templ_site_css', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(74, 'top_panel_cache_not', '', '-=AUTONAME=-', NULL, 'top_panel_cache_not', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(75, 'top_panel_edit_mode', '', '-=AUTONAME=-', NULL, 'top_panel_edit_mode', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(73, 'top_panel_cache_comp', '', '-=AUTONAME=-', NULL, 'top_panel_cache_comp', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(72, 'top_panel_cache_page', '', '-=AUTONAME=-', NULL, 'top_panel_cache_page', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(71, 'main_top_panel_struct_panel', '', '-=AUTONAME=-', NULL, 'main_top_panel_struct_panel', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(70, 'top_panel_access_folder_new', '', '-=AUTONAME=-', NULL, 'top_panel_access_folder_new', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(68, 'top_panel_del_page', '', '-=AUTONAME=-', NULL, 'top_panel_del_page', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(69, 'top_panel_folder_prop', '', '-=AUTONAME=-', NULL, 'top_panel_folder_prop', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(82, 'top_panel_debug_incl', '', '-=AUTONAME=-', NULL, 'top_panel_debug_incl', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(67, 'top_panel_edit_page_php', '', '-=AUTONAME=-', NULL, 'top_panel_edit_page_php', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(65, 'top_panel_edit_page_html', '', '-=AUTONAME=-', NULL, 'top_panel_edit_page_html', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(63, 'top_panel_edit_page', '', '-=AUTONAME=-', NULL, 'top_panel_edit_page', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(64, 'top_panel_page_prop', '', '-=AUTONAME=-', NULL, 'top_panel_page_prop', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(62, 'top_panel_create_folder', '', '-=AUTONAME=-', NULL, 'top_panel_create_folder', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(60, 'top_panel_create_page', '', '-=AUTONAME=-', NULL, 'top_panel_create_page', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(58, 'top_panel_bizproc_tasks', '', '-=AUTONAME=-', NULL, 'top_panel_bizproc_tasks', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(57, 'top_panel_help', '', '-=AUTONAME=-', NULL, 'top_panel_help', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(59, 'top_panel_add_fav', '', '-=AUTONAME=-', NULL, 'top_panel_add_fav', NULL, 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(56, 'top_panel_interface_settings', '', '-=AUTONAME=-', NULL, 'top_panel_interface_settings', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(54, 'top_panel_org_fav', '', '-=AUTONAME=-', NULL, 'top_panel_org_fav', NULL, 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(55, 'top_panel_module_settings', '', '-=AUTONAME=-', NULL, 'top_panel_module_settings', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(83, 'top_panel_debug_sql', '', '-=AUTONAME=-', NULL, 'top_panel_debug_sql', NULL, 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(81, 'top_panel_debug_time', '', '-=AUTONAME=-', NULL, 'top_panel_debug_time', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(84, 'top_panel_debug_compr', '', '-=AUTONAME=-', NULL, 'top_panel_debug_compr', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(85, 'MTP_SHORT_URI1', '', '-=AUTONAME=-', NULL, 'MTP_SHORT_URI1', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(86, 'MTP_SHORT_URI_LIST', '', '-=AUTONAME=-', NULL, 'MTP_SHORT_URI_LIST', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(87, 'FMST_PANEL_STICKER_ADD', '', '-=AUTONAME=-', NULL, 'FMST_PANEL_STICKER_ADD', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(88, 'FMST_PANEL_STICKERS_SHOW', '', '-=AUTONAME=-', NULL, 'FMST_PANEL_STICKERS_SHOW', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(89, 'FMST_PANEL_CUR_STICKER_LIST', '', '-=AUTONAME=-', NULL, 'FMST_PANEL_CUR_STICKER_LIST', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(90, 'FMST_PANEL_ALL_STICKER_LIST', '', '-=AUTONAME=-', NULL, 'FMST_PANEL_ALL_STICKER_LIST', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(91, 'top_panel_menu', 'var d=BX("bx-panel-menu"); if (d) d.click();', '-=AUTONAME=-', NULL, 'bx-panel-menu', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(92, 'top_panel_admin', 'var d=BX(''bx-panel-admin-tab''); if (d) location.href = d.href;', '-=AUTONAME=-', NULL, 'bx-panel-admin-tab', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(93, 'admin_panel_site', 'var d=BX(''bx-panel-view-tab''); if (d) location.href = d.href;', '-=AUTONAME=-', NULL, 'bx-panel-view-tab', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(94, 'admin_panel_admin', 'var d=BX(''bx-panel-admin-tab''); if (d) location.href = d.href;', '-=AUTONAME=-', NULL, 'bx-panel-admin-tab', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(111, 'top_panel_create_new', '', '-=AUTONAME=-', NULL, 'top_panel_create_new', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(96, 'top_panel_folder_prop_new', '', '-=AUTONAME=-', NULL, 'top_panel_folder_prop_new', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(97, 'main_top_panel_structure', '', '-=AUTONAME=-', NULL, 'main_top_panel_structure', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(98, 'top_panel_clear_cache', '', '-=AUTONAME=-', NULL, 'top_panel_clear_cache', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(99, 'top_panel_templ', '', '-=AUTONAME=-', NULL, 'top_panel_templ', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(100, 'top_panel_debug', '', '-=AUTONAME=-', NULL, 'top_panel_debug', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(101, 'MTP_SHORT_URI', '', '-=AUTONAME=-', NULL, 'MTP_SHORT_URI', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(102, 'FMST_PANEL_STICKERS', '', '-=AUTONAME=-', NULL, 'FMST_PANEL_STICKERS', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(103, 'top_panel_settings', '', '-=AUTONAME=-', NULL, 'top_panel_settings', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(104, 'top_panel_fav', '', '-=AUTONAME=-', NULL, 'top_panel_fav', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(106, 'Global', 'location.href=''/bitrix/admin/hot_keys_list.php?lang=ru'';', 'HK_DB_SHW_HK', '', '', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(107, 'top_panel_edit_new', '', '-=AUTONAME=-', NULL, 'top_panel_edit_new', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(108, 'FLOW_PANEL_CREATE_WITH_WF', '', '-=AUTONAME=-', NULL, 'FLOW_PANEL_CREATE_WITH_WF', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(109, 'FLOW_PANEL_EDIT_WITH_WF', '', '-=AUTONAME=-', NULL, 'FLOW_PANEL_EDIT_WITH_WF', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(110, 'FLOW_PANEL_HISTORY', '', '-=AUTONAME=-', NULL, 'FLOW_PANEL_HISTORY', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(112, 'top_panel_create_folder_new', '', '-=AUTONAME=-', NULL, 'top_panel_create_folder_new', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(139, 'Global', 'location.href=''/bitrix/admin/user_admin.php?lang=''+phpVars.LANGUAGE_ID;', 'HK_DB_SHW_U', '', '', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(116, 'bx-panel-toggle', '', '-=AUTONAME=-', NULL, 'bx-panel-toggle', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(118, 'bx-panel-expander', 'var d=BX(''bx-panel-expander''); if (d) BX.fireEvent(d, ''click'');', '-=AUTONAME=-', NULL, 'bx-panel-expander', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(117, 'bx-panel-small-toggle', '', '-=AUTONAME=-', NULL, 'bx-panel-small-toggle', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(119, 'bx-panel-hider', 'var d=BX(''bx-panel-hider''); if (d) d.click();', '-=AUTONAME=-', NULL, 'bx-panel-hider', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(120, 'search-textbox-input', 'var d=BX(''search-textbox-input''); if (d) { d.click(); d.focus();}', '-=AUTONAME=-', '', 'search', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(121, 'bx-search-input', 'var d=BX(''bx-search-input''); if (d) { d.click(); d.focus(); }', '-=AUTONAME=-', '', 'bx-search-input', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(133, 'bx-panel-logout', 'var d=BX(''bx-panel-logout''); if (d) location.href = d.href;', '-=AUTONAME=-', '', 'bx-panel-logout', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(138, 'CDialog', 'var d=BX(''btn_popup_save''); if (d) d.click();', 'HK_DB_D_EDIT_SAVE', '', 'btn_popup_save', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(135, 'CDialog', 'var d=BX(''cancel''); if (d) d.click();', 'HK_DB_D_CANCEL', '', 'cancel', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(136, 'CDialog', 'var d=BX(''close''); if (d) d.click();', 'HK_DB_D_CLOSE', '', 'close', '', 0);
INSERT INTO b_hot_keys_code (ID, CLASS_NAME, CODE, `NAME`, COMMENTS, TITLE_OBJ, URL, IS_CUSTOM) VALUES(137, 'CDialog', 'var d=BX(''savebtn''); if (d) d.click();', 'HK_DB_D_SAVE', '', 'savebtn', '', 0);

CREATE TABLE b_hot_keys
(
	ID int(18) not null AUTO_INCREMENT,
	KEYS_STRING varchar(20) not null,
	CODE_ID int(18) not null,
	USER_ID int(18) not null,
	PRIMARY KEY (ID),
	UNIQUE ix_b_hot_keys_co_u (CODE_ID,USER_ID),
	INDEX ix_hot_keys_code (CODE_ID),
	INDEX ix_hot_keys_user (USER_ID)
);


INSERT INTO b_hot_keys (KEYS_STRING, CODE_ID, USER_ID) VALUES('Ctrl+Alt+85', 139, 0);
INSERT INTO b_hot_keys (KEYS_STRING, CODE_ID, USER_ID) VALUES('Ctrl+Alt+80', 17, 0);
INSERT INTO b_hot_keys (KEYS_STRING, CODE_ID, USER_ID) VALUES('Ctrl+Alt+70', 120, 0);
INSERT INTO b_hot_keys (KEYS_STRING, CODE_ID, USER_ID) VALUES('Ctrl+Alt+68', 117, 0);
INSERT INTO b_hot_keys (KEYS_STRING, CODE_ID, USER_ID) VALUES('Ctrl+Alt+81', 3, 0);
INSERT INTO b_hot_keys (KEYS_STRING, CODE_ID, USER_ID) VALUES('Ctrl+Alt+75', 106, 0);
INSERT INTO b_hot_keys (KEYS_STRING, CODE_ID, USER_ID) VALUES('Ctrl+Alt+79', 133, 0);
INSERT INTO b_hot_keys (KEYS_STRING, CODE_ID, USER_ID) VALUES('Ctrl+Alt+70', 121, 0);
INSERT INTO b_hot_keys (KEYS_STRING, CODE_ID, USER_ID) VALUES('Ctrl+Alt+69', 118, 0);

CREATE TABLE b_admin_notify
(
	ID int(18) not null AUTO_INCREMENT,
	MODULE_ID VARCHAR(50),
	TAG VARCHAR(255),
	MESSAGE text,
	ENABLE_CLOSE char(1) NULL default 'Y',
	PRIMARY KEY (ID),
	KEY IX_AD_TAG (TAG)
);
