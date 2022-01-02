<template>
  <div class="History">
    <div class="container" v-for="account in accounts" :key="account">
      <div>
        <!-- <small>Account No: </small>
        {{ account[0] }}    {{account[1]}} -->
        <table>
          <tr>
            <td>{{account[1]}}</td>
            <td>{{account[2]}} ETH</td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import web3 from "../contracts/web3";
import auctionBox from "../contracts/auctionBoxInstance";
import auction from "../contracts/auctionInstance";
export default {
  name: "Hist",
  data() {
    return {
      accounts: [],
      list:[],
    };
  },
  // mounted() {
  //   let Web3 = require("web3");
  //   let web3 = new Web3("http://localhost:7545");
  //   var self = this;
  //   web3.eth.getAccounts().then((accounts) => {
  //     self.accounts = accounts;
  //   });
  //   console.log(web3.currentProvider);
  // },

  // mounted(){
  //   var self = this;
  //   var i = 0;
  //   auctionBox.methods.returnAllAuctions().call().then((contractAddresses)=>
  //   {
  //     const auctioninstance = auction(contractAddresses[i]);
  //     // auctioninstance.methods.returnContents().call().then((contents)=>{
  //     //   self.accounts = contents;
  //     // })
  //     self.accounts = contractAddresses;
  //     console.log(contractAddresses[i]);
  //   })    
  // }

  mounted(){
    auctionBox.methods.returnAllAuctions().call().then((contractAddresses)=>
    {
      const contract = contractAddresses;
      for(let i=0;i<contract.length;i++)
      {
        const auctioninstance = auction(contract[i]);
        auctioninstance.methods.returnContents().call()
        .then((list)=>{
          const auctionslist = list;
          const i = "0";
          // for(let j=0;j<auctionslist.length;j++)
          // {
          //   console.log("auctionslist");
          // }
          if(list[3] == '1')
          {
            this.accounts.push(list);
          }
          console.log(typeof list[3]);
          // var arraytostring = JSON.stringify(Object.assign({},list));
          // var result = JSON.parse(arraytostring);
          // console.log(result);
        })
      }
    })
    
  },
};
</script>

<style scoped>
.container {
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(3px);
  color: black !important;
  margin-top: 10px !important;
  margin-bottom: 10px !important;
  padding: 25px !important;
  border-radius: 10px;
}

small {
  color: #facb0f;
}
</style>