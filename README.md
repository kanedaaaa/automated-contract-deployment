# Automated Contract Deployment Script

**REFACTOR**

With the new, much improved and minimized version of automated contract deployment script, any1 can deploy their own
token or contract with custom logic on multiple EVM chains. 

In older version, bloated and expensive contract-to-contract deployment pattern was used. But new update will make use of
`ContractFactory` from ethers that can be easily integrated into react.js project. 

`contracts/ERC-Templates` will contain all the template contracts, ready to be deployed by users. 

Tests can be located in `test/` directory. 

Run test cases: `yarn/npm test`
Compile contracts: `yarn/npm compile`
