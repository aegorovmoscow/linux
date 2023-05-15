#!/bin/bash

echo "what do you like to do? "
echo ""
echo "1: open INPUT"
echo "2: open FORWARD"
echo "3: open OUTPUT"
echo "4: close INPUT"
echo "5: close FORWARD"
echo "6: close OUTPUT"
echo "7: set up PREROUTING"
echo "8: set up POSTROUTING"
echo "9: list fw.sh"
echo "10 set up DEFAULT fw.sh and install iptables with conntrack"
echo "IT IS RECOMMENDED TO EXECUTE STEP 10 TO START USING THE SCRIPT!"
echo ""

echo "You need chose a number"
echo ""
read action

if [[ $action == "1" ]] || [[ $action == "2" ]] || [[ $action == "3" ]] || [[ $action == "4" ]] || [[ $action == "5" ]] ||  
   [[ $action == "6" ]] || [[ $action == "7" ]] || [[ $action == "8" ]] || [[ $action == "9" ]] || [[ $action == "10" ]]; then

		case $action in
			1 )
				echo "which port do you want open?(number)"
				echo ""
				read port
				if  [[ $port -ge 1 ]] && [[ $port -le 65535 ]] ; then
					var_port="$port"
				elif [[ $port -lt 0 ]]; then
					echo " Port entered incorrectly "
						exit 0
				else
					echo "Exceeds the port value"
						exit 0
				fi
				echo "which protocol will be used?(tcp(1)/udp(2))"
				echo ""
				read protocol
					if  [[ $protocol -eq 1 ]]; then
						var_protocol="tcp"
					elif [[ $protocol -eq 2 ]]; then
						var_protocol="udp"
					else
						echo "you must print 1 or 2, try again.. "
						exit 0
					fi
				string_INPUT="iptables -A INPUT -p $var_protocol --dport $var_port -j DROP"
				string_INPUT_open="iptables -A INPUT -p $var_protocol --dport $var_port -j ACCEPT"
				if grep -Fxq "$string_INPUT" /root/fw.sh; then
						echo "There is rule (iptables -A INPUT -p $var_protocol --dport $var_port -j DROP) in fw.sh "
						echo "Do you want modify rule? (close - press 1) "
						read INPUT_modify
							if [[ $INPUT_modify -eq 1 ]]; then
								echo "sed -i 's/iptables -A INPUT -p "$var_protocol" --dport "$var_port" -j DROP/iptables -A INPUT -p "$var_protocol" --dport "$var_port" -j ACCEPT/g' /root/fw.sh" |bash
								echo "rule has been modifyed"
									exit 0
									else
									echo "you can press only 1"
									exit 0
							fi
				fi
				if grep -Fxq "$string_INPUT_open" /root/fw.sh; then
						echo "this rule already exist"
						exit 0
				fi
				echo "iptables -A INPUT -p $var_protocol --dport $var_port -j ACCEPT" >> /root/fw.sh
				echo "port $var_port with protocol $var_protocol were add in table INPUT"
				echo "";;
			2 )
				echo "which port do you want open?(number)"
				echo ""
				read port
				if  [[ $port -ge 1 ]] && [[ $port -le 65535 ]] ; then
					var_port="$port"
				elif [[ $port -lt 0 ]]; then
					echo " Port entered incorrectly "
						exit 0
				else
					echo "Exceeds the port value"
						exit 0
				fi
				echo "which protocol will be used?(tcp(1)/udp(2))"
				echo ""
				read protocol
					if  [[ $protocol -eq 1 ]]; then
						var_protocol="tcp"
					elif [[ $protocol -eq 2 ]]; then
						var_protocol="udp"
					else
						echo "you must print 1 or 2, try again.. "
						exit 0
					fi
				string_FORWARD="iptables -A FORWARD -p $var_protocol --dport $var_port -j DROP"
				string_FORWARD_open="iptables -A FORWARD -p $var_protocol --dport $var_port -j ACCEPT"
				if grep -Fxq "$string_FORWARD" /root/fw.sh; then
						echo "There is rule (iptables -A FORWARD -p $var_protocol --dport $var_port -j DROP) in fw.sh "
						echo "Do you want modify rule? (close - press 1) "
						read INPUT_modify
							if [[ $INPUT_modify -eq 1 ]]; then
								echo "sed -i 's/iptables -A FORWARD -p "$var_protocol" --dport "$var_port" -j DROP/iptables -A FORWARD -p "$var_protocol" --dport "$var_port" -j ACCEPT/g' /root/fw.sh" |bash
								echo "rule has been modifyed"
									exit 0
									else
									echo "you can press only 1"
									exit 0
							fi
				fi
				if grep -Fxq "$string_FORWARD_open" /root/fw.sh; then
						echo "this rule already exist"
						exit 0
				fi
				echo "iptables -A FORWARD -p $var_protocol --dport $var_port -j ACCEPT" >> /root/fw.sh
				echo "port $var_port with protocol $var_protocol were add in table FORWARD"
				echo "";;
			3 )
				echo "which port do you want open?(number)"
				echo ""
				read port
				if  [[ $port -ge 1 ]] && [[ $port -le 65535 ]] ; then
					var_port="$port"
				elif [[ $port -lt 0 ]]; then
					echo " Port entered incorrectly "
						exit 0
				else
					echo "Exceeds the port value"
						exit 0
				fi
				echo "which protocol will be used?(tcp(1)/udp(2))"
				echo ""
				read protocol
					if  [[ $protocol -eq 1 ]]; then
						var_protocol="tcp"
					elif [[ $protocol -eq 2 ]]; then
						var_protocol="udp"
					else
						echo "you must print 1 or 2, try again.. "
						exit 0
					fi
				string_OUTPUT="iptables -A OUTPUT -p $var_protocol --dport $var_port -j DROP"
				string_OUTPUT_open="iptables -A OUTPUT -p $var_protocol --dport $var_port -j ACCEPT"
				if grep -Fxq "$string_OUTPUT" /root/fw.sh; then
						echo "There is rule (iptables -A OUTPUT -p $var_protocol --dport $var_port -j DROP) in fw.sh "
						echo "Do you want modify rule? (close - press 1) "
						read INPUT_modify
							if [[ $INPUT_modify -eq 1 ]]; then
								echo "sed -i 's/iptables -A OUTPUT -p "$var_protocol" --dport "$var_port" -j DROP/iptables -A OUTPUT -p "$var_protocol" --dport "$var_port" -j ACCEPT/g' /root/fw.sh" |bash
								echo "rule has been modifyed"
									exit 0
									else
									echo "you can press only 1"
									exit 0
							fi
				fi
				if grep -Fxq "$string_OUTPUT_open" /root/fw.sh; then
						echo "this rule already exist"
						exit 0
				fi
				echo "iptables -A OUTPUT -p $var_protocol --dport $var_port -j ACCEPT" >> /root/fw.sh
				echo "port $var_port with protocol $var_protocol were add in table OUTPUT"
				echo "";;
			4 )
				echo "which port do you want close?(number)"
				echo ""
				read port
				if  [[ $port -ge 1 ]] && [[ $port -le 65535 ]] ; then
					var_port="$port"
				elif [[ $port -lt 0 ]]; then
					echo " Port entered incorrectly "
						exit 0
				else
					echo "Exceeds the port value"
						exit 0
				fi
				echo "which protocol will be used?(tcp(1)/udp(2))"
				echo ""
				read protocol
					if  [[ $protocol -eq 1 ]]; then
						var_protocol="tcp"
					elif [[ $protocol -eq 2 ]]; then
						var_protocol="udp"
					else
						echo "you must print 1 or 2, try again.. "
						exit 0
					fi
				string_INPUT="iptables -A INPUT -p $var_protocol --dport $var_port -j ACCEPT"
				string_INPUT_close="iptables -A INPUT -p $var_protocol --dport $var_port -j DROP"
				if grep -Fxq "$string_INPUT" /root/fw.sh; then
						echo "There is rule (iptables -A INPUT -p $var_protocol --dport $var_port -j ACCEPT) in fw.sh "
						echo "Do you want modify rule? (close - press 1) "
						read INPUT_modify
							if [[ $INPUT_modify -eq 1 ]]; then
								echo "sed -i 's/iptables -A INPUT -p "$var_protocol" --dport "$var_port" -j ACCEPT/iptables -A INPUT -p "$var_protocol" --dport "$var_port" -j DROP/g' /root/fw.sh" |bash
								echo "rule has been modifyed"
									exit 0
									else
									echo "you can press only 1"
									exit 0
							fi
				fi
				if grep -Fxq "$string_INPUT_close" /root/fw.sh; then
						echo "this rule already exist"
						exit 0
				fi	
				echo "iptables -A INPUT -p $var_protocol --dport $var_port -j DROP" >> /root/fw.sh
				echo "port $var_port with protocol $var_protocol has been closed in table INPUT"
				echo "";;
			5 ) 
				echo "which port do you want close?(number)"
				echo ""
				read port
				if  [[ $port -ge 1 ]] && [[ $port -le 65535 ]] ; then
					var_port="$port"
				elif [[ $port -lt 0 ]]; then
					echo " Port entered incorrectly "
						exit 0
				else
					echo "Exceeds the port value"
						exit 0
				fi
				echo "which protocol will be used?(tcp(1)/udp(2))"
				echo ""
				read protocol
					if  [[ $protocol -eq 1 ]]; then
						var_protocol="tcp"
					elif [[ $protocol -eq 2 ]]; then
						var_protocol="udp"
					else
						echo "you must print 1 or 2, try again.. "
						exit 0
					fi
				string_FORWARD="iptables -A FORWARD -p $var_protocol --dport $var_port -j ACCEPT"
				string_FORWARD_close="iptables -A FORWARD -p $var_protocol --dport $var_port -j DROP"
				if grep -Fxq "$string_FORWARD" /root/fw.sh; then
						echo "There is rule (iptables -A FORWARD -p $var_protocol --dport $var_port -j ACCEPT) in fw.sh "
						echo "Do you want modify rule? (close - press 1) "
						read INPUT_modify
							if [[ $INPUT_modify -eq 1 ]]; then
								echo "sed -i 's/iptables -A FORWARD -p "$var_protocol" --dport "$var_port" -j ACCEPT/iptables -A FORWARD -p "$var_protocol" --dport "$var_port" -j DROP/g' /root/fw.sh" |bash
								echo "rule has been modifyed"
									exit 0
									else
									echo "you can press only 1"
									exit 0
							fi
				fi
				if grep -Fxq "$string_FORWARD_close" /root/fw.sh; then
						echo "this rule already exist"
						exit 0
				fi	
				echo "iptables -A FORWARD -p $var_protocol --dport $var_port -j DROP" >> /root/fw.sh
				echo "port $var_port with protocol $var_protocol has been closed in table FORWARD"
				echo "";;
			6 ) 
				echo "which port do you want close?(number)"
				echo ""
				read port
				if  [[ $port -ge 1 ]] && [[ $port -le 65535 ]] ; then
					var_port="$port"
				elif [[ $port -lt 0 ]]; then
					echo " Port entered incorrectly "
						exit 0
				else
					echo "Exceeds the port value"
						exit 0
				fi
				echo "which protocol will be used?(tcp(1)/udp(2))"
				echo ""
				read protocol
					if  [[ $protocol -eq 1 ]]; then
						var_protocol="tcp"
					elif [[ $protocol -eq 2 ]]; then
						var_protocol="udp"
					else
						echo "you must print 1 or 2, try again.. "
						exit 0
					fi
				string_OUTPUT="iptables -A OUTPUT -p $var_protocol --dport $var_port -j ACCEPT"
				string_OUTPUT_close="iptables -A OUTPUT -p $var_protocol --dport $var_port -j DROP"
				if grep -Fxq "$string_OUTPUT" /root/fw.sh; then
						echo "There is rule (iptables -A OUTPUT -p $var_protocol --dport $var_port -j ACCEPT) in fw.sh "
						echo "Do you want modify rule? (close - press 1) "
						read INPUT_modify
							if [[ $INPUT_modify -eq 1 ]]; then
								echo "sed -i 's/iptables -A OUTPUT -p "$var_protocol" --dport "$var_port" -j ACCEPT/iptables -A OUTPUT -p "$var_protocol" --dport "$var_port" -j DROP/g' /root/fw.sh" |bash
								echo "rule has been modifyed"
									exit 0
									else
									echo "you can press only 1"
									exit 0
							fi
				fi
				if grep -Fxq "$string_OUTPUT_close" /root/fw.sh; then
						echo "this rule already exist"
						exit 0
				fi	
				echo "iptables -A OUTPUT -p $var_protocol --dport $var_port -j DROP" >> /root/fw.sh
				echo "port $var_port with protocol $var_protocol has been closed in table OUTPUT"
				echo "";;
			7 )
				echo "Enter interface which use for penetrate"
				read interface
				echo "Which protocol will be used?(tcp(1)/udp(2))"
				echo ""
				read penetrate_protocol
					if  [[ $penetrate_protocol -eq 1 ]]; then
						var_protocol="tcp"
					elif [[ $penetrate_protocol -eq 2 ]]; then
						var_protocol="udp"
					else
						echo "you must print 1 or 2, try again.. "
						exit 0
					fi
				echo "Enter wan machine's port"
				read wan_port
				if  [[ $wan_port -ge 1 ]] && [[ $wan_port -le 65535 ]] ; then
					var_port_wan="$wam_port"
				elif [[ $wan_port -lt 0 ]]; then
					echo " Port entered incorrectly "
						exit 0
				else
					echo "Exceeds the port value"
						exit 0
				fi
				echo "What host do you need to get to? (print ip address)"
				read ip_to_host
				echo "Enter local machine's port"
				read lan_port
				if  [[ $lan_port -ge 1 ]] && [[ $lan_port -le 65535 ]] ; then
					var_port_lan="$lan_port"
				elif [[ $lan_port -lt 0 ]]; then
					echo " Port entered incorrectly "
						exit 0
				else
					echo "Exceeds the port value"
						exit 0
				fi
				echo "iptables -t nat -A PREROUTING -i $interface -p $var_protocol -m $var_protocol --dport $wan_port -j DNAT --to-destination $ip_to_host:$lan_port" >> /root/fw.sh
				echo "port $wan_port has been penetrated to host $ip_to_host port $lan_port with protocol $var_protocol from interface $interface"
				echo "";;
			8 )	
				echo "Do you want use SNAT(1) or MASQUERADE(2)"
				echo "Enter 1 or 2 to chose"
				read chose
				if [[ $chose -eq 1 ]]; then
					echo "Enter wan interface"
					read wan_interface
					echo "Enter your local network"
					read local_net
					echo "Enter white ip address"
					read white_ip
					echo "iptables -t nat -A POSTROUTING -o $wan_interface -s $local_net -j SNAT --to-source $white_ip" >> /root/fw.sh
					echo "SNAT has been set up"
				elif [[ $chose -eq 2 ]]; then
					echo "Enter wan interface"
					read wan_interface
					echo "iptables -t nat -A POSTROUTING -o $wan_interface -j MASQUERADE" >> /root/fw.sh
					echo "MASQUERADE has been set up"
				else
					echo "you must print 1 or 2, try again.. "
					exit 0
				fi
				echo "";;
			9 )
				echo "cat /root/fw.sh" |bash
				echo "";;
			10 )
				touch /root/fw.sh
				echo "PLEASE WAIT FOR 30 SECOND, NOW CHECKING INSTALLED SOFT"
				cat > /root/fw.sh <<EOF
