// run `node index.js` in the terminal

const ethers = require('ethers');
const axios = require('axios');

const { trafficABI } = require('../ABIs/trafficABI');
const provider = new ethers.providers.JsonRpcProvider(
  'https://api.baobab.klaytn.net:8651/'
);
const contractAddress = '0x1aa0F70bEb1F0e01BBc4dFcd1d6A3ff87a9C0c9d';
const privateKey =
  'dadb1c57bce751f58dc481b55d92838b391dfe04f8cc404b0bd05cb6e9b115e9';
const wallet = new ethers.Wallet(privateKey, provider);
const Trafficcontract = new ethers.Contract(contractAddress, trafficABI, wallet);



const oracleFunction = async () => {
    Trafficcontract.on('TrafficDataUpdated', async (first,second, sender, id) => {
    console.log('--details---', first,second, sender, id.toString());
    const First = first;
    const Second = second;
    console.log(First,Second);
      try {
        Name = (First +","+ Second);
        console.log(Name);
        const apiKey = 'yHDTTjlXGJAflzZGWyFQMx0ZFKn0xivA';
        const TrafficAPI = `https://api.tomtom.com/traffic/services/4/flowSegmentData/absolute/10/json?key=${apiKey}&point=${Name}`;
        const response = await axios.get(TrafficAPI);
        const TrafficData = response.data;
        freeFlowSpeed_ = TrafficData.flowSegmentData.freeFlowSpeed;
        currentTravelTime_ = TrafficData.flowSegmentData.currentTravelTime;
        freeFlowTravelTime_ = TrafficData.flowSegmentData.freeFlowTravelTime;
        console.log(freeFlowSpeed_,currentTravelTime_,freeFlowTravelTime_);
      } catch (e) {
        console.error(e);
    }

    const updateData = await Trafficcontract.storeTrafficData(freeFlowSpeed_ , currentTravelTime_, freeFlowTravelTime_, id)
    console.log(updateData);

  });

};

oracleFunction();
