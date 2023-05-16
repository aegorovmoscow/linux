#!/bin/bash

echo "Now we are installing strongswan"
echo "Wait about minute .."
apt install strongswan -y >/dev/null

echo "Settting file ipsec.conf"
cat > /etc/ipsec.conf <<EOF
conn rw-base
    fragmentation=yes
    dpdaction=clear 
    dpdtimeout=90s
    dpddelay=30s

conn l2tp-vpn
    also=rw-base
    ike=aes128-sha256-modp3072
    esp=aes128-sha256-modp3072
    leftsubnet=%dynamic[/1701]
    rightsubnet=%dynamic
    leftauth=psk
    rightauth=psk
    type=transport
    auto=add
EOF

echo "Settting file ipsec.secrets"
cat > /etc/ipsec.secrets <<EOF
%any %any : PSK "mySharedKey"
EOF

systemctl restart strongswan-starter.service >/dev/null

apt install xl2tpd -y >/dev/null

echo "Settting file xl2tpd.conf"
cat > /etc/xl2tpd/xl2tpd.conf <<EOF
[global]
port = 1701
auth file = /etc/ppp/chap-secrets
access control = no
ipsec saref = yes
force userspace = yes

[lns default]
exclusive = no
ip range = 192.168.97.10-192.168.97.200
hidden bit = no
local ip = 192.168.97.1
length bit = yes
require authentication = yes
name = l2tp-vpn
pppoptfile = /etc/ppp/options.xl2tpd
flow bit = yes
EOF

cd /etc/ppp

cp options options.xl2tpd

echo "Settting file options.xl2tpd"
cat > /etc/ppp/options.xl2tpd <<EOF
asyncmap 0
auth
crtscts
lock
hide-password
modem
mtu 1460
lcp-echo-interval 30
lcp-echo-failure 4
noipx
refuse-pap
refuse-chap
refuse-mschap
require-mschap-v2
multilink
mppe-stateful
EOF

echo "restarting xl2tpd"
systemctl restart xl2tpd

echo "Settting file chap-secrets"
cat > /etc/ppp/chap-secrets <<EOF
aegorov   l2tp-vpn   123   *
EOF