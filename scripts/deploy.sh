#!/bin/bash

RPC_URL=$1
NETWORK=$2

forge create \
  --rpc-url "$RPC_URL" \
  --mnemonic-path .mnemonic \
  --json \
  --legacy \
  --broadcast \
  contracts/NEVMRegistry.sol:NEVMRegistry | \
jq '{contract: "NEVMRegistry", address: .deployedTo, txHash: .transactionHash, network: "'$NETWORK'"}' > deployments_${NETWORK}.json

ADDRESS=$(jq -r '.address' deployments_${NETWORK}.json)

if [ "$ADDRESS" = "null" ]; then
  echo "Deployment failed! Check RPC URL and mnemonic."
else
  echo "Contract deployed at $ADDRESS and saved to deployments_${NETWORK}.json"
fi
