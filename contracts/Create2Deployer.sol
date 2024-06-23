// contracts/Create2Deployer.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Create2Deployer {
    function deploy(bytes32 salt, bytes memory bytecode, bytes memory initData) public returns (address) {
        address addr;
        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
            if iszero(extcodesize(addr)) { revert(0, 0) }
        }

        (bool success, ) = addr.call(initData);
        require(success, "Initialization failed");
        return addr;
    }
}
