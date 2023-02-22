// run `node index.js` in the terminal

const ethers = require('ethers');
const axios = require('axios');

const { cryptoABI } = require('../ABIs/cryptoABI');
const provider = new ethers.providers.JsonRpcProvider(
  'https://api.baobab.klaytn.net:8651/'
);
const contractAddress = '0x35A92CD1c94e399a8ccfAE49818d2CadFF441080';
const privateKey =
  'dadb1c57bce751f58dc481b55d92838b391dfe04f8cc404b0bd05cb6e9b115e9';
const wallet = new ethers.Wallet(privateKey, provider);
const Cryptocontract = new ethers.Contract(contractAddress, cryptoABI, wallet);



const oracleFunction = async () => {
    Cryptocontract.on('CrytoUpdated', async (symbol, sender, id) => {
    console.log('--details---', symbol, sender, id.toString());
    const namex = symbol;
    console.log(namex);
      try {
        Name = namex;
        console.log(Name);
        const CryptoAPI = `https://min-api.cryptocompare.com/data/price?fsym=${Name}&tsyms=USD`
          const response = await axios.get(CryptoAPI);
          const CryptoData = response.data.USD
          console.log(CryptoData);
          price_ = CryptoData.toString();
          console.log(price_);
      } catch (e) {
        console.error(e);
    }

    const updateData = await Cryptocontract.storeCryptoData(price_,id);
    console.log(updateData);

  });

};

oracleFunction();
