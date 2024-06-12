// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {AppStorage} from "../shared/storage/structs/AppStorage.sol";
import {IERC721} from "../shared/interfaces/IERC721.sol";

contract RegisterFacet {
    AppStorage internal s;

    function Register_registerUser(string memory _name) external {
        s.users[msg.sender].name = _name;
        IERC721 SBT = IERC721(s.contracts["sbt"]);
        uint tokenId = SBT.safeMint(msg.sender, "-");
        s.users[msg.sender].tokenId = tokenId;
    }

    function Register_userGet() external view returns (string memory, uint) {
        return (s.users[msg.sender].name, s.users[msg.sender].tokenId);
    }
}
