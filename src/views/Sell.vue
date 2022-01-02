<template>
  <div class="container 1">
    <h2>Sell</h2>
    <form @submit.prevent="createAuction()">
      <div>
        <div class="form-group">
          <label class="label">Title:</label>
          <input
            class="form-control"
            type="text"
            placeholder="title"
            required
            v-model="name"
          />
        </div>
        <div class="form-group">
          <label class="label">Starting Bid:</label>
          <input
            class="form-control"
            type="text"
            placeholder="starting price in ETH"
            required
            v-model="price"
          />
        </div>
        <div class="form-group">
          <label class="label">Description:</label>
          <textarea
            class="form-control"
            type="text"
            rows="3"
            placeholder="about the auctioned item"
            maxlength="70"
            required
            v-model="desc"
          ></textarea>
        </div>
      </div>
      <button id="btn" class="btn btn-primary" type="submit">
        Create Auction
      </button>
    </form>
  </div>
</template>

<style>
.form-group {
  margin: 15px;
}

.label {
  float: left;
}

#btn {
  background: #facb0f;
  color: black;
  width: 200px;
  border-color: #facb0f;
  border-width: 1.5px;
  border-radius: 5px;
  font-weight: 600;
}

#btn:hover {
  background: transparent;
  color: #facb0f;
}

h2 {
  text-align: left;
  font-weight: bold;
}

.card {
  background: rgba(255, 255, 255, 0.692) !important;
  backdrop-filter: blur(3px) !important;
  color: black;
  text-align: left;
  width: 270px !important;
  padding: 18px;
  margin: 15px;
  border-radius: 10px;
  font-weight: bold;
}

img {
  width: 32px;
}

#isBid,
#isFin {
  height: 32px;
  margin-top: 16px;
  margin-left: 8px;
}
</style>

<script>
import web3 from "../contracts/web3";
import auctionBox from "../contracts/auctionBoxInstance";
import auction from "../contracts/auctionInstance";

export default {
  methods: {
    createAuction() {
      //get the user address
      const address = ethereum.selectedAddress;
      console.log(address);
      // convert 'ether' to 'wei'
      let startPrice = web3.utils.toWei(this.price, "ether");
      // createAuction in AuctionBox contract
      return auctionBox.methods
        .createAuction(this.name, startPrice, this.desc)
        .send({ from: address });
      },
  },
};
</script>