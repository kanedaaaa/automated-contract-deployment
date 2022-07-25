// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./ERC-Templates/TERC721.sol";

contract Deployer {
    constructor() {}
    
    mapping(address => address[]) private contractByUser;

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
        contractByUser[msg.sender].push(address(terc));
        emit genericERC721Deployer(msg.sender, address(terc));
    }

    function getDeployedContractAddress(address _user) public view returns (address[] memory) {
        return contractByUser[_user];
    }
}
