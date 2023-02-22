// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;



interface TrafficDataOracle {
     function add(string memory first,string memory second, address payable sender)  payable external returns (string memory,string memory, address,int) ;
     function getTrafficData(uint _id)  view external returns (uint,uint,uint);
}

contract Contract2 {
    address TrafficoracleAddress;
    bool payment;


    constructor(address _c1)  {
        TrafficoracleAddress = _c1;
    }

    string first;
    string second;
    address public sender_address;
    int public _id;

    function requestAirData(string memory _first,string memory _second, address payable _sender_address) public payable returns (string memory,string memory, address, int){

        first = _first;
        second = _second;
        sender_address = _sender_address;
        (string memory fist, string memory sec, address sender, int id) =TrafficDataOracle(TrafficoracleAddress).add{value:msg.value}(_first,_second, _sender_address);
        return (fist,sec,sender,id);
    }

    function getData() public view returns(string memory,string memory, address, int){
        return(first,second,sender_address, _id);
    }

    function retreiveData(uint id) public view returns(uint, uint, uint){
        return TrafficDataOracle(TrafficoracleAddress).getTrafficData(id);
    }
}