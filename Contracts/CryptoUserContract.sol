// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
interface CryptoPriceFeedOracle {
     function add(string memory symbol, address payable sender)  payable external returns (string memory,address,int) ;
     function getCrytoData(uint _id)  view external returns (string memory);
}

contract Contract2 {
    address CryptoOracleAddress;
    bool payment;


    constructor(address _c1)  {
        CryptoOracleAddress = _c1;
    }

    string public symbol_crypto;
    address public sender_address;
    int public _id;

    function requestAirData(string memory _symbol_crypto, address payable _sender_address) public payable returns (string memory, address, int){

        symbol_crypto = _symbol_crypto;
        sender_address = _sender_address;
        (string memory symb, address sender, int id) = CryptoPriceFeedOracle(CryptoOracleAddress).add{value:msg.value}(_symbol_crypto, _sender_address);
        return (symb,sender,id);
    }

    function getData() public view returns(string memory, address, int){
        return(symbol_crypto,sender_address, _id);
    }

    function retreiveData(uint id) public view returns(string memory){
        return CryptoPriceFeedOracle(CryptoOracleAddress).getCrytoData(id);
    }
}