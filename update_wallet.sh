echo
echo "MONK - Masternode updater"
echo ""
echo "Welcome to the MONK Masternode update script."
echo "Wallet v3.0.2.1"
echo

NAME="monk"
NAMEALIAS="MONK"
WALLETVERSION="3.0.2.1"
WALLETDLFOLDER="${NAME}-${WALLETVERSION}"
WALLETDL="${WALLETDLFOLDER}-Linux.zip"
URL="https://github.com/decenomy/MONK/releases/download/v${WALLETVERSION}/${WALLETDL}"
CONF_DIR_TMP=~/"${NAME}_tmp"


for filename in ~/bin/${NAME}-cli*.sh; do
  sh $filename stop
  sleep 1
done

cd ~
sudo killall -9 ${NAME}d
sudo rm -rdf /usr/bin/${NAME}*
cd

mkdir -p $CONF_DIR_TMP

cd $CONF_DIR_TMP
wget ${URL}
sudo chmod 775 ${WALLETDL}
#tar -xvzf monkey-2.3.0-x86_64-linux-gnu.tar.gz
unzip ${WALLETDL} -d ${WALLETDLFOLDER}

#rm -f ${WALLETDL}
cd ./${WALLETDLFOLDER}
sudo chmod 775 *
sudo mv ./${NAME}* /usr/bin

cd ~
rm -rfd $CONF_DIR_TMP

for filename in ~/bin/${NAME}d*.sh; do
  echo $filename
  sh $filename
  sleep 1
done

echo "Your masternode wallets are now updated!"
