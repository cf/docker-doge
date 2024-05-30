#!/bin/sh

mkdir -p /app/log/
bitcoind -regtest \
  -rpcbind=0.0.0.0:18443 \
  -rpcuser=devnet \
  -rpcpassword=devnet \
  -rpcallowip=0.0.0.0/0 \
  -rpcport=18443 \
  -server=1 \
  -txindex=1 \
  -zmqpubhashtx=tcp://0.0.0.0:30001 \
  -zmqpubhashblock=tcp://0.0.0.0:30001 \
  -prune=0 >> /app/log/bitcoind 2>&1 & echo $! > /app/bitcoind.pid

sleep 2
#bitcoin-cli -regtest -rpcuser=devnet -rpcpassword=devnet createwallet "default" > /dev/null

BTC_ADDRESS=$(bitcoin-cli -regtest -rpcport=18443 -rpcuser=devnet -rpcpassword=devnet -rpcwallet=default getnewaddress)
#echo "New Address: $BTC_ADDRESS"
bitcoin-cli -regtest -rpcport=18443 -rpcuser=devnet -rpcpassword=devnet -rpcwallet=default settxfee 0.00001000 > /dev/null
bitcoin-cli -regtest -rpcport=18443 -rpcuser=devnet -rpcpassword=devnet -rpcwallet=default generatetoaddress 101 "$BTC_ADDRESS" > /dev/null


sleep 2

/app/electrs_bitcoin/bin/electrs \
  -vvvv \
  --timestamp \
  --daemon-dir=/app/.dogecoin \
  --db-dir=/app/db \
  --network regtest \
  --http-addr=0.0.0.0:50000 \
  --electrum-rpc-addr=0.0.0.0:50001 \
  --daemon-rpc-addr=127.0.0.1:18443 \
  --cookie=devnet:devnet \
  --electrum-txs-limit=1000000 \
  --cors=* \
  --utxos-limit=1000000 >> /app/log/electrs 2>&1 & echo $! > /app/electrs.pid


