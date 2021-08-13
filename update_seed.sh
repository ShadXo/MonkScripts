echo
echo "MONK - Masternode updater"
echo ""
echo "Welcome to the MONK Masternode update script."
echo "Wallet v3.0.2.0"
echo

NAME="monk"
NAMEALIAS="MONK"
WALLETVERSION="3.0.2.0"
WALLETDLFOLDER="${NAME}-${WALLETVERSION}"
WALLETDL="${WALLETDLFOLDER}-Linux.zip"
URL="https://github.com/decenomy/MONK/releases/download/v${WALLETVERSION}/${WALLETDL}"
CONF_DIR_TMP=~/"${NAME}_tmp"

cd ~
sudo killall -9 ${NAME}d
sudo rm -rdf /usr/local/bin/${NAME}*
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
rm -rdf $CONF_DIR_TMP

monkd -reindex

sleep 1

monk-cli getinfo

echo "Your masternode wallets are now updated!"
