#!/bin/bash -x
apt update
apt install openvpn easy-rsa -y

FILE=~/easy-rsa/
if [ -d "$FILE" ]; then
    echo "file exist"
else  mkdir "$FILE"
fi
chown root ~/easy-rsa
chmod 700 ~/easy-rsa

LINK=~/easy-rsa/easyrsa
if [ -L "$LINK" ]; then
	echo "link exist"
else ln -s /usr/share/easy-rsa/* ~/easy-rsa/
fi



echo 'set_var EASYRSA_ALGO "ec"' > ~/easy-rsa/vars
echo 'set_var EASYRSA_DIGEST "sha512"'>> ~/easy-rsa/vars
cd /root/easy-rsa/
echo "yes" | ./easyrsa init-pki 

echo "yes" | ./easyrsa gen-req server nopass 
cp /root/easy-rsa/pki/private/server.key /etc/openvpn/server/
echo "yes" | ./easyrsa build-ca nopass 
echo "yes" | ./easyrsa sign-req server server 
cp /root/easy-rsa/pki/issued/server.crt /etc/openvpn/server
cp /root/easy-rsa/pki/ca.crt /etc/openvpn/server

cd ~/easy-rsa
openvpn --genkey --secret ta.key
cp ta.key /etc/openvpn/server
mkdir -p ~/client-configs/keys
chmod -R 700 ~/client-configs
#cd ~/easy-rsa
#echo "введите имя пользователя"
#read username
#./easyrsa gen-req $username nopass
#cp /root/easy-rsa/pki/private/$username.key ~/client-configs/keys/

#echo "yes" | ./easyrsa sign-req client $username
#cp /root/easy-rsa/pki/issued/$username.crt ~/client-configs/keys/
cp ~/easy-rsa/ta.key ~/client-configs/keys/

cp /etc/openvpn/server/ca.crt ~/client-configs/keys/

chown root:root ~/client-configs/keys/*
cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf /etc/openvpn/server/
cat <<EOF > /etc/openvpn/server/server.conf
port 1194
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key
dh none
topology subnet
server 172.23.11.0 255.255.255.0
ifconfig-pool-persist /var/log/openvpn/ipp.txt
push "route 10.0.0.0 255.0.0.0"
keepalive 10 120
tls-crypt ta.key
cipher AES-256-GCM
auth SHA256
persist-key
persist-tun
status /var/log/openvpn/openvpn-status.log
verb 3
explicit-exit-notify 1
EOF
stringforward="net.ipv4.ip_forward=1"
if grep -Fxq "$stringforward"  /etc/sysctl.conf
	then echo "fORWARD=1 exists "
else echo "$stringforward" >> /etc/sysctl.conf
fi
sysctl -p 
systemctl -f enable openvpn-server@server.service
systemctl start openvpn-server@server.service
systemctl status openvpn-server@server.service | cat 


mkdir -p ~/client-configs/files

cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf ~/client-configs/base.conf

#cat <<EOF > ~/client-configs/base.conf
#client
#dev tun
#proto udp
#remote your_server_ip 1194
#resolv-retry infinite
#persist-key
#persist-tun
#remote-cert-tls server
#cipher AES-256-GCM
#auth SHA256
#key-direction 1
#verb 3
#mute 20
#EOF






