// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {LibDiamond} from "../libraries/LibDiamond.sol";

contract modifiersFacet {
    
    modifier onlyAdmin() {
        LibDiamond.enforceIsContractOwner();
        _;
    }

    
}