pragma solidity ^0.8.0;

import {IPoolRouter }from "./IPoolRouter.sol";
import {IERC20} from "./contracts/shared/interfaces/IERC20.sol";

contract TestCall {
    address gcklay;
    address gcpool;
    address pangeaRouter;

   
    function setAddress(address _gcKlay, address _gcpool, address _pangeaRouter) public {
        gcklay = _gcKlay;
        gcpool = _gcpool;
        pangeaRouter = _pangeaRouter;
    }



    function testPay(uint _amount) public payable {
        IPoolRouter poolRouter = IPoolRouter(pangeaRouter);
        IPoolRouter.ExactInputSingleParams memory params = IPoolRouter
            .ExactInputSingleParams({
                tokenIn: address(0),
                amountIn: _amount,
                amountOutMinimum: _amount,
                pool: gcpool,
                to: address(this),
                unwrap: false
            });


        poolRouter.exactInputSingle{value: _amount}(params);
    }
    

    function transferToken(address _tokenAddr) public {
        IERC20 Token = IERC20(_tokenAddr);
        uint balance = Token.balanceOf(address(this));
        Token.transfer(msg.sender, balance);
    }

    function transferValue(uint _amount) public {
        payable(msg.sender).transfer(_amount);
    }



}
