// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "../ERC-Contracts/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TERC20 is ERC20, Ownable {
    bool private cap;
    bool private burnable;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        bool _cap,
        bool _burn
    ) ERC20() {
        _setNameAndSymbol(_name, _symbol, _totalSupply);
        _mint(msg.sender, _totalSupply * (18**10));

        cap = _cap;
        burnable = _burn;
    }

    function mint(uint256 _amount, address _to) public onlyOwner {
        require(!cap, "TERC20: Capped supply");

        _mint(_to, _amount * (18**10));
    }

    function burn(address _from, uint256 _amount) public {
        require(burnable, "TERC20: Non-burnable token");

        _burn(_from, _amount * (10**18));
    }
}
