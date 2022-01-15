
# Requirements

  ## 10,000 NFT launch

  ### Pre-Sale:
  - Whitelisting ability for pre-sale 
    - suggest to do this off chain. i.e get whitelisted in a discord, have them fill out a google form with their wallet address, then we'll whitelist everyone at once. Saves gas
  - max of 5 NFT mint per wallet in pre-sale
    - what's the price for whitelisted mints?
    - is there a cap to the pre-sale? If 10k people sign up for the whitelist, are you going to let all 10k get minted?
    - can also create a function to make it dynamic if you don't know yet, but will cost you gas everytime you want to change it

  ### Main Sale:
  - max of 8 nft mint per wallet
    - if a user minted 5 nfts in the whitelisted presale, can they also mint 8 more nfts in the main sale?
  - ability to have different price for presale and main sale as well 
    - what's the price for the main sale?
    - can also create a function to make it dynamic if you don't know yet, but will cost you gas everytime you want to change it

  ### Other Features:
  - Ability to make one of one NFTs that are in addition to the 10,000 launch (i.e. we make a custom car NFT for lewis hamilton after mint)
    - we just won't put a hard 10k cap on the nft contract itself so we can add additional token id's to the collection if necessary
  - Ability to send airdrops to NFT holders
    - we can do this later on seperately. Will need to create a new erc20 contract. Then take a snapshot at a specific block and for every wallet that owns an F1 at that snapshot, we will airdrop erc20 tokens to them. (will need to look into merkel tree airdrop to do this)
  - 5% of NFTs reserved for team to promote and use to airdrop for marketing purposes
    - will put a pre sale + main sale cap limit at 9500 (reserve 500 nfts for team + marketing)
  - 5% of secondary sales are given back to f1dao (i think this is opensea functionality) 
    - need to look into it more, but yea think you can just specify the % royalties through opensea. That's why some people have been saying the royalties technically aren't enforcable because it's not done through the smart contract
  - Any other things we may need to implement to prevent us from being botted (bots purchase all nfts before real people can) 
    - look into this more - pretty important edge case
  - Deploy contract on testnet and opensea testnet first
    - we can use rinkeby testnet and test on opensea
  - I don't think we want to do this, but any thoughts around a reveal functionality of the NFT?   
    - need to look into it more. I think it's probably something with hiding/revealing the metadata. ie. hide metadata when the nft gets minted at first, and then at a specific time do a metadata reveal

  ### Minting DApp:
  - Ability to engage with Metamask 
    - get wallet address and take in a signature
  - whatever needs to happen to remain uptime for a mass audience mint and not crash 
  - Frontend of website - do you know of any great frontend web designers?
    - Not too sure, will have to look around. I know react on the frontend but definitley am not a good designer at all - will need someone else to handle this