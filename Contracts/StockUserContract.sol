// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface Oracle {
     function addingStockData(string memory name_ofStock, address payable sender)  payable external returns (string memory,address,int) ;
     function getStockData(uint _id)  view external returns (string memory, string memory, string memory);
}

contract Contract2 {
    address oracleAddress;
    bool payment;


    constructor(address _c1)  {
       oracleAddress = _c1;
    }

    string public stock_symbol;
    address public sender_address;
    int public _id;

    function requestStockData(string memory _stock_symbol, address payable _sender_address) public payable returns (string memory, address, int){

        stock_symbol = _stock_symbol;
        sender_address = _sender_address;
        (string memory symbol, address sender, int id) = Oracle(oracleAddress).addingStockData{value:msg.value}(_stock_symbol, _sender_address);
        return (symbol,sender,id);
    }

    function getData() public view returns(string memory, address, int){
        return(stock_symbol,sender_address, _id);
    }

    function retreiveData(uint id) public view returns(string memory, string memory,string memory){
        return Oracle(oracleAddress).getStockData(id);
    }
}