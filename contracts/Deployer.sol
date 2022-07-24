// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./ERC-Templates/TERC721.sol";

contract Deployer {
    constructor() {}

    event genericERC721Deployer(address _deployer, address _contract);

    function genericERC721(
        string memory _name,
        string memory _symbol,
        string memory _startUri,
        string memory _endUri,
        uint256 _maxTokens,
        uint256 _pricePerToken
    ) public {
        TERC721 terc = new TERC721(
            _name,
            _symbol,
            _startUri,
            _endUri,
            _maxTokens,
            _pricePerToken
        );
        emit genericERC721Deployer(msg.sender, address(terc));
    }
}
