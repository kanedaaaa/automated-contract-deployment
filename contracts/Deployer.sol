// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./ERC-Templates/TERC721.sol";
import "./ERC-Templates/TERC20.sol";
import "./ERC-Templates/TMultiSig.sol";

/**
* Deployer contract. Will deploy template ERC's with 
* provided information.
 */

contract Deployer {
    constructor() {}
    
    mapping(address => address[]) private contractByUser;

    event genericERC721Deployer(address _deployer, address _contract);
    event genericERC20Deployer(address _deployer, address _contract);
    event multisigDeployer(address _deployer, address _contract);

    /**
    * @notice generic ERC721 stands for ERC721Enumerable
    * @param _name -> including symbol, startURi, etc: standard
    * ERC721 information
    *
    * Will deploy template ERC721 with given info. 
     */
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

    function genericERC20( 
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        bool _cap,
        bool _burn
    ) public {
        TERC20 terc = new TERC20(
            _name,
            _symbol,
            _totalSupply,
            _cap,
            _burn
        );
        contractByUser[msg.sender].push(address(terc));
        emit genericERC20Deployer(msg.sender, address(terc));
    }

    function MultiSig(
        address[] memory _owners, 
        uint256 _numConfirmationsRequired
    ) public {
        TMultiSig tmultisig = new TMultiSig(
            _owners,
            _numConfirmationsRequired
        );

        contractByUser[msg.sender].push(address(tmultisig));
        emit multisigDeployer(msg.sender, address(tmultisig));
    }

    /**
    * @notice for the sake of testing, there is no actual production
    * need to have it. 
     */
    function getDeployedContractAddress(address _user) public view returns (address[] memory) {
        return contractByUser[_user];
    }
}
