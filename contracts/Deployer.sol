// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./ERC-Templates/TERC721.sol";

contract Deployer {
    constructor() {}

    function genericERC721(string memory _freshName, string memory _freshSymbol) public {
        new TERC721(_freshName, _freshSymbol);
    }
}