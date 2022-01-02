<template>
  <div class="container">
    <h2>My Auctions:</h2>
    <div class="dash" id="dash">
    <div v-for="actn in actns" :key="actn">
        <div class="card">
          <p>
            Title: <b>{{ actn[1] }}</b>
          </p>
          <p>
            Price: <small>{{ actn[2] }} ETH</small>
          </p>
          <p class="desc">
            Description: <small>{{ actn[4] }}</small>
          </p>
        </div>
      </div>
    </div>
  </div>
  <hr />
  <div class="container">
    <h2>Participated Auctions:</h2>
    <div class="dash" id="dash">
    <div v-for="actn in pactns" :key="actn">
        <div class="card">
          <p>
            Title: <b>{{ actn[1] }}</b>
          </p>
          <p>
            Price: <small>{{ actn[2] }} ETH</small>
          </p>
          <p class="desc">
            Description: <small>{{ actn[4] }}</small>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.dash {
  display: grid;
  grid-template-columns: auto auto auto auto;
  min-height: 430px;
  overflow-x: hidden;
  padding: 0 !important;
}

.card {
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(3px);
  color: black;
  text-align: left;
  height: 150px;
  width: 250px;
  padding: 18px;
  margin: 15px;
  border-radius: 10px;
  font-weight: bold;
}

h5 {
  font-weight: bold;
}

p {
  overflow: hidden;
}

small {
  font-weight: lighter;
}

#btn {
  background: #facb0f;
  color: black;
  border-color: #facb0f;
  border-width: 1.5px;
  border-radius: 5px;
  font-weight: 600;
  position: absolute;
  bottom: 18px;
}

#btn:hover {
  background: transparent;
  color: #000000;
}

::-webkit-scrollbar {
  width: 8px;
  height: 10px;
  left: -100px;
  border: 20px;
}

::-webkit-scrollbar-thumb {
  border-radius: 8px;
  background: #facb0f;
}

::-webkit-scrollbar-track {
  border-radius: 8px;
  background: rgba(255, 255, 255, 0.6);
}
</style>


<script>
import web3 from "../contracts/web3";
import auctionBox from "../contracts/auctionBoxInstance";
import auction from "../contracts/auctionInstance";

export default {
  name: "Buy",
  props: {
    auctionCard: [],
  },
  data() {
    return {
      actns: [],
      pactns:[],
    };
  }, 
  async mounted(){
    if(typeof ethereum !== 'undefined'){
    const accounts = await ethereum.request({method:'eth_requestAccounts'});
    console.log(accounts[0]);
    auctionBox.methods.returnAllAuctions().call().then((contractAddresses)=>
    {
    const contract = contractAddresses;
    for(let i=0;i<contract.length;i++)
    {
    const auctioninstance = auction(contract[i]);
    auctioninstance.methods.returnContents().call()
    .then((list)=>{
    if(accounts[0].toLowerCase()==list[0].toLowerCase())
    {this.actns.push(list);}
    auctioninstance.methods.isParticipated(accounts[0]).call()
    .then((res)=>
    {
        if(res)
        {
            this.pactns.push(list);
        }
    })
    })
    }
    })
    }
    else{
    console.log('zero');
    }
  },
};
</script>