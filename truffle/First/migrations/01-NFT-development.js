const StressedMonkey = artifacts.require('StressedMonkey');

module.exports = function(deployer) {
    deployer.deploy(StressedMonkey);
}