// SPDX-License-Identifier: MIT

//TODO burn

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";


/**
* Implementation of generic ERC721 contract with Enumerable
* extension from Openzeppelin
 */
contract TERC721 is ERC721Enumerable, Ownable {
    using Strings for uint256;

    string public START_URI;
    string public END_URI;
    uint256 public PRICE_PER_TOKEN;
    uint256 public MAX_TOKENS;

    bool public MINTING_ALLOWED = false;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _startUri,
        string memory _endUri,
        uint256 _maxTokens,
        uint256 _pricePerToken
    ) ERC721(_name, _symbol) {
        setUri(0, _startUri);
        setUri(1, _endUri);

        START_URI = _startUri;
        END_URI = _endUri;
        MAX_TOKENS = _maxTokens;
        PRICE_PER_TOKEN = _pricePerToken;
    }

    function mint(uint256 _amount) public payable {
        require(MINTING_ALLOWED, "Minting is not allowed");
        require(
            totalSupply() + _amount <= MAX_TOKENS,
            "Amount exceeds max tokens"
        );
        require(msg.value >= _amount * PRICE_PER_TOKEN, "Insufficient funds");

        for (uint256 i = 0; i < _amount; i++) {
            _safeMint(msg.sender, totalSupply());
        }
    }

    function setMintingAllowed(bool _value) public onlyOwner {
        MINTING_ALLOWED = _value;
    }

    function setPricePerToken(uint256 _value) public onlyOwner {
        PRICE_PER_TOKEN = _value;
    }

    function setMaxTokens(uint256 _value) public onlyOwner {
        MAX_TOKENS = _value;
    }

    function setUri(uint8 _mode, string memory _new_uri) public onlyOwner {
        if (_mode == 0) {
            START_URI = _new_uri;
        } else if (_mode == 1) {
            END_URI = _new_uri;
        } else {
            revert("Invalid mode");
        }
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(START_URI, tokenId.toString(), END_URI)
            );
    }
}
