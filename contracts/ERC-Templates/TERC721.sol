// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "../ERC-Contracts/ERC721.sol";

contract TERC721 is ERC721 {
    constructor(string memory _name, string memory _symbol) ERC721() { 
        _setNameAndSymbol(_name, _symbol);
    }
}