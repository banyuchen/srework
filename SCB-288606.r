[PROD Orz sa_cluster@gdsanode01 ~]$ sudo iptables -nvL
Chain INPUT (policy ACCEPT 286G packets, 169T bytes)
 pkts bytes target     prot opt in     out     source               destination         
 7196   11M ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            state NEW,ESTABLISHED tcp dpt:4118
    0     0 ACCEPT     udp  --  virbr0 *       0.0.0.0/0            0.0.0.0/0            udp dpt:53
    0     0 ACCEPT     tcp  --  virbr0 *       0.0.0.0/0            0.0.0.0/0            tcp dpt:53
    0     0 ACCEPT     udp  --  virbr0 *       0.0.0.0/0            0.0.0.0/0            udp dpt:67
    0     0 ACCEPT     tcp  --  virbr0 *       0.0.0.0/0            0.0.0.0/0            tcp dpt:67
 286G  169T SENSORSDATA_RULE  all  --  *      *       0.0.0.0/0            0.0.0.0/0           

Chain FORWARD (policy ACCEPT 780K packets, 817M bytes)
 pkts bytes target     prot opt in     out     source               destination         
 780K  817M DOCKER-USER  all  --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 ACCEPT     all  --  *      virbr0  0.0.0.0/0            192.168.122.0/24     ctstate RELATED,ESTABLISHED
    0     0 ACCEPT     all  --  virbr0 *       192.168.122.0/24     0.0.0.0/0           
    0     0 ACCEPT     all  --  virbr0 virbr0  0.0.0.0/0            0.0.0.0/0           
    0     0 REJECT     all  --  *      virbr0  0.0.0.0/0            0.0.0.0/0            reject-with icmp-port-unreachable
    0     0 REJECT     all  --  virbr0 *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-port-unreachable

Chain OUTPUT (policy ACCEPT 287G packets, 139T bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 ACCEPT     udp  --  *      virbr0  0.0.0.0/0            0.0.0.0/0            udp dpt:68

Chain DOCKER (0 references)
 pkts bytes target     prot opt in     out     source               destination         

Chain DOCKER-ISOLATION-STAGE-1 (0 references)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 RETURN     all  --  *      *       0.0.0.0/0            0.0.0.0/0           

Chain DOCKER-ISOLATION-STAGE-2 (0 references)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 RETURN     all  --  *      *       0.0.0.0/0            0.0.0.0/0           
Chain DOCKER-USER (1 references)
 pkts bytes target     prot opt in     out     source               destination         
 780K  817M RETURN     all  --  *      *       0.0.0.0/0            0.0.0.0/0           

Chain SENSORSDATA_RULE (1 references)
 pkts bytes target     prot opt in     out     source               destination         
 255M   23G RETURN     icmp --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 RETURN     all  --  *      *       10.0.0.0/8           0.0.0.0/0           
    0     0 RETURN     all  --  *      *       100.0.0.0/8          0.0.0.0/0           
 464M   40G RETURN     all  --  *      *       127.0.0.0/8          0.0.0.0/0           
 285G  169T RETURN     all  --  *      *       172.0.0.0/8          0.0.0.0/0           
14320 1453K RETURN     all  --  *      *       192.168.0.0/16       0.0.0.0/0           
    0     0 RETURN     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:22
    0     0 RETURN     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:8106
    0     0 RETURN     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:8107
    0     0 RETURN     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:8202
    0     0 RETURN     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:8203
    0     0 RETURN     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:8822
    0     0 RETURN     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:8176
    0     0 RETURN     udp  --  *      *       0.0.0.0/0            0.0.0.0/0            udp spt:53
    0     0 RETURN     udp  --  *      *       0.0.0.0/0            0.0.0.0/0            udp spt:123
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x17/0x02
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0  

[PROD Orz sa_cluster@gdsanode02 ~]$ sudo iptables -nvL
Chain INPUT (policy ACCEPT 209G packets, 167T bytes)
 pkts bytes target     prot opt in     out     source               destination         
12818   16M ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            state NEW,ESTABLISHED tcp dpt:4118

Chain FORWARD (policy ACCEPT 380K packets, 398M bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 205G packets, 205T bytes)
 pkts bytes target     prot opt in     out     source               destination    


[PROD Orz sa_cluster@gdsanode03 ~]$ sudo iptables -nvL
Chain INPUT (policy ACCEPT 3325M packets, 2678G bytes)
 pkts bytes target     prot opt in     out     source               destination         
  176  280K ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:4118

Chain FORWARD (policy ACCEPT 153K packets, 160M bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 3356M packets, 1795G bytes)
 pkts bytes target     prot opt in     out     source               destination  


