新版 ：https://doc.sensorsdata.cn/pages/viewpage.action?pageId=610764155


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
sudo systemctl status iptables


for i in meta0{1..3};do echo $i && ssh $i sudo cp /etc/sysconfig/iptables /home/sa_cluster/iptables.bak-20250303; done
for i in data{01..10};do echo $i && ssh $i sudo cp /etc/sysconfig/iptables /home/sa_cluster/iptables.bak-20250303; done



1、拿到客户环境 host
cat /etc/hosts | awk '{print $3}' | grep -v "local" > host.txt

2、分发脚本
for i in `cat host.txt`; do scp update.sh $i:~/ ; done

3、执行脚本
for i in `cat host.txt`; do ssh $i "sh update.sh" ; done


脚本
### 先备份当前 iptables 文件
sudo mv  /etc/sysconfig/iptables  /etc/sysconfig/iptables2024062601.bak
### 当前规则装载到 iptables 里面
sudo iptables-save >/etc/sysconfig/iptables
### 把装载的 iptables 也备份一下
sudo mv  /etc/sysconfig/iptables  /etc/sysconfig/iptables2024062602.bak
### 复制 01 节点规则
sudo scp hybrid01:/etc/sysconfig/iptables /etc/sysconfig/iptables
### 重启 iptables
sudo systemctl restart iptables
### 查看 iptables 规则
sudo iptables -nvL
