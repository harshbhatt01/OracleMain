// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AirQualityOracle is Ownable{

    struct AirdataStruct{
        string _quality;
    }

    mapping(uint => AirdataStruct) public data;
    mapping(address => mapping(uint => bool) ) public isPayer;
    address public payer;

    struct idOfCity{
        uint cityID;
        address sender;
    }

    int public id = -1;
    event AirDataUpdated(uint cityID, address sender, int id);


    idOfCity[] public people;

    function add(uint cityID, address payable sender) public payable  returns (uint,address,int){
        if(!isPayer[tx.origin][cityID]){
            require(msg.value >= 1 ether,"oracle : not a payer");
            isPayer[tx.origin][cityID] = true;
        }
        people.push(idOfCity({cityID : cityID,sender : sender}));
        id++;
        emit AirDataUpdated(cityID,sender,id);
        return (cityID,sender,id);
    }

     function storeAirData(string memory quality, uint _id) onlyOwner public {
        data[_id] = AirdataStruct(quality);
    }

    function getAirData(uint _id) public view  returns (string memory){
        require(bytes(data[_id]._quality).length != 0, "Not Fetched Yet");
        return( data[_id]._quality);
    }
    
}