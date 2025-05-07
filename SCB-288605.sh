[PROD Orz sa_cluster@hybrid01 ~]$ sbpadmin project show 
======================================================================
------------------------------------------
project.id:                   8
name:                         dianguanjia
cname:                        店管家
status:                       NORMAL
is_schema_limited:            true
is_csm:                       false
super_token:                  schemaLimited-86lisype
event_mutable:                false
is_new_sign_up:               true
create_time:                  Wed Aug 30 14:54:40 CST 2023
associated_authorization_ids: [SAT-20230829221140-F9B2049E-4675-11EE-A1E5-5254009A7FCF, SA-20230829221140-F9B20264-4675-11EE-A1E5-5254009A7FCF]
------------------------------------------
------------------------------------------
project.id:                   1
name:                         default
cname:                        C测试项目
status:                       NORMAL
is_schema_limited:            true
is_csm:                       false
super_token:                  schemaLimited-8RLaP5SW
is_new_sign_up:               true
create_time:                  Mon Dec 13 20:24:14 CST 2021
associated_authorization_ids: [SA-20211207123337-D8A7F02E-5716-11EC-A74D-5254009A7FCF, SAT-20220707151119-FFCD7C1A-FDC3-11EC-9E48-5254009A7FCF]
------------------------------------------
------------------------------------------
project.id:                   7
name:                         production
cname:                        C正式环境
status:                       NORMAL
is_schema_limited:            true
is_csm:                       false
super_token:                  schemaLimited-uG3LoUV4
is_new_sign_up:               true
create_time:                  Thu Dec 23 15:58:48 CST 2021
associated_authorization_ids: [SA-20211207123337-D8A7EE3A-5716-11EC-A74D-5254009A7FCF, SAT-20220707151119-FFCD7CEC-FDC3-11EC-9E48-5254009A7FCF]
------------------------------------------
------------------------------------------
project.id:                   12
name:                         test_dianguanjia
cname:                        店管家测试
status:                       NORMAL
is_schema_limited:            true
is_csm:                       false
super_token:                  schemaLimited-8FlFF7ca
event_mutable:                false
is_new_sign_up:               true
create_time:                  Wed Aug 30 14:59:43 CST 2023
associated_authorization_ids: [SAT-20220707151119-FFCD7A80-FDC3-11EC-9E48-5254009A7FCF, SA-20211207123337-D8A7F1AA-5716-11EC-A74D-5254009A7FCF]
------------------------------------------
======================================================================
======================================================================
当前共有 4 个有效项目
最多允许的项目数为 6 个
======================================================================
[PROD Orz sa_cluster@hybrid01 ~]$ 


sbpadmin project dissociate -p dianguanjia -i SAT-20230829221140-F9B2049E-4675-11EE-A1E5-5254009A7FCF
sbpadmin project dissociate -p default -i SAT-20220707151119-FFCD7C1A-FDC3-11EC-9E48-5254009A7FCF
sbpadmin project dissociate -p production -i SAT-20220707151119-FFCD7CEC-FDC3-11EC-9E48-5254009A7FCF
sbpadmin project dissociate -p test_dianguanjia -i SAT-20220707151119-FFCD7A80-FDC3-11EC-9E48-5254009A7FCF