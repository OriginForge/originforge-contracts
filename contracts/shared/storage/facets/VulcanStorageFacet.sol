// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibDiamond } from "../../libraries/LibDiamond.sol";
import "../structs/VulcanFacetStorage.sol";

contract VulcanStorageFacet {

  function vulcanStorage() internal pure returns (VulcanFacetStorage storage ds) {
      bytes32 position =  keccak256("diamond.vulcan.diamond.storage");
      assembly {
          ds.slot := position
      }
  }
}
