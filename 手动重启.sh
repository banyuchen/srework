中移预约重启
mkdir -pv /home/sa_cluster/sensors_backup
cp /etc/hosts /home/sa_cluster/sensors_backup/hosts_$(date +%F).conf
cp /etc/fstab /home/sa_cluster/sensors_backup/fstab_$(date +%F).conf

sudo systemctl status iptables.service
sudo iptables-save > /home/sa_cluster/sensors_backup/iptables_$(date +%F).bak
sudo iptables -vnL                  


aradmin pause -r extractor -m extractor -p sdf -a `hostname -f` -d 86400        # && aradmin maintenance -r extractor -m extractor -p sdf -a `hostname -f`
aradmin pause -r edge -m edge -p edge -a `hostname -f` -d 86400                 # && aradmin maintenance -e edge -m edge -p edge -a `hostname -f`

停当前节点的 web：        
    for mod in sbp sps sa sdg blitzreport infinity-workload sbp-approval-workflow;do aradmin pause -m web -p $mod -r web -a `hostname -f` -d 86400;done
    # for mod in sbp sps sa sdg blitzreport infinity-workload sbp-approval-workflow;do aradmin maintenance -m web -p $mod -r web -a `hostname -f`;done 
 
停INFINITY组件（无 infinity 组件则不需要执行）：
    for mod in ksyncer_kafka subscription_profile_stream subscription_sender subscription_stream infinity_server;do aradmin pause -m $mod -r $mod -p infinity -a `hostname -f` -d 86400;done
    # for mod in ksyncer_kafka subscription_profile_stream subscription_sender subscription_stream infinity_server;do aradmin maintenance -m $mod -r $mod -p infinity -a `hostname -f`;done
 
停当前节点的其他组件：        
    aradmin pause -m cloudatlas -p sca -r cloudatlas -a `hostname -f` -d 86400
    # aradmin maintenance -m cloudatlas -p sca -r cloudatlas -a `hostname -f`
    aradmin pause -m ssdb -r persistence_master -p sp -a `hostname -f` -d 86400
    # aradmin maintenance -m ssdb -r persistence_master -p sp -a `hostname -f`
    aradmin pause -m ssdb -r persistence_slave -p sp -a `hostname -f` -d 86400
    # aradmin maintenance -m ssdb -r persistence_slave -p sp -a `hostname -f`
    aradmin pause -m redis -r cache_master -p sp -a `hostname -f` -d 86400
    # aradmin maintenance -m redis -r cache_master -p sp -a `hostname -f`


mothershipadmin stop -m kafka -r kafka_broker  --host `hostname -f`
mothershipadmin stop -m kudu -r kudu_tserver --host `hostname -f`
mothershipadmin stop -m kudu -r kudu_master --host `hostname -f`
mothershipadmin stop -m kudu -r kudu_collector --host `hostname -f`
mothershipadmin stop -m hdfs -r datanode --host `hostname -f`
mothershipadmin stop -m hdfs -r namenode --host `hostname -f`
mothershipadmin stop -m hdfs -r journalnode --host `hostname -f`
mothershipadmin stop -m hdfs -r zkfc --host `hostname -f`
mothershipadmin stop -m impala -r impala_catalog_service --host `hostname -f`
mothershipadmin stop -m impala -r impala_daemon --host `hostname -f`
mothershipadmin stop -m impala -r impala_state_store --host `hostname -f`
mothershipadmin stop -m yarn -r nodemanager --host `hostname -f`
mothershipadmin stop -m yarn -r resourcemanager --host `hostname -f`
mothershipadmin stop -m yarn -r timelineserver --host `hostname -f`
mothershipadmin stop -m yarn -r historyserver --host `hostname -f`
mothershipadmin stop -m skv_offline -r replica_server --host `hostname -f`
mothershipadmin stop -m skv_offline -r meta_server --host `hostname -f`
mothershipadmin stop -m zookeeper -r zookeeper_server --host `hostname -f`


sudo systemctl stop etcd



sudo diff /etc/hosts /home/sa_cluster/sensors_backup/hosts_$(date +%F).conf
sudo diff /etc/fstab /home/sa_cluster/sensors_backup/fstab_$(date +%F).conf
 
对比 iptables -vnL 是否和关机前规则一致
##对比防火墙规则是否和启动前一致，注意如果有服务状态更改，需要找客户确认
sudo iptables -vnL


