// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NEVMRegistry {
    address constant private NEVM_PRECOMPILE = address(0x62);
    uint256 constant private NEVM_GAS = 200;

    /// @notice Returns the collateral height (seniority) of a sentry node.
    /// @param node The Ethereum address of the node.
    /// @return collateralHeight The collateral height in the UTXO blockchain.
    function getCollateralHeight(address node) external view returns (uint256 collateralHeight) {
        (bool success, bytes memory data) = NEVM_PRECOMPILE.staticcall{gas: NEVM_GAS}(abi.encodePacked(node));
        require(success && data.length == 32, "NEVM call failed");
        collateralHeight = abi.decode(data, (uint256));
        require(collateralHeight > 0, "address does not exist in the registry");
    }
}
