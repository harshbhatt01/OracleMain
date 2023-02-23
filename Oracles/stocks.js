// run `node index.js` in the terminal

const ethers = require('ethers');
const axios = require('axios');

const { abi } = require('../ABIs/stocksABI');
const provider = new ethers.providers.JsonRpcProvider(
  'https://api.baobab.klaytn.net:8651/'
);
const contractAddress = '0xB8820e246F5CE4e1CA0FF872771EAd6C4f1D1134';
const privateKey =
  'dadb1c57bce751f58dc481b55d92838b391dfe04f8cc404b0bd05cb6e9b115e9';
const wallet = new ethers.Wallet(privateKey, provider);
const contract = new ethers.Contract(contractAddress, abi, wallet);



const oracleFunction = async () => {
 contract.on('Updatedinput', async (name_ofStock, sender, id) => {
    console.log("Stock name: ", name_ofStock,'\n',"Sender's address: ",sender,'\n',"ID of the request: ", id.toString());
    const namex = name_ofStock;
    console.log(namex);
      try {
        Name = namex;
        console.log(Name);
        const apiKey = 'uVkr9z1EwjmDoCJyI1XjeKFBo8KF5B1m';
        const StockAPI = `https://api.polygon.io/v1/open-close/${Name}/2023-01-09?adjusted=true&apiKey=${apiKey}`
        const response =  await axios.get(StockAPI);
        const StockData = response.data;
    
        open_ = StockData.open.toString();
        high_ = StockData.high.toString();
        low_ = StockData.low.toString();
        console.log(open_,high_,low_);
      } catch (e) {
        console.error(e);
    }

    const updateData = await contract.storeStockData(open_,high_,low_, id)
    console.log(updateData);

  });

};

oracleFunction();
