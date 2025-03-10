spadmin stop -p sp -m redis

cd /tmp/    
wget http://download.sensorsdata.cn/resourcesfile/redis-6.2.17.tar
tar -xf redis-6.2.17.tar
sudo mv /sensorsdata/main/program/sp/redis/bin/redis-server /home/sa_cluster/redis-server
sudo scp /tmp/redis-6.2.17/redis-server /sensorsdata/main/program/sp/redis/bin/
vim /sensorsdata/main/program/sp/redis/conf/redis_6178.conf



10.200.7.173    hybrid02.newyangguangbaoxian.sensorsdata.cloud  hybrid02
10.200.7.178    hybrid03.newyangguangbaoxian.sensorsdata.cloud  hybrid03
10.10.66.40     mail.sinosig.com
10.200.6.218    hybrid01.newyangguangbaoxian.sensorsdata.cloud  hybrid01


rename-command FLUSHALL ""
rename-command FLUSHDB  ""
rename-command CONFIG   ""
rename-command KEYS     ""
rename-command SHUTDOWN ""

/sensorsdata/main/program/sp/redis/bin/redis-cli -h 10.200.7.178 -p 6178 -a SensorsData2015


aradmin maintenance -p edge -m edge --recover
aradmin start -p edge -m edge