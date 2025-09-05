
# 使用 sa_cluster 用户

aradmin config get global -n customer_id

aradmin version

aradmin status

mothershipadmin status

hdfs dfsadmin -safemode get

id hdfs && sudo -u hdfs hdfs fsck / || hdfs fsck /

hdfs dfsadmin -report

kudu cluster ksck $(aradmin config get client -m kudu -p sp -n master_address -w literal)

kafka-topics --zookeeper $(cat $SENSORS_DATA_HOME/conf/sensors_data.property |grep zookeeper.connect|awk -F "=" '{print $2}') --describe
