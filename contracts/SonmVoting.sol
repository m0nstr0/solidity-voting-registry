pragma solidity ^0.4.15;

import './Voting.sol';

contract Token {
  function allowance(address owner, address spender) public constant returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function transfer(address _to, uint256 _value) public returns (bool);
}

contract SonmVoting is Voting {
  string constant TITLE = "TEST VOTING TITLE";
  string constant DESCRIPTION = "TEST VOTING DESCRIPTION";

  uint constant NUM_OF_OPTIONS = 3;

  string constant TITLE_FOR_1 = "TITLE FOR OPT 1";
  string constant TITLE_FOR_2 = "TITLE FOR OPT 2";
  string constant TITLE_FOR_3 = "TITLE FOR OPT 3";

  string constant DESCRIPTION_FOR_1 = "DESCRIPTION FOR OPT 1";
  string constant DESCRIPTION_FOR_2 = "DESCRIPTION FOR OPT 2";
  string constant DESCRIPTION_FOR_3 = "DESCRIPTION FOR OPT 3";

  uint BLOCK_START;
  uint BLOCK_END;
  Token sonmToken;

  mapping(uint => uint) votes;
  mapping(uint => uint) weights;
  mapping(address => uint) balanceOf;

  function SonmVoting(address tokenAddress, uint blockStart, uint blockEnd) {
    BLOCK_START = blockStart;
    BLOCK_END = blockEnd;
    sonmToken = Token(tokenAddress);
  }

  function getTitle() public constant returns(string) {
    return TITLE;
  }

  function getDescription() public constant returns(string) {
    return DESCRIPTION;
  }

  function getStartBlockNumber() public constant returns (uint) {
    return BLOCK_START;
  }

  function getEndBlockNumber() public constant returns (uint) {
    return BLOCK_END;
  }

  function getNumberOfOptions() public constant returns (uint) {
    return NUM_OF_OPTIONS;
  }

  function voteFor(uint _optionId) public returns (bool) {
    uint allowanceAmount = sonmToken.allowance(msg.sender, this);

    require(block.number >= BLOCK_START && block.number < BLOCK_END);
    require(allowanceAmount > 0);
    require(_optionId >= 0 && _optionId < NUM_OF_OPTIONS);
    require(sonmToken.transferFrom(msg.sender, this, allowanceAmount));

    balanceOf[msg.sender] += allowanceAmount;
    votes[_optionId] += 1;
    weights[_optionId] += allowanceAmount;
  }

  function getTitleFor(uint _optionId) public constant returns (string) {
    return (_optionId == 0) ? TITLE_FOR_1
          : (_optionId == 1) ? TITLE_FOR_2
          : (_optionId == 2) ? TITLE_FOR_3
          : "";
  }

  function getDescriptionFor(uint _optionId) public constant returns (string) {
    return (_optionId == 0) ? DESCRIPTION_FOR_1
          : (_optionId == 1) ? DESCRIPTION_FOR_2
          : (_optionId == 2) ? DESCRIPTION_FOR_3
          : "";
  }

  function getWeightsFor(uint _optionId) public constant returns (uint) {
    return weights[_optionId];
  }

  function getVotesFor(uint _optionId) public constant returns (uint) {
    return votes[_optionId];
  }

  function withdrawTokens() public returns (bool) {
    require(block.number >= BLOCK_END);
    uint balance = balanceOf[msg.sender];
    require(balance > 0);
    balanceOf[msg.sender] = 0;
    require(sonmToken.transfer(msg.sender, balance));
  }

}
