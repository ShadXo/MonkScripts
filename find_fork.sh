#/bin/bash

NAME="monk"
WALLET=$1
BLOCK=$2
#INCREMENT=$3
INCREMENT=1

if [ -z "$WALLET" ]; then
  echo "Need to specify node alias!"
  exit -1
fi
if [ -z "$BLOCK" ]; then
  echo "Need to specify a starting block!"
  exit -1
fi

for (( ; ; ))
do

	for (( ; ; ))
	do
    echo "Running check on $WALLET"
    echo "Starting from block $BLOCK"

		for FILE in $(ls ~/bin/${NAME}-cli_$WALLET.sh | sort -V); do
      echo "*******************************************"
      echo "Checking block $BLOCK"
			#echo $FILE

			BLOCKHASHEXPLORER=$(curl -s4 https://explorer.decenomy.net/coreapi/v1/coins/MONK/blocks | jq -r ".response[0].blockhash")
			if [ -z "$BLOCKHASHEXPLORER" ]; then
			  break 2
			fi
      if [ "$BLOCKHASHEXPLORER" == null ]; then
        echo "NO FORK FOUND"
			  break 2
			fi

      BLOCKHASHWALLET=$($FILE getblockhash $BLOCK)
      if [ -z "$BLOCKHASHWALLET" ]; then
			  break 2
			fi

      echo "BLOCKHASHEXPLORER=$BLOCKHASHEXPLORER"
      echo "BLOCKHASHWALLET=$BLOCKHASHWALLET"
		done

    if [ "$BLOCKHASHWALLET" != "$BLOCKHASHEXPLORER" ]; then
		  echo "FORK FOUND ON BLOCK $BLOCK !!!!"
		  break
		fi

		BLOCK=$[BLOCK + $INCREMENT]
	done

	BLOCK=$[BLOCK - $INCREMENT]
	INCREMENT=$[INCREMENT / 10]

    if [[ "$INCREMENT" -eq 0 ]]; then
	  break
	fi

    if [[ "$INCREMENT" -lt 1 ]]; then
	  break
	fi
done
