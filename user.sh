#!/bin/bash
cd ~/easy-rsa
echo "введите имя пользователя"
read username
./easyrsa gen-req $username nopass
cp /root/easy-rsa/pki/private/$username.key ~/client-configs/keys/

echo "yes" | ./easyrsa sign-req client $username
cp /root/easy-rsa/pki/issued/$username.crt ~/client-configs/keys/

cat <<EOF > ~/client-configs/base.conf
client
dev tun
proto udp
remote     1194
resolv-retry infinite
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-GCM
auth SHA256
key-direction 1
verb 3
mute 20
EOF

KEY_DIR=~/client-configs/keys
OUTPUT_DIR=~/client-configs/files
BASE_CONFIG=~/client-configs/base.conf

cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${KEY_DIR}/${username}.crt \
    <(echo -e '</cert>\n<key>') \
    ${KEY_DIR}/${username}.key \
    <(echo -e '</key>\n<tls-crypt>') \
    ${KEY_DIR}/ta.key \
    <(echo -e '</tls-crypt>') \
    > ${OUTPUT_DIR}/${username}.ovpn
