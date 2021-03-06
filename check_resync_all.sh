#/bin/bash

for FILE in ~/bin/monkeyd*.sh; do
  echo "****************************************************************************"
  COUNTER=1
  DATE=$(date '+%d.%m.%Y %H:%M:%S');
  echo "DATE="$DATE
  echo FILE: " $FILE"
  #cat $FILE
  MONKSTARTPOS=$(echo $FILE | grep -b -o _)
  MONKLENGTH=$(echo $FILE | grep -b -o .sh)
  # echo ${MONKSTARTPOS:0:2}
  MONKSTARTPOS_1=$(echo ${MONKSTARTPOS:0:2})
  MONKSTARTPOS_1=$[MONKSTARTPOS_1 + 1]
  MONKNAME=$(echo ${FILE:MONKSTARTPOS_1:${MONKLENGTH:0:2}-MONKSTARTPOS_1})
  MONKCONFPATH=$(echo "$HOME/.monkey_$MONKNAME")
  # echo $MONKSTARTPOS_1
  # echo ${MONKLENGTH:0:2}
  echo CONF FOLDER: $MONKCONFPATH
  
  for (( ; ; ))
  do
  
	MONKPID=`ps -ef | grep -i $MONKNAME | grep -i monkeyd | grep -v grep | awk '{print $2}'`
	echo "MONKPID="$MONKPID
	
	if [ -z "$MONKPID" ]; then
	  echo "Monk $MONKNAME is STOPPED can't check if synced!"
	  break
	fi
  
	LASTBLOCK=$($FILE getblockcount)
	GETBLOCKHASH=$($FILE getblockhash $LASTBLOCK)
	GETBLOCKHASHEXPLORER=$(curl -s4 http://explorer.monkey.community/api/getblockhash?index=$LASTBLOCK)

	echo "LASTBLOCK="$LASTBLOCK
	echo "GETBLOCKHASH="$GETBLOCKHASH
	echo "GETBLOCKHASHEXPLORER="$GETBLOCKHASHEXPLORER
	
	LASTBLOCKCOINEXPLORERMONK=$(curl -s4 https://www.coinexplorer.net/api/MONK/block/latest)
	# echo $LASTBLOCKCOINEXPLORERMONK
	BLOCKHASHCOINEXPLORERMONK=', ' read -r -a array <<< $LASTBLOCKCOINEXPLORERMONK
	BLOCKCOUNTCOINEXPLORERMONK=${array[8]}
	# echo $BLOCKCOUNTCOINEXPLORERMONK	
	BLOCKCOUNTCOINEXPLORERMONK=$(echo $BLOCKCOUNTCOINEXPLORERMONK | tr , " ")
	# echo $BLOCKCOUNTCOINEXPLORERMONK
	BLOCKCOUNTCOINEXPLORERMONK=$(echo $BLOCKCOUNTCOINEXPLORERMONK | tr '"' " ")
	# echo $BLOCKCOUNTCOINEXPLORERMONK
	# echo -e "BLOCKCOUNTCOINEXPLORERMONK='${BLOCKCOUNTCOINEXPLORERMONK}'"
	BLOCKCOUNTCOINEXPLORERMONK="$(echo -e "${BLOCKCOUNTCOINEXPLORERMONK}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	# echo -e "BLOCKCOUNTCOINEXPLORERMONK='${BLOCKCOUNTCOINEXPLORERMONK}'"	
	
	BLOCKHASHCOINEXPLORERMONK=${array[6]}
	# echo "BLOCKHASHCOINEXPLORERMONK="$BLOCKHASHCOINEXPLORERMONK
	BLOCKHASHCOINEXPLORERMONK=$(echo $BLOCKHASHCOINEXPLORERMONK | tr , " ")
	# echo $BLOCKHASHCOINEXPLORERMONK
	BLOCKHASHCOINEXPLORERMONK=$(echo $BLOCKHASHCOINEXPLORERMONK | tr '"' " ")
	# echo $BLOCKHASHCOINEXPLORERMONK
	# echo -e "BLOCKHASHCOINEXPLORERMONK='${BLOCKHASHCOINEXPLORERMONK}'"
	BLOCKHASHCOINEXPLORERMONK="$(echo -e "${BLOCKHASHCOINEXPLORERMONK}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	# echo -e "BLOCKHASHCOINEXPLORERMONK='${BLOCKHASHCOINEXPLORERMONK}'"		

	echo "LASTBLOCK="$LASTBLOCK
	echo "GETBLOCKHASH="$GETBLOCKHASH
	echo "GETBLOCKHASHEXPLORER="$GETBLOCKHASHEXPLORER
	echo "BLOCKHASHCOINEXPLORERMONK="$BLOCKHASHCOINEXPLORERMONK
	
	# MONK SEED 1 BLOCKCOUNT
	BLOCKINFOMONKSEED_1=""
	BLOCKINFOMONKSEED_1=$(curl -s4 http://nsseed1.monkey.vision/blockinfo.txt)	
	# echo $BLOCKINFOMONKSEED_1
	BLOCKCOUNTMONKSEED_1=', ' read -r -a array <<< $BLOCKINFOMONKSEED_1
	BLOCKCOUNTMONKSEED_1=${array[18]}
	# echo $BLOCKCOUNTMONKSEED_1
	BLOCKCOUNTMONKSEED_1=$(echo $BLOCKCOUNTMONKSEED_1 | tr , " ")
	BLOCKCOUNTMONKSEED_1="$(echo -e "${BLOCKCOUNTMONKSEED_1}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	# echo -e "BLOCKCOUNTMONKSEED_1='${BLOCKCOUNTMONKSEED_1}'"

	# MONK SEED 2 BLOCKCOUNT
	BLOCKINFOMONKSEED_2=""
	BLOCKINFOMONKSEED_2=$(curl -s4 http://nsseed2.monkey.vision/blockinfo.txt)	
	# echo $BLOCKINFOMONKSEED_2
	BLOCKCOUNTMONKSEED_2=', ' read -r -a array <<< $BLOCKINFOMONKSEED_2
	BLOCKCOUNTMONKSEED_2=${array[18]}
	# echo $BLOCKCOUNTMONKSEED_2
	BLOCKCOUNTMONKSEED_2=$(echo $BLOCKCOUNTMONKSEED_2 | tr , " ")
	BLOCKCOUNTMONKSEED_2="$(echo -e "${BLOCKCOUNTMONKSEED_2}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	# echo -e "BLOCKCOUNTMONKSEED_2='${BLOCKCOUNTMONKSEED_2}'"	
	
	echo "*******************************************************"
	echo **1. CHECKING SEED ONE AND SEED TWO**
	echo "BLOCKCOUNTMONKSEED_1="$BLOCKCOUNTMONKSEED_1
	echo "BLOCKCOUNTMONKSEED_2="$BLOCKCOUNTMONKSEED_2
	# BLOCKCOUNTMONKSEED_2=$[BLOCKCOUNTMONKSEED_2 + 1] # testing :)
	if [ "$BLOCKCOUNTMONKSEED_1" == "$BLOCKCOUNTMONKSEED_2" ]; then
		echo "SEED ONE AND SEED TWO = OK"
		# REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo "SEED ONE AND SEED TWO = OK;")
	else
		BLOCKCOUNTMONKSEED_2=$[BLOCKCOUNTMONKSEED_2 + 1]
		if [ "$BLOCKCOUNTMONKSEED_1" == "$BLOCKCOUNTMONKSEED_2" ]; then
			echo "SEED ONE AND SEED TWO = OK"
			# REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo "SEED ONE AND SEED TWO = OK;")
			BLOCKCOUNTMONKSEED_2=$[BLOCKCOUNTMONKSEED_2 - 1]
		else
			BLOCKCOUNTMONKSEED_2=$[BLOCKCOUNTMONKSEED_2 - 2]
			if [ "$BLOCKCOUNTMONKSEED_1" == "$BLOCKCOUNTMONKSEED_2" ]; then
				echo "SEED ONE AND SEED TWO = OK"
				# REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo "SEED ONE AND SEED TWO = OK;")		
				BLOCKCOUNTMONKSEED_2=$[BLOCKCOUNTMONKSEED_2 + 1]
			else
				echo "SEED ONE AND SEED TWO NOT MATCH !!!"
				REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo "SEED ONE AND SEED TWO NOT MATCH !!!;")
			fi
		fi
	fi		
	
	echo "*******************************************************"
	echo **2. CHECKING MONK EXPLORER AND SEED ONE**
	echo "BLOCKCOUNTCOINEXPLORERMONK="$BLOCKCOUNTCOINEXPLORERMONK
	echo "BLOCKCOUNTMONKSEED_1="$BLOCKCOUNTMONKSEED_1
	# BLOCKCOUNTMONKSEED_1=$[BLOCKCOUNTMONKSEED_1 + 2] # testing :)
	if [ "$BLOCKCOUNTCOINEXPLORERMONK" == "$BLOCKCOUNTMONKSEED_1" ]; then
		echo "MONK EXPLORER AND SEED ONE = OK"
		# REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo " ")$(echo "MONK EXPLORER AND SEED ONE = OK;")
	else
		BLOCKCOUNTMONKSEED_1=$[BLOCKCOUNTMONKSEED_1 + 1]
		if [ "$BLOCKCOUNTCOINEXPLORERMONK" == "$BLOCKCOUNTMONKSEED_1" ]; then
			echo "MONK EXPLORER AND SEED ONE = OK"
			# REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo " ")$(echo "MONK EXPLORER AND SEED ONE = OK;")
			BLOCKCOUNTMONKSEED_1=$[BLOCKCOUNTMONKSEED_1 - 1]
		else
			BLOCKCOUNTMONKSEED_1=$[BLOCKCOUNTMONKSEED_1 - 2]
			if [ "$BLOCKCOUNTCOINEXPLORERMONK" == "$BLOCKCOUNTMONKSEED_1" ]; then
				echo "MONK EXPLORER AND SEED ONE = OK"
				# REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo " ")$(echo "MONK EXPLORER AND SEED ONE = OK;")
				BLOCKCOUNTMONKSEED_1=$[BLOCKCOUNTMONKSEED_1 + 1]
			else
				echo "MONK EXPLORER AND SEED ONE NOT MATCH !!!"
				REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo " ")$(echo "COIN EXPLORER MONK AND SEED ONE NOT MATCH !!!;")
			fi
		fi	
	fi
	echo "*******************************************************"	
	
	# REPORTMAILBLOCKCOUNT="test"
	echo $REPORTMAILBLOCKCOUNT
	if [ -z "$REPORTMAILBLOCKCOUNT" ]; then
	  echo $DATE" ALL IN SYNC! REPORTMAILBLOCKCOUNT is empty"
	else
	  echo $DATE" "$REPORTMAILBLOCKCOUNT
	  exit -1
	fi		

	echo "GETBLOCKHASH="$GETBLOCKHASH
	echo "BLOCKHASHCOINEXPLORERMONK="$BLOCKHASHCOINEXPLORERMONK
	if [ "$GETBLOCKHASH" == "$BLOCKHASHCOINEXPLORERMONK" ]; then
		echo $DATE" Wallet $MONKNAME is SYNCED!"
		break
	else  
		# Wallet is not synced
		echo $DATE" Wallet $MONKNAME is NOT SYNCED!"
		#
		#STOP 
		$FILE stop
		sleep 3 # wait 3 seconds 
		MONKPID=`ps -ef | grep -i $MONKNAME | grep -i monkeyd | grep -v grep | awk '{print $2}'`
		echo "MONKPID="$MONKPID
		
		if [ -z "$MONKPID" ]; then
		  echo "Monk $MONKNAME is STOPPED"
		  
		  cd $MONKCONFPATH
		  echo CURRENT CONF FOLDER: $PWD
		  echo "Copy BLOCKCHAIN without conf files"
		  wget http://blockchain.monkey.vision/ -O bootstrap.zip
		  # rm -R peers.dat 
		  rm -R ./database
		  rm -R ./blocks	  
		  unzip  bootstrap.zip
		  $FILE
		  sleep 5 # wait 5 seconds 
		  
		  MONKPID=`ps -ef | grep -i $MONKNAME | grep -i monkeyd | grep -v grep | awk '{print $2}'`
		  echo "MONKPID="$MONKPID
		  
		  if [ -z "$MONKPID" ]; then
			echo "Monk $MONKNAME still not running!"
		  fi
		  
		  break
		else
		  echo "Monk $MONKNAME still running!"
		fi
	fi
	
	COUNTER=$[COUNTER + 1]
	echo COUNTER: $COUNTER
	if [[ "$COUNTER" -gt 9 ]]; then
	  break
	fi		
  done		
done