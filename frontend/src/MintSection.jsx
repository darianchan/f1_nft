import React from "react";
import { ethers } from "ethers";
import F1 from './F1_NFT.json';

const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();
const f1_nft = new ethers.Contract('0x96a8Ba0c177e8738b9751646c5e87E6516Bbb1c5', F1.abi, provider);

class MintSection extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      mintAmount: 1
    };

    this.connectToMetaMask = this.connectToMetaMask.bind(this);
    this.onMint = this.onMint.bind(this);
    this.onChangeMintInput = this.onChangeMintInput.bind(this);
    this.addToWhiteList = this.addToWhiteList.bind(this);
  }

  async connectToMetaMask() {
    try {
      console.log("Signed in", await signer.getAddress());
    } catch (err) {
      console.log("Not signed in");
      await provider.send("eth_requestAccounts", []);
    }
  }

  // button to demo whitelist functionality
  async addToWhiteList() {
    let tx = await f1_nft.connect(signer).addToWhiteList(['0x31306c03862D6F06193a3bAc8Ac9859A2fbea2d7']) // place holder address for demo
    let receipt = await tx.wait();

    if (receipt.status === 1) {
      console.log("whitelist successful")
    } else if (receipt.status === 0) {
      console.log("not good")
    }
  }

  async onMint() {
    let tx = await f1_nft.connect(signer).whiteListMint(1, {value: ethers.utils.parseEther(".000000000001")})
    let receipt = await tx.wait();

    if (receipt.status === 1) {
      console.log("mint successful")
    } else if (receipt.status === 0) {
      console.log("not good")
    }
  }

  onChangeMintInput(event) {
    this.setState({mintAmount: event.target.value});
  }

  render() {
    return (
      <div>
        <button onClick={this.connectToMetaMask}>Connect Wallet</button>
        <br/>
        <button onClick={this.addToWhiteList}>Whitelist</button>
        <br/>
        <button onClick={this.onMint}>Mint</button>
        <select onChange={this.onChangeMintInput}>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>
      </div>
    );
  }
}

export default MintSection;
