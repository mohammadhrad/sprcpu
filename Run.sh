#!/usr/bin/env bash
	
figlet Running Bots !

RED='\033[0;31m'

NC='\033[0m'

CYAN='\033[0;36m'

sleep 0.5

killall screen

screen -d -m ./1.sh
screen -d -m ./2.sh
screen -d -m ./3.sh

    echo -e "${CYAN} !!! F80 is Running Now !!! ${NC}"

screen -d -m ./4.sh
screen -d -m ./5.sh
screen -d -m ./6.sh
    echo -e "${CYAN} !!! Api Bots Are Running Now !!! ${NC}"


read -p "cash ?? (Y/N): "
if [ "$REPLY" != "Y" ]; then
    echo -e "${RED}Finish ${NC}"
exit 1
else
	echo -e "${RED}Cleaning Telegram-Cli Catsh !\n${NC}"
	for i in SprCpu* SeenBot-* Silent294190721; do
	rm -rf /root/.telegram-cli/"$i"/data/animation/*.*
	rm -rf /root/.telegram-cli/"$i"/data/audio/*.*
	rm -rf /root/.telegram-cli/"$i"/data/document/*.*
	rm -rf /root/.telegram-cli/"$i"/data/encrypted/*.*
	rm -rf /root/.telegram-cli/"$i"/data/photo/*.*
	rm -rf /root/.telegram-cli/"$i"/data/profile_photo/*.*
	rm -rf /root/.telegram-cli/"$i"/data/sticker/*.*
	rm -rf /root/.telegram-cli/"$i"/data/temp/*.*
	rm -rf /root/.telegram-cli/"$i"/data/thumb/*.*
	rm -rf /root/.telegram-cli/"$i"/data/video/*.*
	rm  /root/.telegram-cli/"$i"/data/voice/*.*
	done
 echo -e "${CYAN}Catch Cleaned !\n${NC}"
fi
