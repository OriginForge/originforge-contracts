// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {AppStorage} from "../shared/storage/structs/AppStorage.sol";
import {modifiersFacet} from "../shared/utils/modifiersFacet.sol";
// multicall 라이브러리 추가
import "@openzeppelin/contracts/utils/Multicall.sol";

contract AdminFacet is modifiersFacet, Multicall {
    AppStorage internal s;

    function Admin_setContract(
        string memory _contractName,
        address _contractAddress
    ) external onlyAdmin {
        s.contracts[_contractName] = _contractAddress;
    }

    function getContract(
        string memory _contractName
    ) external view returns (address) {
        return s.contracts[_contractName];
    }

    function Admin_itemSet(uint _itemId, uint _price) external onlyAdmin {
        s.items[_itemId].itemId = _itemId;
        s.items[_itemId].price = _price;
    }

    function Admin_itemGet(uint _itemId) external view returns (uint, uint) {
        return (s.items[_itemId].itemId, s.items[_itemId].price);
    }
}
