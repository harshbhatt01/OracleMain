// run `node index.js` in the terminal

const ethers = require('ethers');
const axios = require('axios');

const { airQualityABI } = require('../ABIs/airQualityABI');
const provider = new ethers.providers.JsonRpcProvider(
  'https://api.baobab.klaytn.net:8651/'
);
const contractAddress = '0xaf19d2e200629024307dFd7494e68702761C4090';
const privateKey =
  'dadb1c57bce751f58dc481b55d92838b391dfe04f8cc404b0bd05cb6e9b115e9';
const wallet = new ethers.Wallet(privateKey, provider);
const AirQualitycontract = new ethers.Contract(contractAddress, airQualityABI, wallet);



const oracleFunction = async () => {
    AirQualitycontract.on('AirDataUpdated', async (cityID, sender, id) => {
    console.log('--details---', cityID.toString(), sender, id.toString());
    const namex = cityID.toString();
    console.log(namex);
      try {
        Name = namex.toString();
        console.log(Name);
        const apiKey = 'OBkMF3NSKDpiQiay2yt6hEevco5uPYkl';
        const AirQualityAPI = `http://dataservice.accuweather.com/forecasts/v1/daily/1day/${Name}?apikey=${apiKey}&details=true`;
        const response = await axios.get(AirQualityAPI);
        const AirQualityData = response.data;
         Air = AirQualityData.DailyForecasts[0].AirAndPollen[0].Category
        //console.log(AirQualityData.DailyForecasts);
        console.log(Air);
      } catch (e) {
        console.error(e);
    }
    const air = Air;
    console.log(air);

    const updateData = await AirQualitycontract.storeAirData(Air,id);
    console.log(updateData);

  });

};

oracleFunction();
