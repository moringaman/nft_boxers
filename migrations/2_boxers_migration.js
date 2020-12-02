const Boxers = artifacts.require("Boxers");

module.exports = function (deployer) {
  deployer.deploy(Boxers);
};
