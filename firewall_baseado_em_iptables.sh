#!/bin/bash
iniciar(){
# Compartilha a conexão
modprobe ip_conntrack
modprobe ip_conntrack_ftp
modprobe iptable_nat
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1400:1536 \
-j TCPMSS --clamp-mss-to-pmtu

echo "Compartilhamento ativado"

# Proxy

#iptables -t nat -A PREROUTING -i 192.168.0.1 -p tcp -s 192.168.0.197 -m multiport --dport 80,443 -j ACCEPT

iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3128

echo "Proxy transparente ativado"
# Regras do firewall
iptables -A INPUT -s 192.168.0.0/255.255.255.0 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT


iptables -A OUTPUT -p tcp --dport 21 -j ACCEPT
iptables -A INPUT -p tcp --dport 21 -j ACCEPT
iptables -A INPUT -p tcp --sport 20 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 20 -j ACCEPT
iptables -A INPUT -p tcp --sport 1024: --dport 1024: -j ACCEPT
iptables -A OUTPUT -p tcp --sport 1024: --dport 1024: -j ACCEPT


iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 10000 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP


echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp --syn -j DROP

# regras ntop 
#iptables -A INPUT -p TCP -s 127.0.0.1/8 --dport 3000 ACCEPT 
#iptables -A INPUT -p TCP -s 192.168.0.0/24 --dport 3000 ACCEPT
#refeitando ntop conexãfora
#iptables -A INPUT -p TCP -s 0/0 --dport 3000 REJECT

#porta 443
iptables -A FORWARD -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT

#cat  rh
iptables -A INPUT -p tcp --dport 5017 -j ACCEPT
iptables -A INPUT -p udp --dport 5017 -j ACCEPT

# TS SERVIDOR
# Redirecionamento ao TS
iptables -A INPUT -p tcp --destination-port 3389 -j ACCEPT
iptables -A INPUT -p udp --destination-port 3389 -j ACCEPT
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 3389 -j DNAT --to-dest 192.168.0.254:3389
iptables -A FORWARD -p tcp -i eth1 --dport 3389 -d 192.168.0.254 -j ACCEPT
iptables -t nat -A PREROUTING -i eth0 -p udp --dport 3389 -j DNAT --to-dest 192.168.0.254:3389
iptables -A FORWARD -p udp -i eth1 --dport 3389 -d 192.168.0.254 -j ACCEPT


# Regras para Outlook
# STMP 
iptables -t filter -A INPUT -i eth0 -p tcp --dport 25 -j ACCEPT 
# POP3 
iptables -t filter -A INPUT -i eth0 -p tcp --dport 110 -j ACCEPT 
# DNS Internet 
iptables -t filter -A INPUT -i eth0 -p udp --dport 53 -j ACCEPT

# Regra para ValidaPR
iptables -t filter -A INPUT -i eth0 -p tcp --dport 8017 -j ACCEPT

# Regra para programa rh
iptables -t filter -A INPUT -i eth0 -p tcp --dport 5017 -j ACCEPT

#regras msn bloqueio
iptables -A FORWARD -s 192.168.0.0/24 -p tcp --dport 1863 -j REJECT
iptables -A FORWARD -s 192.168.0.0/24 -d loginnet.passport.com -j REJECT


}
parar(){
iptables -F
iptables -t nat -F
echo "Regras do firewall e compartilhamento desativados"
}
case "$1" in
"start") iniciar ;;
"stop") parar ;;
"restart") parar; iniciar ;;
*) echo "Use os parâmetros start ou stop"
esac

