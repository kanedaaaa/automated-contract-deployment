# Automated Token Deployment Script

Automated token deployment is using contract-to-contract deployment pattern, where mother contract
can deploy other various contracts. Idea is to create simple user interface where anybody can input
information about their desired token (ERC20, ERC721) and deploy them on any EVM blockchain. 

Way it works is somewhat simple: `contracts/Deployer.sol` is a mother contract, it will let users
choose template ERC from `ERC-Templates/` and provide information about name, symbol, total supply, etc.

In `ERC-Templates/` we can house any ERC contract with any custom logic. Sometimes it is required to modify
base ERC contract to achieve such funtionality, but nothing too huge. 

Also, since in Solidity it's impossible to return value externally from non-view function (state modifier funcs),
we will just throw events containing the address of child contract. It is not stored in mapping or array, just
to avoid extra gas usage, and in general, there is no real need to store them either way. 

Tests can be located in `test/` directory. 

Run test cases: `yarn/npm test`
Compile contracts: `yarn/npm compile`
