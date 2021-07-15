echo
echo "MONK - Masternode updater"
echo ""
echo "Welcome to the MONK Masternode update script."
echo "Wallet v3.0.1.1"
echo

for filename in ~/bin/monk-cli*.sh; do
  sh $filename stop
  sleep 1
done

cd ~
sudo killall -9 monkd
sudo rm -rdf /usr/bin/monk*
cd

mkdir -p MONK_TMP
cd MONK_TMP
wget https://github.com/decenomy/MONK/releases/download/v3.0.1.1/MONK-3.0.1.1-Linux.zip
sudo chmod 775 MONK-3.0.1.1-Linux.zip
#tar -xvzf monkey-2.3.0-x86_64-linux-gnu.tar.gz
unzip MONK-3.0.1.1-Linux.zip -d MONK-3.0.1.1

rm -f MONK-3.0.1.1-Linux.zip
sudo chmod 775 ./MONK-3.0.1.1/*
sudo mv ./MONK-3.0.1.1/monk* /usr/bin

cd ~
rm -rdf MONK_TMP

for filename in ~/bin/monkd*.sh; do
  echo $filename
  sh $filename
  sleep 1
done

echo "Your masternode wallets are now updated!"
