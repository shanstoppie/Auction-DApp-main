<template>
  <div id="nav">
    <h1 style="font-size: 50px; font-weight: bold">Auction DApp</h1>
    <h1 style="font-size: 20px; font-weight: bold color:grey">Account Id:{{msg}}</h1>
    <router-link to="/">Sell</router-link> |
    <router-link to="/buy">Buy</router-link> |
    <router-link to="/hist">History</router-link> |
    <router-link to="/db">DashBoard</router-link>
  </div>
  <router-view />
  <!-- <vue-metamask userMessage="msg" @onComplete="onComplete"> </vue-metamask> -->
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #ffffff;
}

#nav {
  padding: 10px;
}

#nav a {
  font-weight: bold;
  color: #ffffff;
}

#nav a.router-link-exact-active {
  color: #facb0f;
}
</style>

<script>
// // import VueMetamask from "vue-metamask";
// import Web3 from './contracts/web3';
// import auction from './contracts/auctionInstance';
// import auctionBox from './contracts/auctionBoxInstance';

export default {
  // components: {
  //   VueMetamask,
  // },
  data() {
    return {
      msg: '',
    };
  },  
  async mounted() {
    // let Web3 = require("web3");
    // let web3 = new Web3("http://localhost:7545");
    // var self = this;
    // self.msg=web3.eth.accounts.givenProvider.selectedAddress;
    // console.log(self.msg);
    if(typeof ethereum !== 'undefined'){
      const accounts = await ethereum.request({method:'eth_requestAccounts'})
      this.msg = ethereum.selectedAddress;
      console.log(accounts[0]);
    }
    else{
      console.log('zero');
    }

  },
};
</script>
