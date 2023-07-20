const {expect} = require('chai');
const hre = require('hardhat');



describe("StressedMonkey", function() {
    
    it("is possible to mint a token", async() => {
        const StressedMonkey = await hre.ethers.getContractFactory("StressedMonkey");
        const stressedMonkeyInstance = await StressedMonkey.deploy();
        const [owner,otherAccount] = await ethers.getSigners();
        await stressedMonkeyInstance.safeMint(otherAccount.address);
        expect(await stressedMonkeyInstance.ownerOf(0)).to.equal(otherAccount.address);
    })
})