var VotingRegistry = artifacts.require("./VotingRegistry.sol");
var SonmVoting = artifacts.require("./SonmVoting.sol");

module.exports = function(deployer) {
  var SNM = "0x225b929916daadd5044d5934936313001f55d8f0";
  var BLOCK_START = 1120968;
  var BLOCK_END = 3120968;
  var from = "0x57e93c80745cba50cf2cf8f3a7ba7ee0d32ce79b";

  deployer.deploy(SonmVoting, SNM, BLOCK_START, BLOCK_END).then(function() {
    return deployer.deploy(VotingRegistry);
  }).then(function() {
    VotingRegistry.deployed().then(function(instance) {
        return instance.addVoting(SonmVoting.address, {from: from});
    });
  });
};
