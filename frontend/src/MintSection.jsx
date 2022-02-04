import React from "react";
import { ethers } from "ethers";

const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();

class MintSection extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      mintAmount: 1
    };

    this.connectToMetaMask = this.connectToMetaMask.bind(this);
    this.onMint = this.onMint.bind(this);
    this.onChangeMintInput = this.onChangeMintInput.bind(this);
  }

  async connectToMetaMask() {
    try {
      console.log("Signed in", await signer.getAddress());
    } catch (err) {
      console.log("Not signed in");
      await provider.send("eth_requestAccounts", []);
    }
  }

  // call whitelist mint function / main sale mint function here
  async onMint() {

  }

  onChangeMintInput(event) {
    this.setState({mintAmount: event.target.value});
  }

  render() {
    return (
      <div>
        <button onClick={this.connectToMetaMask}>Connect Wallet</button>
        <br/>
        <button>Mint</button>
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
