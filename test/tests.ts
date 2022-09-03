import { ContractFactory } from "@ethersproject/contracts";
import { expect } from "chai";
import { ethers } from "ethers";
import { MockProvider } from "ethereum-waffle";
import fs from "fs";

const getAbiAndBytecode = (name: string): string[] => {
  const data = fs.readFileSync(
    `./artifacts/contracts/ERC-Templates/${name}.sol/${name}.json`,
    "utf-8"
  );
  const json = JSON.parse(data);
  return [JSON.stringify(json.abi), json.bytecode];
};

const deployContract = async (
  abi: string,
  bytecode: string,
  args: any,
  signer: any
): Promise<object> => {
  const factory = new ContractFactory(abi, bytecode, signer);
  const contract = await factory.deploy(...args);
  const transaction = await contract.deployTransaction.wait();
  const address = contract.address;

  return {
    contract: contract,
    transaction: transaction,
    address: address,
  };
};

describe("ERC721", async () => {
  let token: any;
  const [wallet, user] = new MockProvider().getWallets();
  const [abi, bytecode] = getAbiAndBytecode("TERC721");

  beforeEach(async () => {
    token = await deployContract(
      abi,
      bytecode,
      [
        "mockToken",
        "MT",
        "start",
        "end.json",
        10,
        1,
      ],
      wallet
    );
  });

  it("Happy Path", async () => {
    // basic info
    const name = await token.contract.name();
    const symbol = await token.contract.symbol();

    expect(name).to.equal("mockToken");
    expect(symbol).to.equal("MT");

    // mint process
    await token.contract.connect(wallet).setMintingAllowed(true);
    await token.contract
      .connect(user)
      .mint(1, { value: ethers.utils.parseEther("1.0") });

    const owner = await token.contract.ownerOf(0);
    expect(owner).to.equal(user.address);

    // token uri check
    const uri = await token.contract.tokenURI(0);
    expect(uri).to.equal("start0end.json");
  });

  it("Sad Path", async () => {});
});

describe("ERC20", async () => {
  beforeEach(async () => {});

  it("Happy Path", async () => {});

  it("Sad Path", async () => {});
});

describe("MultiSig", async () => {
  beforeEach(async () => {});

  it("Happy Path", async () => {});

  it("Sad Path", async () => {});
});
