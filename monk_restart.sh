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
  echo "FILE "$FILE
  ALIAS=$(echo $FILE | awk -F'[_.]' '{print $2}')

  MONKPID=`ps -ef | grep -i -w MONK_$ALIAS | grep -i ${NAME}d | grep -v grep | awk '{print $2}'`
  echo "MONKPID="$MONKPID

  if [ "$MONKPID" ]; then
  ~/bin/${NAME}-cli_$ALIAS.sh stop
  sleep 2 # wait 2 seconds
  fi

  $FILE
  sleep 3 # wait 3 seconds

  MONKPID=`ps -ef | grep -i -w MONK_$ALIAS | grep -i ${NAME}d | grep -v grep | awk '{print $2}'`
  echo "MONKPID="$MONKPID
done