#!/bin/bash
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F

# DEFAULT POLICY ===============================
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
#===============================================

# ENABLE SSH =====================================
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#=================================================

# STATE RULES ==================================
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A FORWARD -m state --state INVALID -j DROP
iptables -A INPUT -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
#===============================================


# LOCAL HOST ====================================
iptables -A INPUT -p icmp -j ACCEPT
iptables -A FORWARD -p icmp -j ACCEPT
#================================================


# ICMP ENABLED ==================================
iptables -A INPUT -i lo -j ACCEPT
#================================================

# ENABLE DNS  ===================================
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp -m udp --sport 53 --dport 1024:65535 -j ACCEPT
iptables -A FORWARD -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -p tcp --dport 53 -j ACCEPT
iptables -A FORWARD -p udp -m udp --sport 53 --dport 1024:65535 -j ACCEPT
#===============================================


EOF
				chmod +x /root/fw.sh
				apt-get install iptables >/dev/null && apt-get install conntrack >/dev/null
				echo "iptables and conntrack installed"
				conntrack -F >/dev/null
				echo "fw is default"
				echo "Do you want to apply default config?"
				echo "yes(1)/no(2)/show fw.sh(3)"
				read apply_fw
					if [[ $apply_fw -eq 1 ]]; then
						sh /root/fw.sh
						echo "default config fw.sh has been appleyd "
						elif [[ $apply_fw -eq 2 ]]; then
						echo "default config fw.sh was downloaded, but not appled "
						elif [[ apply_fw -eq 3 ]]; then
						cat /root/fw.sh
						else 
							echo "you must print 1 or 2, try again.. "
							exit 0
					fi
				echo "";;
		esac
	else
		echo "you can print only 1 or 2 or 3 or 4 or 5 or 6 or 7 or 9 or 10"
fi

