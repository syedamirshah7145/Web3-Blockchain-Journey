const StressedMonkey = artifacts.require('StressedMonkey');

module.exports = function(deployer,network,accounts) {
    deployer.deploy(StressedMonkey,{from : accounts[0]});
}