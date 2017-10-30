pragma solidity ^0.4.15;

//Интерфейс голосовалки
contract Voting {
    //Заголовок голосования
    function getTitle() public constant returns(string);

    //Описания голосования
    function getDescription() public constant returns(string);

    //Блок начала голосования
    function getStartBlockNumber() public constant returns (uint);

    //Блок окончания голосования
    function getEndBlockNumber() public constant returns (uint);

    //Количество опций выбора
    function getNumberOfOptions() public constant returns (uint);

    //Голосовать за опцию
    function voteFor(uint _optionId) public returns (bool);

    //ЗАГОЛОВОК ОПЦИИ
    function getTitleFor(uint _optionId) public constant returns (string);

    //Описания опции
    function getDescriptionFor(uint _optionId) public constant returns (string);

    //Вес опции
    function getWeightsFor(uint _optionId) public constant returns (uint);

    //Кол-во проголосовавших за опцию
    function getVotesFor(uint _optionId) public constant returns (uint);

    //Вернуть токены
    function withdrawTokens() public returns (bool);
}
