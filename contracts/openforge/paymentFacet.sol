// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {AppStorage} from "../shared/storage/structs/AppStorage.sol";
import {IPoolRouter} from "../shared/interfaces/IPoolRouter.sol";
import {LibMeta} from "../shared/libraries/LibMeta.sol";
import {IERC20} from "../shared/interfaces/IERC20.sol";
import {IERC1155} from "../shared/interfaces/IERC1155.sol";
//
//
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract PaymentFacet is ReentrancyGuard {
    AppStorage internal s;

    // payable 필요 없나?
    function pay(uint payAmount) external returns (uint, uint) {
        require(payAmount > 0.1 ether, "LibPayment: payAmount too low");

        // pangearouter
        IPoolRouter poolRouter = IPoolRouter(s.contracts["pangearouter"]);

        IPoolRouter.ExactInputSingleParams memory params = IPoolRouter
            .ExactInputSingleParams({
                tokenIn: address(0),
                amountIn: payAmount,
                amountOutMinimum: 1000,
                pool: s.contracts["gcpool"],
                to: s.contracts["bank"],
                unwrap: false
            });

        //payable
        poolRouter.exactInputSingle{value: payAmount}(params);

        return (payAmount, block.number);
    }
    // 0xc07f5c3200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000de0b6b3a76400000000000000000000000000000000000000000000000000000dcf075580c225b20000000000000000000000009f8a222fd0b75239b32aa8a97c30669e5981db05000000000000000000000000e34f22cf55db5209ba6546701d408e5f58d8703f0000000000000000000000000000000000000000000000000000000000000000
    function reFund(
        address _sender,
        uint reFundAmount
    ) external nonReentrant returns (uint, uint) {
        require(reFundAmount > 5 ether, "LibPayment: reFundAmount too low");

        IPoolRouter poolRouter = IPoolRouter(s.contracts["pangearouter"]);

        IPoolRouter.ExactInputSingleParams memory params = IPoolRouter
        // pangearouter 0x17Ac28a29670e637c8a6E1ec32b38fC301303E34
        // gc token 0x999999999939ba65abb254339eec0b2a0dac80e9
        // gc pool 0x9F8a222Fd0b75239B32Aa8a97C30669E5981dB05
            .ExactInputSingleParams({
                tokenIn: s.contracts["gctoken"],
                amountIn: reFundAmount,
                amountOutMinimum: 10,
                pool: s.contracts["gcpool"],
                to: _sender,
                unwrap: true
            });

        poolRouter.exactInputSingle(params);

        return (reFundAmount, block.number);
    }

    function itemBuy(
        address _buyer,
        uint _itemId,
        uint _quantity,
        uint _payAmount
    ) external nonReentrant returns (uint, uint) {
        IERC1155 item = IERC1155(s.contracts["item"]);
        uint itemPrice = s.items[_itemId].price * _quantity;

        require(s.items[_itemId].price != 0, "PaymentFacet: item not found");
        require(_payAmount >= itemPrice, "PaymentFacet: payAmount too low");

        IPoolRouter poolRouter = IPoolRouter(s.contracts["pangearouter"]);

        IPoolRouter.ExactInputSingleParams memory params = IPoolRouter
            .ExactInputSingleParams({
                tokenIn: s.contracts["gctoken"],
                amountIn: _payAmount,
                amountOutMinimum: 10,
                pool: s.contracts["gcpool"],
                to: _buyer,
                unwrap: true
            });

        poolRouter.exactInputSingle(params);

        item.mint(_buyer, _itemId, _quantity, "0x0");

        return (_payAmount, block.number);
    }
}
