import { ethers } from "hardhat";
import { expect } from "chai";

interface IERC721Metadata {
    name(): Promise<string>;
    symbol(): Promise<string>;
}

describe("Automated token Deployer Tests", () => {
    const deployDeployer = async () => {
        const Deployer = await ethers.getContractFactory("Deployer");
        const deployer = await Deployer.deploy();
        const [owner, user1, user2] = await ethers.getSigners();

        return { deployer, owner, user1, user2 };
    }

    describe("Generic ERC721Enumerable", async () => {
        describe("Happy Path", async () => {
            it("should deploy a generic ERC721Enumerable", async () => {
                const { deployer, owner, user1, user2 } = await deployDeployer();

                let addressArr: string[];

                await deployer.connect(user1).genericERC721("NAAAME", "SYMBOOL", "start", "json", 10, 1);

                addressArr = await deployer.getDeployedContractAddress(user1.address);

                expect(addressArr.length).to.equal(1);
            });

            it("should have correct info appended to it", async () => {
                const { deployer, user1} = await deployDeployer();

                let addressArr: string[], contractAddress: string, name: string, symbol: string;
                let tokenContract: IERC721Metadata;

                await deployer.connect(user1).genericERC721("NAAAME", "SYMBOOL", "start", "json", 10, 1);
                addressArr = await deployer.getDeployedContractAddress(user1.address);
                contractAddress = addressArr[addressArr.length - 1];

                tokenContract = await ethers.getContractAt("ERC721Enumerable", contractAddress);
                name = await tokenContract.name();
                symbol = await tokenContract.symbol();

                expect(name).to.equal("NAAAME");
                expect(symbol).to.equal("SYMBOOL");
            });
        });
    });
});