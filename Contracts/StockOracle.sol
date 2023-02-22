// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Oracle is Ownable {

    struct dataStruct {
        string _open;
        string _high;      
        string _low;
    }

    mapping(uint => dataStruct) public data;
    mapping(address => mapping(string => bool) ) public isPayer;

    struct Co_ordinates {
        string name_ofStock;
        address sender;
    }


    int public id = -1;
    event Updatedinput(string name_ofStock, address sender, int id);
    
    Co_ordinates[] public people;

    function addingStockData(string memory name_ofStock, address payable sender) public payable returns (string memory,address,int){
        if(!isPayer[tx.origin][name_ofStock]){
            require(msg.value >= 1 ether,"oracle : not a payer");
            isPayer[tx.origin][name_ofStock] = true;
        }

        people.push(Co_ordinates({name_ofStock : name_ofStock,sender : sender}));
        id++;
        emit Updatedinput(name_ofStock,sender,id);     
        return (name_ofStock,sender,id);
    }


    function storeStockData(string memory open, string memory high, string memory low, uint _id) onlyOwner public {
        data[_id] = dataStruct(open,high,low);
    }

    function getStockData(uint _id) public view returns (string memory, string memory, string memory){
        return( data[_id]._open, data[_id]._high, data[_id]._low);
    }
}