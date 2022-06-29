# Server IPTables' rules list  
    vagrant@hw7-server:~$ sudo iptables --list-rules  
    -P INPUT ACCEPT  
    -P FORWARD ACCEPT  
    -P OUTPUT ACCEPT  
    -A INPUT -p icmp -m icmp --icmp-type 8 -j REJECT --reject-with icmp-port-unreachable  
    vagrant@hw7-server:~$

## Client SSH-rules
Watch appropriate file in current direction