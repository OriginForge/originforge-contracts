// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {AppStorage} from "../shared/storage/structs/AppStorage.sol";
import {IPoolRouter} from "../shared/interfaces/IPoolRouter.sol";
import {LibMeta} from "../shared/libraries/LibMeta.sol";
import {IERC20} from "../shared/interfaces/IERC20.sol";
import {IERC1155} from "../shared/interfaces/IERC1155.sol";

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract PaymentFacet is ReentrancyGuard {
    AppStorage internal s;

    // address pageaRouter = address(0x17Ac28a29670e637c8a6E1ec32b38fC301303E34);
    // address gcPool = address(0x9F8a222Fd0b75239B32Aa8a97C30669E5981dB05);
    // address gcKlay = 0x999999999939ba65abb254339eec0b2a0dac80e9;

    address gcPool;
    address pangeaRouter;
    address gcKlay;
    address bank;
    
    function pay(uint payAmount) external payable returns (uint) {
        IERC20 token = IERC20(gcKlay);
        IPoolRouter poolRouter = IPoolRouter(pangeaRouter);
        IPoolRouter.ExactInputSingleParams memory params = IPoolRouter
            .ExactInputSingleParams({
                tokenIn: address(0),
                amountIn: payAmount,
                amountOutMinimum: payAmount,
                pool: gcPool,
                to: address(this),
                unwrap: false
            });

        poolRouter.exactInputSingle{value: payAmount}(params);
        uint swapBalance = token.balanceOf(address(this));
        (uint caluledAmount, uint fee) = _feeCalculation(swapBalance);
        
        token.transfer(bank, fee);
        token.transfer(msg.sender, caluledAmount);

        return (caluledAmount);
    }

    function reFund(
        address _sender,
        uint reFundAmount
    ) external nonReentrant returns (uint, uint) {
        // require(reFundAmount > 5 ether, "LibPayment: reFundAmount too low");

        IPoolRouter poolRouter = IPoolRouter(pangeaRouter);

        IPoolRouter.ExactInputSingleParams memory params = IPoolRouter
            .ExactInputSingleParams({
                tokenIn: gcKlay,
                amountIn: reFundAmount,
                amountOutMinimum: 10,
                pool: gcPool,
                to: _sender,
                unwrap: true
            });

        poolRouter.exactInputSingle(params);

        return (reFundAmount, block.number);
    }

    function _feeCalculation(
        uint256 _amount
    ) internal view returns (uint256, uint256) {
        uint256 fee = _amount / 100;
        return (_amount - fee, fee);
    }
    // function itemBuy(
    //     address _buyer,
    //     uint _itemId,
    //     uint _quantity,
    //     uint _payAmount
    // ) external nonReentrant returns (uint, uint) {
    //     IERC1155 item = IERC1155(s.contracts["item"]);
    //     uint itemPrice = s.items[_itemId].price * _quantity;

    //     // require(s.items[_itemId].price != 0, "PaymentFacet: item not found");
    //     // require(_payAmount >= itemPrice, "PaymentFacet: payAmount too low");

    //     IPoolRouter poolRouter = IPoolRouter(pangeaRouter);

    //     IPoolRouter.ExactInputSingleParams memory params = IPoolRouter
    //         .ExactInputSingleParams({
    //             tokenIn: gcKlay,
    //             amountIn: itemPrice,
    //             amountOutMinimum: 10,
    //             pool: gcPool,
    //             to: bank,
    //             unwrap: true
    //         });

    //     item.mint(_buyer, _itemId, _quantity, "0x0");

    //     poolRouter.exactInputSingle{value: itemPrice}(params);

    //     return (itemPrice, block.number);
    // }
}
