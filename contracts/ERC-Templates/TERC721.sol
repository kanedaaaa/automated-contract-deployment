// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "../ERC-Contracts/ERC721Enumerable.sol";

contract TERC721 is ERC721Enumerable {
    constructor(string memory _name, string memory _symbol) ERC721() { 
        _setNameAndSymbol(_name, _symbol);
    }
}