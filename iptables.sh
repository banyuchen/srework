sudo cp /etc/sysconfig/iptables /home/sa_cluster/iptables.bak-20250303
sudo cat -n /etc/sysconfig/iptables

sudo vim /etc/sysconfig/iptables

-A INPUT -p tcp -m multiport --dports 2379,2380 -m comment --comment "禁止外部访问etcd相关的端口" -j DROP


sudo systemctl restart iptables
sudo iptables -nvL



for i in meta0{1..3};do echo $i && ssh $i sudo cp /etc/sysconfig/iptables /home/sa_cluster/iptables.bak-20250303; done
for i in data{01..10};do echo $i && ssh $i sudo cp /etc/sysconfig/iptables /home/sa_cluster/iptables.bak-20250303; done



