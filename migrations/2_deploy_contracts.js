const testContract = artifacts.require("testingContract");

module.exports = function (deployer) {
    deployer.deploy(testContract);
}