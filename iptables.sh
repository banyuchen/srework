脚本地址：https://doc.sensorsdata.cn/display/~huayang/change_iptables.sh

# 如果环境有外网，会自动下载新版 iptables 的 rpm 包，如果环境无外网，请下载上传 iptables 的 rpm 包到 /home/sa_cluster 目录下
  
wget http://update.sensorsdata.cn/specialfile/iptables-services-1.4.21-35.el7.x86_64.rpm
MD5：b7ce9505d0bc06fb7efd43ff70778662        
 
wget http://update.sensorsdata.cn/specialfile/iptables-1.4.21-35.el7.x86_64.rpm
MD5：e3001c23d5039664c09ecdd64b08831b

# sftp 固定连接 
wget http://update.sensorsdata.cn/specialfile/change_iptables.sh



sudo cp /etc/sysconfig/iptables /home/sa_cluster/iptables.bak-20250303
sudo cat -n /etc/sysconfig/iptables

sudo vim /etc/sysconfig/iptables

-A INPUT -p tcp -m multiport --dports 2379,2380 -m comment --comment "禁止外部访问etcd相关的端口" -j DROP


sudo systemctl restart iptables
sudo iptables -nvL



for i in meta0{1..3};do echo $i && ssh $i sudo cp /etc/sysconfig/iptables /home/sa_cluster/iptables.bak-20250303; done
for i in data{01..10};do echo $i && ssh $i sudo cp /etc/sysconfig/iptables /home/sa_cluster/iptables.bak-20250303; done



