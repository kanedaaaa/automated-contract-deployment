// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./ERC-Templates/TERC721.sol";

contract Deployer {
    constructor() {}

    event genericERC721Deployer(address _deployer, address _contract);

    function genericERC721(string memory _name, string memory _symbol) public {
        TERC721 terc = new TERC721(_name, _symbol);
        emit genericERC721Deployer(msg.sender, address(terc));
    }
}
