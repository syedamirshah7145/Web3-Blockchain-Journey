const assert = require("assert");
const truffleAssert = require('truffle-assertions');

const StressedMonkey = artifacts.require("StressedMonkey");

contract ("StressedMonkey",(accounts) => {
    it("should credit an nft to a specific account", async() => {
        const stressedMonkey = await StressedMonkey.deployed();
        let txResult = await stressedMonkey.safeMint(accounts[1], "1.json");
        console.log(txResult.logs[0].args)
        truffleAssert.eventEmitted(txResult, "Transfer", {from:'0x0000000000000000000000000000000000000000',to : accounts[1], tokenId : web3.utils.toBN('0')});
        assert.equal(await stressedMonkey.ownerOf(0), accounts[1], "Owner not matched!");
    })
})