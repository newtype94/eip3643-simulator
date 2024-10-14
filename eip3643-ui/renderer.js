// renderer.js
const Web3 = require("web3");

// 로컬 블록체인에 연결 (예: Ganache)
const web3 = new Web3("http://localhost:8545");

async function checkBalance() {
  const address = document.getElementById("address").value;
  try {
    const balance = await web3.eth.getBalance(address);
    document.getElementById(
      "balance"
    ).innerText = `Balance: ${web3.utils.fromWei(balance, "ether")} ETH`;
  } catch (error) {
    console.error(error);
    document.getElementById("balance").innerText = "Error fetching balance";
  }
}
