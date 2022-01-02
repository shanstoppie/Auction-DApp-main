let Web3 = require("web3");
let web3 = new Web3("http://localhost:7545");

if (window.ethereum) {
    window.web3 = new Web3(ethereum);
   try {
     // Request account access if needed
     ethereum.eth_requestAccounts();
   } catch (error) {
     // User denied account access...
   }
 } else if (window.web3) {
   // Legacy dapp browsers...
    window.web3 = new Web3(web3.currentProvider);
 } else {
   // Non-dapp browsers...
    web3 = new Web3.providers.HttpProvider('http://localhost:7545');
 }
console.log(web3);
export default web3;
