<template>
  <div class="container">
    <div class="Buy" id="Buy" v-show="true">
      <div v-for="actn in actns" :key="actn">
        <div class="card">
          <p>
            Title: <small>{{ actn[1] }}</small>
          </p>
          <p>
            Price: <small>{{ actn[2] }} ETH</small>
          </p>
          <p class="desc">
            Description: <small>{{ actn[4] }}</small>
          </p>
          <input type="text" v-model="bidprice">
          <button
            id="btn"
            class="btn btn-primary"
            style="width: 211px !important"
            @click='handleSubmit(actn[5])'
          >
            Bid
          </button>
        </div>
      </div>

      <!-- <hr />
      <b-card-group columns class="mb-3">
        <b-card
          :title="auctionCard[0]"
          :sub-title="'Start Price:' + auctionCard[1] + 'ETH'"
          tag="article"
          style="max-width: 20rem"
          class="mb-2"
        >
          <hr />
          <p class="card-text, mt-3">
            {{ auctionCardDev[2] }}
          </p>
          <p class="card-text, mt-3">Bidders: {{ bidders }}</p>
          <div>
            <form @submit.prevent="handleSubmit()">
              <b-input-group>
                <b-form-input v-model="bidPrice" />
                <b-input-group-append>
                  <button>place BID</button>
                  <img
                    v-show="isBid"
                    id="isBid"
                    src="https://media.giphy.com/media/2A6xoqXc9qML9gzBUE/giphy.gif"
                  />
                </b-input-group-append>
              </b-input-group>
            </form>
          </div>
          <b-button
            class="mt-3"
            variant="outline-success"
            @click="handleFinalize()"
          >
            {{ finalizeStatus }}
          </b-button>
          <img
            v-show="isFin"
            id="isFin"
            src="https://media.giphy.com/media/2A6xoqXc9qML9gzBUE/giphy.gif"
          />
        </b-card>
      </b-card-group> -->
    </div>
  </div>
</template>

<style scoped>
.Buy {
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
  height: 300px;
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
import Sell from '../views/Sell.vue';
import web3 from "web3";
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
      auctions:[],
      bidprice:'',
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
          const auctions = list;
          if(accounts[0].toLowerCase()!=auctions[0].toLowerCase())
          {
            auctions[5] = contract[i];
            console.log(auctions[5]);
            this.actns.push(auctions);
          }
        })
      }
    })
     }
          else{
            console.log('zero');
          }
    
  },
  methods: {
    handleSubmit(id) {
      console.log(ethereum.selectedAddress);
      const auctioninstance = auction(id);
      let bidpricewei = web3.utils.toWei(this.bidprice,'ether');
      console.log(bidpricewei);
      auctioninstance.methods.placeBid(bidpricewei)
      .send({from:ethereum.selectedAddress,});  
    },
  },
};
</script>
