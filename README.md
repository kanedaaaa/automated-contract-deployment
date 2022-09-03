# Automated Contract Deployment Script

![license](https://img.shields.io/badge/license-MIT-red?style=for-the-badge)

**REFACTOR**

With the new, much improved and minimized version of automated contract deployment script, any1 can deploy their own
token or contract with custom logic on multiple EVM chains. 

In older version, bloated and expensive contract-to-contract deployment pattern was used. But new update will make use of
`ContractFactory` from ethers that can be easily integrated into react.js project. 

`contracts/ERC-Templates` will contain all the template contracts, ready to be deployed by users. 

Tests can be located in `test/` directory. And ugh, about tests, i wrote them specifically to simulate deployment
process from for example react.js, thus using `ContractFactory` and other complicated steps, rather than hardhat
helpers.

Run test cases: `yarn/npm test`
Compile contracts: `yarn/npm compile`
