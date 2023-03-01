// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract CryptoPriceFeedOracle is Ownable{

    struct CryptoStruct{
        string _price;
    }

    mapping(uint => CryptoStruct) public data;
    mapping(address => mapping(string => bool) ) public isPayer;
    address public payer;

    struct symbolofCrypto{
        string symbol;
        address sender;
    }

    int public id = -1;
    event CrytoUpdated(string symbol, address sender, int id);


    symbolofCrypto[] public people;

    function add(string memory symbol, address payable sender) public payable returns (string memory,address,int){
        if(!isPayer[tx.origin][symbol]){
            require(msg.value >= 1 ether,"oracle : not a payer");
            isPayer[tx.origin][symbol] = true;
        }
        people.push(symbolofCrypto({symbol : symbol,sender : sender}));
        id++;
        emit CrytoUpdated(symbol,sender,id);
        return (symbol,sender,id);
    }

     function storeCryptoData(string memory price, uint _id) onlyOwner public {
        data[_id] = CryptoStruct(price);
    }

    function getCrytoData(uint _id) public view  returns (string memory){
        require(bytes(data[_id]._price).length != 0, "Not Fetched Yet");
        return( data[_id]._price);
    }
    
}