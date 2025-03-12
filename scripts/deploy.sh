#!/bin/bash

RPC_URL=$1
NETWORK=$2

# Clean and rebuild before deployment
forge clean && forge build

# Deploy contract using Forge, capture deployment address
forge create \
  --rpc-url "$RPC_URL" \
  --mnemonic-path .mnemonic \
  --json \
  contracts/NEVMRegistry.sol:NEVMRegistry | \
jq '{address: .deployedTo, network: "'$NETWORK'"}' > deployments_${NETWORK}.json

echo "Contract deployed and saved to deployments_${NETWORK}.json"
