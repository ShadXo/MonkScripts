#!/bin/bash

NAME="monk"
PARAM1=$*

if [ -z "$PARAM1" ]; then
  PARAM1="*"
else
  PARAM1=${PARAM1,,}
fi

for FILE in $(ls ~/bin/${NAME}d_$PARAM1.sh | sort -V); do
  echo "*******************************************"
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
  MONKCONFPATH=$(echo "$HOME/.${NAME}_$MONKNAME")
  # echo $MONKSTARTPOS_1
  # echo ${MONKLENGTH:0:2}
  echo "NODE ALIAS: "$MONKCONFPATH
  echo "CONF FOLDER: "$MONKCONFPATH
done
