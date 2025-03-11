# NEVM Registry Contract

A highly optimized Solidity contract to query Syscoin's NEVM precompile for retrieving collateral height (seniority) of sentry nodes.

## Contract Overview

This contract interacts directly with a Syscoin-specific precompile to retrieve the collateral height of sentry nodes, which is crucial for determining node seniority.

## Usage

The primary function is:

```solidity
function getCollateralHeight(address node) external view returns (uint256 collateralHeight);
```

## Setup

### Install dependencies

```bash
npm install
```

### Configuration

Update your seed phrase directly in the `hardhat.config.js`:

```javascript
const MNEMONIC = "your twelve word seed phrase here";
```

## Deployment

Deploy to your desired network:

```bash
npm run deploy:tanenbaum
npm run deploy:mainnet
npm run deploy:local
```

The deployment script automatically saves the contract address into a `deployments_<network>.json` file.

## Verification

Automatically verify the deployed contract on Sourcify:

```bash
npm run verify:tanenbaum
npm run verify:mainnet
```

The verification script automatically retrieves the deployed contract's address from the saved JSON file.

## Networks

Configured networks include:
- `tanenbaum` (Syscoin test network)
- `mainnet` (Syscoin mainnet)
- `development` (Local development network)

## License

MIT License
