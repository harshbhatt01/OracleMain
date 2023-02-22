// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
interface AirQualityOracle {
     function add(uint cityID, address payable sender)  payable external returns (uint, address,int) ;
     function getAirData(uint _id)  view external returns (string memory);
}

contract UserContract {
    address AirQualityoracleAddress;
    bool payment;


    constructor(address _c1)  {
        AirQualityoracleAddress = _c1;
    }

    uint public location_id;
    address public sender_address;
    int public _id;

    function requestAirData(uint _location_id, address payable _sender_address) public payable returns (uint, address, int){

        location_id = _location_id;
        sender_address = _sender_address;
        (uint loc_id, address sender, int id) =AirQualityOracle(AirQualityoracleAddress).add{value:msg.value}(_location_id, _sender_address);
        return (loc_id,sender,id);
    }

    function getData() public view returns(uint, address, int){
        return(location_id,sender_address, _id);
    }

    function retreiveData(uint id) public view returns(string memory){
        return AirQualityOracle(AirQualityoracleAddress).getAirData(id);
    }
}