sudo systemctl start etcd
aradmin restart -p mothership -m mothership_server
mothershipadmin start -m zookeeper -r zookeeper_server --host `hostname -f`
mothershipadmin start -m kafka -r kafka_broker  --host `hostname -f`
mothershipadmin start -m kudu -r kudu_tserver --host `hostname -f`
mothershipadmin start -m kudu -r kudu_master --host `hostname -f`
mothershipadmin start -m kudu -r kudu_collector --host `hostname -f`
mothershipadmin start -m hdfs -r zkfc --host `hostname -f`
mothershipadmin start -m hdfs -r journalnode --host `hostname -f`
mothershipadmin start -m hdfs -r namenode --host `hostname -f`
mothershipadmin start -m hdfs -r datanode --host `hostname -f`
mothershipadmin start -m impala -r impala_catalog_service --host `hostname -f`
mothershipadmin start -m impala -r impala_state_store --host `hostname -f`
mothershipadmin start -m impala -r impala_daemon --host `hostname -f`
mothershipadmin start -m yarn -r nodemanager --host `hostname -f`
mothershipadmin start -m yarn -r resourcemanager --host `hostname -f`
mothershipadmin start -m yarn -r timelineserver --host `hostname -f`
mothershipadmin start -m yarn -r historyserver --host `hostname -f`
mothershipadmin start -m skv_offline -r replica_server --host `hostname -f`
mothershipadmin start -m skv_offline -r meta_server --host `hostname -f`

for mod in ksyncer_kafka subscription_profile_stream subscription_sender subscription_stream infinity_server;do aradmin start -m $mod -r $mod -p infinity -a `hostname -f`;done


查看 kudu 恢复进度
1、获取总文件数（以下获取的值需除以 2）：
sudo ls $(curl 127.0.0.1:8050/varz 2>/dev/null |grep fs_data_dirs= |awk -F'=' '{print $2}')/data |wc -l
2、查看已经打开的文件数
sudo tail -f $(curl 127.0.0.1:8050/varz 2>/dev/null |grep log_dir= |awk -F'=' '{print $2}')/kudu-tserver.INFO

#hdfs检查
hadoop dfsadmin -safemode get
hadoop dfsadmin -report
id hdfs && sudo -u hdfs hdfs fsck / || hdfs fsck /
  
#sp2.1标准环境(没有hdfs用户)  使用 hdfs fsck /
#sp1.17升级上来的环境(有hdfs用户) 使用sudo -u hdfs hdfs fsck /    

#kudu检查
kudu cluster ksck $(aradmin config get client -m kudu -p sp -n master_address -w literal)


启其他组件：      
    # aradmin maintenance --recover -m cloudatlas -r cloudatlas -p sca -a `hostname -f`
    aradmin start -m cloudatlas -r cloudatlas -p sca -a `hostname -f`
    # aradmin maintenance --recover -m ssdb -r persistence_master -p sp -a `hostname -f`
    aradmin start -m ssdb -r persistence_master -p sp -a `hostname -f`
    # aradmin maintenance --recover -m ssdb -r persistence_slave -p sp -a `hostname -f`
    aradmin start -m ssdb -r persistence_slave -p sp -a `hostname -f`
    # aradmin maintenance --recover -m redis -r cache_master -p sp -a `hostname -f`
    aradmin start -m redis -r cache_master -p sp -a `hostname -f`  
 
启web：      
    # for mod in sbp sps sa sdg blitzreport infinity-workload sbp-approval-workflow;do aradmin maintenance --recover -m web -r web -p $mod  -a `hostname -f`;done
    for mod in sbp sps sa sdg blitzreport infinity-workload sbp-approval-workflow;do aradmin start -m web -r web -p $mod  -a `hostname -f` ;done


skvadmin health -m skv_offline
skvadmin show node -d
skvadmin show table -d 


 # for mod in extractor data_loader id_mapping_skv_proxy; do aradmin maintenance -m $mod -p sdf --recover && aradmin start -m $mod -p sdf;done
    aradmin start -m data_loader -p sdf
    aradmin start -m id_mapping_skv_proxy -p sdf
    aradmin start -m extractor -p sdf
    # aradmin maintenance -m scheduler -p sp --recover
    aradmin start -m scheduler -p sp
    # aradmin maintenance -m jobscheduler -p sps --recover
    aradmin start -m jobscheduler -p sps
    # aradmin maintenance -m edge -p edge --recover
    aradmin start -m edge -p edge
    aradmin start -m identity_skv_proxy -p horizon
    aradmin start -m stream_manager -p horizon
    aradmin start -m subscription_sender -p horizon


aradmin status
 
# 检查是否存在维护状态的组件
aradmin captain list_maintained