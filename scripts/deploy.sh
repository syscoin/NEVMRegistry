#!/bin/bash

export FOUNDRY_ETH_RPC_TIMEOUT=900000  # 15 minutes

RPC_URL=$1
NETWORK=$2
export FOUNDRY_ETH_RPC_TIMEOUT=900000

RPC_TIMEOUT=${FOUNDRY_ETH_RPC_TIMEOUT}

forge clean && forge build
OUTPUT=$(forge create \
    contracts/NEVMRegistry.sol:NEVMRegistry \
    --rpc-url "$RPC_URL" \
    --mnemonic-path .mnemonic \
    --json \
    --broadcast)

# Check if deployment succeeded
ADDRESS=$(echo "$OUTPUT" | jq -r '.deployedTo // empty')

if [ -z "$ADDRESS" ] || [ "$ADDRESS" = "null" ]; then
    echo "Deployment failed or contract was not deployed. Output was:"
    echo "$OUTPUT"
    exit 1
else
    echo "$OUTPUT" | jq '{contract: "NEVMRegistry", address: .deployedTo, txHash: .transactionHash, network: "'"$NETWORK"'"}' \
    > deployments_${NETWORK}.json
    echo "Contract deployed at ${ADDRESS} and saved to deployments_${NETWORK}.json"
fi
