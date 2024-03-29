// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract My_token is ERC20 {
    address public owner;

    constructor() ERC20("MyTokenBoss", "MTB") {
        owner = msg.sender;
        _mint(msg.sender, 500 * 1e18);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of this token.");
    _;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        uint toMint = amount * 1e18;
        _mint(to, toMint);
    }

    function burn(uint256 amount) public {
        uint toBurn = amount * 1e18;
        _burn(msg.sender, toBurn);
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        uint256 currentAllowance = allowance(from, msg.sender);
        require(currentAllowance >= amount, "Boss transfer amount is more than the allowance");
        
        _transfer(from, to, amount*1e18);        
        _approve(from, msg.sender, amount*1e18);

        return true;
    }
}