#!/bin/bash

RPC_URL=$1
NETWORK=$2
ADDRESS_TO_QUERY=$3

CONTRACT_ADDRESS=$(jq -r '.address' deployments_${NETWORK}.json)

if [ "$CONTRACT_ADDRESS" == "null" ] || [ -z "$CONTRACT_ADDRESS" ]; then
  echo "Contract address not found in deployments_${NETWORK}.json"
  exit 1
fi

echo "Calling getCollateralHeight on contract at $CONTRACT_ADDRESS with address $ADDRESS_TO_QUERY..."

RESULT=$(cast call \
  --rpc-url "$RPC_URL" \
  $CONTRACT_ADDRESS \
  "getCollateralHeight(address)(uint256)" \
  "$ADDRESS_TO_QUERY" 2>&1)

if echo "$RESULT" | grep -q "execution reverted: NEVM call failed"; then
  echo "❌ Error: The NEVM precompile call itself failed (no 32 bytes, etc.)"
elif echo "$RESULT" | grep -q "execution reverted: address does not exist in the registry"; then
  echo "❌ Error: The address returns zero collateral height."
else
  echo "✅ Collateral Height for $ADDRESS_TO_QUERY is: $RESULT"
fi
