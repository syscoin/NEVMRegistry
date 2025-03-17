#!/bin/bash

FOUNDRY_ETH_RPC_TIMEOUT=900000  # 15 minutes

RPC_URL=$1
NETWORK=$2

export ETH_TIMEOUT=${FOUNDRY_ETH_RPC_TIMEOUT}

forge clean && forge build
forge create \
  --rpc-url "$RPC_URL" \
  --mnemonic-path .mnemonic \
  --json \
  --timeout "$FOUNDRY_ETH_RPC_TIMEOUT" \
  --broadcast \
  contracts/NEVMRegistry.sol:NEVMRegistry | \
jq --arg network "$NETWORK" '{contract: "NEVMRegistry", address: .deployedTo, txHash: .transactionHash, network: $network}' \
> deployments_${NETWORK}.json

ADDRESS=$(jq -r '.address' deployments_${NETWORK}.json)

if [ "$ADDRESS" = "null" ] || [ -z "$ADDRESS" ]; then
  echo "❌ Deployment failed! Check RPC URL and mnemonic."
  exit 1
else
  echo "✅ Contract deployed at $ADDRESS and saved to deployments_${NETWORK}.json"
fi