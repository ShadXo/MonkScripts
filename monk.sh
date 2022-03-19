#!/bin/bash

##
##
##

RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
BROWN='\033[0;34m'
NC='\033[0m' # No Color


## Black        0;30     Dark Gray     1;30
## Red          0;31     Light Red     1;31
## Green        0;32     Light Green   1;32
## Brown/Orange 0;33     Yellow        1;33
## Blue         0;34     Light Blue    1;34
## Purple       0;35     Light Purple  1;35
## Cyan         0;36     Light Cyan    1;36
## Light Gray   0;37     White         1;37

echo && echo
echo "*******************************v1.3.0**"
echo "***************MONK COIN***************"
echo "***************MAIN MENU***************"
echo "*******http://www.monkey.vision/*******"
echo ""
echo -e "${RED}1. LIST ALL NODES" # -> MONK_LIST.SH" # OK
echo -e "2. CHECK NODES SYNC" #  -> MONK_CHECK_SYNC.SH" # OK
echo -e "3. RESYNC NODES THAT ARE OUT OF SYNC" #  -> MONK_CHECK_RESYNC_ALL.SH" # OK
echo -e "4. START NODES" #  -> MONK_START.SH" # OK
echo -e "5. STOP NODES" #  -> MONK_STOP.SH" # OK
echo -e "6. INSTALL NEW NODES" #  -> MONK_SETUPV3.SH" # OK
echo -e "7. CHECK NODES STATUS" #  -> MONK_CHECK_STATUS.SH" # OK
echo -e "8. RESYNC SPECIFIC NODE (useful if node is stopped)" # -> monk_resync.sh # OK
echo -e "9. REMOVE SPECIFIC NODE" # -> MONK_REMOVE.sh # OK
echo -e "10. UPDATE NODE WALLET" # -> UPDATE_WALLET.sh # OK
echo -e "11. CALCULATE FREE MEMORY AND CPU FOR NEW NODES" # -> memory_cpu_sysinfo.sh # OK
echo -e "${YELLOW}12. MONKEY LOGO${RED}" # MONKEY LOGO
echo -e "0. EXIT${NC}" # OK
echo "---------------------------------------"
echo "choose option number:"
read OPTION
# echo ${OPTION}
ALIAS=""

clear

if [[ ${OPTION} == "1" ]] ; then
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monk_list.sh -O monk_list.sh > /dev/null 2>&1
  chmod 777 monk_list.sh
  dos2unix monk_list.sh > /dev/null 2>&1
  /bin/bash ./monk_list.sh
elif [[ ${OPTION} == "2" ]] ; then
  echo -e "${RED}Which node do you want to check if synced? Enter alias (if empty then will check all)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monk_check_sync.sh -O monk_check_sync.sh > /dev/null 2>&1
  chmod 777 monk_check_sync.sh
  dos2unix monk_check_sync.sh > /dev/null 2>&1
  /bin/bash ./monk_check_sync.sh $ALIAS
elif [[ ${OPTION} == "3" ]] ; then
  echo -e "${RED}Which node do you want to check sync and resync? Enter alias (if empty then will check all)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monk_check_resync_all.sh -O monk_check_resync_all.sh > /dev/null 2>&1
  chmod 777 monk_check_resync_all.sh
  dos2unix monk_check_resync_all.sh > /dev/null 2>&1
  /bin/bash ./monk_check_resync_all.sh $ALIAS
elif [[ ${OPTION} == "4" ]] ; then
  echo -e "${RED}Which node do you want to start? Enter alias (if empty then will check all)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monk_start.sh -O monk_start.sh > /dev/null 2>&1
  chmod 777 monk_start.sh
  dos2unix monk_start.sh > /dev/null 2>&1
  /bin/bash ./monk_start.sh $ALIAS
elif [[ ${OPTION} == "5" ]] ; then
  echo -e "${RED}Which node do you want to stop? Enter alias (if empty then will check all)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monk_stop.sh -O monk_stop.sh > /dev/null 2>&1
  chmod 777 monk_stop.sh
  dos2unix monk_stop.sh > /dev/null 2>&1
  /bin/bash ./monk_stop.sh $ALIAS
elif [[ ${OPTION} == "6" ]] ; then
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monk_setupv3.sh -O monk_setupv3.sh > /dev/null 2>&1
  chmod 777 monk_setupv3.sh
  dos2unix monk_setupv3.sh > /dev/null 2>&1
  /bin/bash ./monk_setupv3.sh
elif [[ ${OPTION} == "7" ]] ; then
  echo -e "${RED}For which node do you want to check masternode status? Enter alias (if empty then will check all)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monk_check_status.sh -O monk_check_status.sh > /dev/null 2>&1
  chmod 777 monk_check_status.sh
  dos2unix monk_check_status.sh > /dev/null 2>&1
  /bin/bash ./monk_check_status.sh $ALIAS
elif [[ ${OPTION} == "8" ]] ; then
  echo -e "${RED}For which node do you want to check masternode status? Enter alias (mandatory!)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monk_resync.sh -O monk_resync.sh > /dev/null 2>&1
  chmod 777 monk_resync.sh
  dos2unix monk_resync.sh > /dev/null 2>&1
  /bin/bash ./monk_resync.sh $ALIAS
elif [[ ${OPTION} == "9" ]] ; then
  echo -e "${RED}Which node do you want to remove? Enter alias (mandatory!)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monk_remove.sh -O monk_remove.sh > /dev/null 2>&1
  chmod 777 monk_remove.sh
  dos2unix monk_remove.sh > /dev/null 2>&1
  /bin/bash ./monk_remove.sh $ALIAS
elif [[ ${OPTION} == "10" ]] ; then
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/update_wallet.sh -O update_wallet.sh > /dev/null 2>&1
  chmod 777 update_wallet.sh
  dos2unix update_wallet.sh > /dev/null 2>&1
  /bin/bash ./update_wallet.sh
elif [[ ${OPTION} == "11" ]] ; then
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/memory_cpu_sysinfo.sh -O memory_cpu_sysinfo.sh > /dev/null 2>&1
  chmod 777 memory_cpu_sysinfo.sh
  dos2unix memory_cpu_sysinfo.sh > /dev/null 2>&1
  /bin/bash ./memory_cpu_sysinfo.sh
elif [[ ${OPTION} == "12" ]] ; then
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monkey_logo.sh -O monkey_logo.sh > /dev/null 2>&1
  chmod 777 monkey_logo.sh
  dos2unix monkey_logo.sh > /dev/null 2>&1
  /bin/bash ./monkey_logo.sh
elif [[ ${OPTION} == "0" ]] ; then
  exit 0
elif [[ ${OPTION} == "50" ]] ; then
  wget https://raw.githubusercontent.com/ShadXo/MonkeyProjectScripts/master/monk_setupv3-f.sh -O monk_setupv3-f.sh > /dev/null 2>&1
  chmod 777 monk_setupv3-f.sh
  dos2unix monk_setupv3-f.sh > /dev/null 2>&1
  /bin/bash ./monk_setupv3-f.sh
fi
###
read -n 1 -s -r -p "****Press any key to go back to MONKEY MAIN MENU*****"
/bin/bash ./monk.sh
