pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

//Реестр голосовалки
contract VotingRegistry is Ownable {
    uint public numberOfVoting;
    address[] votings;

    event VotingAdded(address _votingAddress, uint id);

    function addVoting(address _votingAddress) public onlyOwner returns (uint) {
        uint id = votings.length ++;
        votings[id] = _votingAddress;
        numberOfVoting = id + 1;
        VotingAdded(_votingAddress, id);
        return id;
    }

    function getVoting(uint _votingId) public constant returns (address) {
        require(_votingId >= 0 && _votingId < votings.length);
        return votings[_votingId];
    }
}
