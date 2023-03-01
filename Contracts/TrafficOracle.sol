// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TrafficDataOracle is Ownable{

    struct TrafficdataStruct{
        uint _freeFlowSpeed;
        uint _currentTravelTime;
        uint _freeFlowTravelTime;
    }

    mapping(uint => TrafficdataStruct) public data;
    mapping(address => mapping(string => bool) ) public isPayer;
    address public payer;

    struct Co_ordinates{
        string first;
        string second;
        address sender;
    }

    int public id = -1;
    event TrafficDataUpdated(string first, string second, address sender, int id);


    Co_ordinates[] public people;

    function add(string memory first,string memory second, address payable sender) public payable returns (string memory,string memory,address,int){

        if(!isPayer[tx.origin][first]){
            require(msg.value >= 1 ether,"oracle : not a payer");
            isPayer[tx.origin][first] = true;
        }
        people.push(Co_ordinates({first : first, second: second, sender : sender}));
        id++;
        emit TrafficDataUpdated(first,second,sender,id);
        return (first,second,sender,id);
    }

     function storeTrafficData(uint freeFlowSpeed, uint currentTravelTime,uint freeFlowTravelTime, uint _id) onlyOwner public {
        data[_id] = TrafficdataStruct(freeFlowSpeed,currentTravelTime,freeFlowTravelTime);
    }

    function getTrafficData(uint _id) public view returns (uint,uint,uint){
        require(uint(data[_id]._freeFlowSpeed) != 0 && uint(data[_id]._currentTravelTime) != 0 && uint(data[_id]._freeFlowTravelTime) != 0, "Not Fetched Yet");
        return( data[_id]._freeFlowSpeed, data[_id]._currentTravelTime, data[_id]._freeFlowTravelTime);
    }
    
}