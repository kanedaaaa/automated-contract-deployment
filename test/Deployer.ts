import { ethers } from "hardhat";
import { expect } from "chai";

describe("Deployer", () => {
    const deployDeployer = async () => { 
        const Deployer = await ethers.getContractFactory("Deployer");
        const deployer = await Deployer.deploy();
        const [owner, user1, user2] = await ethers.getSigners();

        return { deployer, owner, user1, user2 };
    }

    describe("Happy Path", () => {
        it("Should deploy the contract", async () => {
            const { deployer } = await deployDeployer();

            expect(deployer.address).to.not.be.undefined;
        });

        it("Should deploy TERC721", async () => {
            const { deployer } = await deployDeployer();

            let owner: string = "";
            let contract: string = "";

            let txn = await deployer.genericERC721("NAAAME", "SYMBOOL", "start", "json", 10, 1);
            let rec = await txn.wait();
            if (typeof rec.events != "undefined") {
                for (const event of rec.events) {
                    //owner = event.args!._deployer;
                    //contract = event.args!._contract;

                    console.log(event.args)
                }
            }

            // expect(owner).to.not.be.undefined;
            // expect(contract).to.not.be.undefined;
        });

        // it("TERC info should match", async() => {
        //     const { deployer, user2 } = await deployDeployer();

        //     let sender: string = "";
        //     let contract: string = "";

        //     let txn = await deployer.connect(user2).genericERC721("NAAAME", "SYMBOOL", "start", "json", 10, 1);
        //     let rec = await txn.wait();
        //     if (typeof rec.events != "undefined") {
        //         for (const event of rec.events) {
        //             contract = event.args!._contract;
        //             sender = event.args!._deployer;
        //         }
        //     }   

        //     const terc = await ethers.getContractAt("TERC721", contract);
        //     expect(await terc.name()).to.equal("NAME");
        //     expect(await terc.symbol()).to.equal("SYMBOL");
        //     expect(sender).to.equal(user2.address);
        // });
    });
});