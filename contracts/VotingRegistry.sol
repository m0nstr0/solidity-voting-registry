pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

//Реестр голосовалки
contract VotingRegistry  {
    uint public numberOfVoting;
    address[] public votings;

    event VotingAdded(address _votingAddress, uint id);

    function addVoting(address _votingAddress) public  returns (uint) {
        uint id = votings.length ++;
        votings[id] = _votingAddress;
        numberOfVoting = id + 1;
        VotingAdded(_votingAddress, id);
        return id;
    }

    function getVotings() public constant returns (address[]) {
        return votings;
    }
}
