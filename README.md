# NEVM Registry Contract

A highly optimized Solidity contract to query Syscoin's NEVM precompile for retrieving collateral height (seniority) of sentry nodes.

## Contract Overview

This contract interacts directly with a Syscoin-specific precompile to retrieve the collateral height of sentry nodes, which is crucial for determining node seniority.

## Usage

The primary function is:

```solidity
function getCollateralHeight(address node) external view returns (uint256 collateralHeight);
```

## Setup (Foundry)

### Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## Deployment and Verification Scripts

### Usage

Deploy and verify on Tanenbaum:

```bash
npm run deploy:tanenbaum
npm run verify:tanenbaum
```

Deploy and verify on Mainnet:

```bash
npm run deploy:mainnet
npm run verify:mainnet
```

Deploy and verify locally:

```bash
npm run deploy:local
npm run verify:local
```

## Networks

Configured networks include:
- `tanenbaum` (Syscoin test network, chainId: 5700)
- `mainnet` (Syscoin mainnet, chainId: 57)
- `local` (Local development, chainId: 1337)

## License

MIT License