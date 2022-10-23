// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./TERC721.sol";

/**
 * Extends TERC721 with presale functionality
 */
contract TERC721Presale is TERC721 {
    uint256 PRESALE_PRICE;
    uint256 PRESALE_MAX_TOKENS;
    bool PRESALE;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _startUri,
        string memory _endUri,
        uint256 _maxTokens,
        uint256 _pricePerToken,
        uint256 _pricePerTokenForPresale,
        uint256 _maxTokensForPresale
    ) TERC721(_name, _symbol, _startUri, _endUri, _maxTokens, _pricePerToken) {
        setPricePerTokenForPresale(_pricePerTokenForPresale);    
        setMaxTokensForPresale(_maxTokensForPresale);
    }

    function presale(uint256 _amount) public payable {
        require(PRESALE, "Presale is not allowed");
        require(
            totalSupply() + _amount <= PRESALE_MAX_TOKENS,
            "Amount exceeds max tokens"
        );
        require(msg.value >= _amount * PRESALE_PRICE*(10**18), "Insufficient funds");

        for (uint256 i = 0; i < _amount; i++) {
            _safeMint(msg.sender, totalSupply());
        }
    }

    function setPricePerTokenForPresale(uint256 _value) public onlyOwner {
        PRESALE_PRICE = _value;
    }

    function setMaxTokensForPresale(uint256 _value) public onlyOwner {
        PRESALE_MAX_TOKENS = _value;
    }

    function setPresale(bool _value) public onlyOwner {
        PRESALE = _value;
    }
}
