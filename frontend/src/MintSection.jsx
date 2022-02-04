import React from 'react';
import { ethers } from "ethers";

const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();

class MintSection extends React.Component {
  constructor(props) {
    super(props)

    this.state={}

    this.connectToMetaMask = this.connectToMetaMask.bind(this);
  }

  async connectToMetaMask() {
    try {
      console.log("Signed in", await signer.getAddress());
    } catch (err) {
      console.log("Not signed in");
      await provider.send("eth_requestAccounts", []);
    }
  }

  render() {
    return(
      <div>
        <button onClick={this.connectToMetaMask}>Connect Wallet</button>
      </div>
    )
  }
}

export default MintSection