// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import { AppStorage } from "../shared/storage/structs/AppStorage.sol";
import {modifiersFacet} from "../shared/utils/modifiersFacet.sol";


contract AdminFacet is modifiersFacet {
    AppStorage internal s;

    function setDatas (string memory _msg1, string memory _msg2) external onlyAdmin {
        s.msg1 = _msg1;
        s.msg2 = _msg2;
    }

    function getDatas() external view returns (string memory, string memory) {
        return (s.msg1, s.msg2);
    }

    
}  