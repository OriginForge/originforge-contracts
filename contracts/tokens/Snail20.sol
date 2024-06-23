// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20VotesUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";

interface IPayment {
    function pay(uint payAmount) external payable returns (uint);
    function reFund(
        address _sender,
        uint _reFundAmount
    ) external returns (uint, uint);
    function stakeFor(address recipient) external payable;
}
/// @custom:security-contact   https://t.me/Snailz_bot  Call "/admin desc" via bot
contract Snail is
    Initializable,
    ERC20Upgradeable,
    ERC20BurnableUpgradeable,
    ERC20PausableUpgradeable,
    AccessControlUpgradeable,
    ERC20PermitUpgradeable,
    ERC20VotesUpgradeable,
    UUPSUpgradeable,
    ReentrancyGuardUpgradeable
{
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");
    uint256 public constant MAX_SUPPLY = 100000000 * 10 ** 18;
    address public OF_CONTRACT;
    address public GCKLAY;

    

    modifier isMaxSupply(uint _mintAmount) {
        require(
            totalSupply() + _mintAmount <= MAX_SUPPLY,
            "Token: Max supply reached"
        );
        _;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    receive() external payable {
        fundToken(msg.sender);
    }

    function initialize(
        address defaultAdmin
    ) public initializer {
        __ERC20_init("Snail", "Snail");
        __ERC20Burnable_init();
        __ERC20Pausable_init();
        __AccessControl_init();
        __ERC20Permit_init("Snail");
        __ERC20Votes_init();
        __UUPSUpgradeable_init();
        __ReentrancyGuard_init();

        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(PAUSER_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, defaultAdmin);
        _grantRole(UPGRADER_ROLE, defaultAdmin);

        
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function mint(
        address to,
        uint256 amount
    ) public isMaxSupply(amount) onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function clock() public view override returns (uint48) {
        return uint48(block.timestamp);
    }

    // solhint-disable-next-line func-name-mixedcase
    function CLOCK_MODE() public pure override returns (string memory) {
        return "mode=timestamp";
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyRole(UPGRADER_ROLE) {}

    // The following functions are overrides required by Solidity.

    function _update(
        address from,
        address to,
        uint256 value
    )
        internal
        override(
            ERC20Upgradeable,
            ERC20PausableUpgradeable,
            ERC20VotesUpgradeable
        )
    {
        super._update(from, to, value);
    }

    function nonces(
        address owner
    )
        public
        view
        override(ERC20PermitUpgradeable, NoncesUpgradeable)
        returns (uint256)
    {
        return super.nonces(owner);
    }
    function fundToken(address _to) public  payable {
        uint tokenAmount = msg.value * 1000;
        require(tokenAmount <= MAX_SUPPLY, "Token: Max supply reached");
        
        // IPayment payment = IPayment(GCKLAY);

        // payment.stakeFor{value: msg.value}(address(this));

        
        

        _mint(_to, tokenAmount);
    }

    

    // function exitToken(address _tokenAddr) public onlyRole(UPGRADER_ROLE) {
    //     IERC20 token = IERC20(_tokenAddr);
    //     token.transfer(msg.sender, token.balanceOf(address(this)));
    // }

    // function exitKlay() public onlyRole(UPGRADER_ROLE) {
    //     payable(msg.sender).transfer(address(this).balance);
    // }

    // function _calculatePrice() public view returns (uint) {
    //     IERC20 token = IERC20(GCKLAY);
    //     uint tokenBalance = token.balanceOf(address(this));
    //     uint tokenPrice = tokenBalance / totalSupply();

    //     if(tokenPrice == 0) {
    //         return 1;
    //     }
    //     return tokenPrice;
    // }

    function setContracts(address _gcklay, address _ofContract) public onlyRole(UPGRADER_ROLE) {
        GCKLAY = _gcklay;
        OF_CONTRACT = _ofContract;
    }
    
}
