#!/bin/bash
curl -L -O  https://github.com/vitelabs/go-vite/releases/download/v2.8.0/gvite-v2.8.0-linux.tar.gz
tar -xzvf gvite-v2.8.0-linux.tar.gz
cd gvite-v2.8.0-linux
./bootstrap
cat gvite.log
read -p "Wallet: "  wallet
read -p "Identity: "  identity
cat <<EOT > node_config.json
{
  "Identity": "$identity",
  "NetID": 1,
  "ListenInterface": "0.0.0.0",
  "Port": 8483,
  "FilePort": 8484,
  "MaxPeers": 10,
  "MinPeers": 5,
  "MaxInboundRatio": 2,
  "MaxPendingPeers": 5,
  "BootSeeds": [
    "https://bootnodes.vite.net/bootmainnet.json"
  ],
  "Discover": true,
  "RPCEnabled": true,
  "HttpHost": "0.0.0.0",
  "HttpPort": 48132,
  "WSEnabled": false,
  "WSHost": "0.0.0.0",
  "WSPort": 41420,
  "HttpVirtualHosts": [],
  "IPCEnabled": true,
  "PublicModules": [
    "ledger",
    "public_onroad",
    "net",
    "contract",
    "pledge",
    "register",
    "vote",
    "mintage",
    "consensusGroup",
    "tx",
    "debug",
    "sbpstats",
    "dashboard"
  ],
  "Miner": false,
  "CoinBase": "",
  "EntropyStorePath": "",
  "EntropyStorePassword": "",
  "LogLevel": "info",
  "DashboardTargetURL": "wss://stats.vite.net",
  "RewardAddr": "$wallet"
}
EOT
touch /home/vite.sh
chmod +x /home/vite.sh
echo "cd ~/gvite-v2.8.0-linux && ./bootstrap" >> /home/vite.sh
echo "@reboot root /home/vite.sh" >> /etc/crontab
netstat -nlp | grep 8483