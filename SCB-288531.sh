-----------------------------------------------------------------------------------
ID   NAME                 ASSOCIATE_ID
47   default              SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF
48   production           SPS-20200721155719-CD53DDF4-CB27-11EA-A412-5254009A7FCF
49   smashbrickz_test     SPS-20200721155719-CD53D8E0-CB27-11EA-A412-5254009A7FCF
50   smashbrickz          SPS-20200721155719-CD53DB7E-CB27-11EA-A412-5254009A7FCF
51   costv_flutter        SPS-20200721155719-CD53D57A-CB27-11EA-A412-5254009A7FCF
52   costv_flutter_test   SPS-20200721190500-053946CC-CB42-11EA-A412-5254009A7FCF
53   Grid_Editor_Test     SPS-20200721155719-CD53E48E-CB27-11EA-A412-5254009A7FCF
54   Grid_Editor          SPS-20200721155719-CD53DFF2-CB27-11EA-A412-5254009A7FCF
55   PG                   SPS-20200721155707-C645089E-CB27-11EA-A412-5254009A7FCF
56   PG_test              SPS-20230523104552-EEF0FDF8-F913-11ED-94EF-5254009A7FCF


sbpadmin project dissociate -p default -i SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF
sbpadmin project dissociate -p production -i SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF
sbpadmin project dissociate -p smashbrickz_test -i SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF
sbpadmin project dissociate -p smashbrickz -i SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF
sbpadmin project dissociate -p costv_flutter -i SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF
sbpadmin project dissociate -p costv_flutter_test -i SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF
sbpadmin project dissociate -p Grid_Editor_Test -i SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF
sbpadmin project dissociate -p Grid_Editor -i SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF
sbpadmin project dissociate -p PG -i SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF
sbpadmin project dissociate -p PG_test -i SPS-20200721190500-053944A6-CB42-11EA-A412-5254009A7FCF



spsadmin project -m remove -p default
spsadmin project -m remove -p production
spsadmin project -m remove -p smashbrickz_test
spsadmin project -m remove -p smashbrickz
spsadmin project -m remove -p costv_flutter
spsadmin project -m remove -p costv_flutter_test
spsadmin project -m remove -p Grid_Editor_Test
spsadmin project -m remove -p Grid_Editor
spsadmin project -m remove -p PG
spsadmin project -m remove -p PG_test




spadmin config set server -m web -p sa -n allow_user_tag -v false -R
spadmin config set server -p sbp -m web -n allow_user_tag -v false -R
spadmin config set server -m web -p sa -n allow_user_tag -v false
spadmin config set server -p sbp -m web -n allow_user_tag -v false


sbpadmin business_config -a set -p sbp -k allow_user_tag -v false
#如果老导航还需要设置sa 和 sca的
sbpadmin business_config -a set -p sa -k allow_user_tag -v false
sbpadmin business_config -a set -p sca -k allow_user_tag -v false

spadmin restart -p sca -m web
spadmin restart -p sa -m web
spadmin restart -p sbp -m web