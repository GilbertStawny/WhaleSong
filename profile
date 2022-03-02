echo -e "\n"; echo -e "\e[33m$(cat /root/motd)\e[39m" | egrep -v ^$
export PS1="{\e[31m\u\e[39m}@\e[94m\t\e[39m> \[$(tput sgr0)\]"
