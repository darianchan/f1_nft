# F1 NFT Specification 

## Motivation 

F1 DAO is launching a platform for super fans to rally around a singular mission: Buy a F1 Team. The first step in this process is to build a Formula 1 DAO Membership NFT. A Formula 1 DAO Membership NFT that will grant you exclusive rights and benefits as a holder. 

## Use-Case

All NFT holders will be airdropped $POINTS governance tokens when we launch in Mid 2022. Some other potential benefits include: events and parties hosted at F1 race events, special behind the scenes access with F1 drivers,  virtual watch parties hosted in discord, and more. We’d love to hear from the community (YOU) and what benefits you’d like to see - hop in the discord and let us know.

## Architecture

#### ERC-721

Different use cases can require the utilization of different NFT standards. Internally, the F1DAORegistry integrates with this token implementation allowing full assets tokenization without further requirements.

In addition to this, for asset owners with already deployed ERC-721 contracts, these external contracts can be integrated as part of the selling and accessing flows allowing the purchase of ERC-721 based NFTs and access to exclusive contents for the NFT holders.


```
await didRegistry.registerMintableDID(
                didSeed, checksum, [], url, cappedAmount, royalties, constants.activities.GENERATED, '')
await didRegistry.mint(did, 5)
await didRegistry.burn(did, 1)
await didRegistry.balanceOf(someone, did)
```

The registerMintableDID is a new method that facilitates a couple new things for users registering assets who want to attach a NFT to them:

They enable the NFT functionality for the asset registered. By default, the assets registered via the registerDID method do not have the NFTs functionality enabled.
It setups a minting cap for the asset
It specify the percentage of royalties (between 0 and 100) that the original creator of the Asset wants in the secondary market for a further sale.
When a DID is registered via the traditional registerDID method, the same functionality can be obtained calling the enableAndMintDidNft method. Example:
```
const did = await didRegistry.registerAttribute(didSeed, checksum, [], url)
await didRegistry.enableAndMintDidNft(did, 5, 0, true)
```

#### Flows

**TODO** Flow Diagram NFT Airdrop

**TODO** Flow Diagram of NFT to DAO Membership 

#### Token Structure

Metadata (Standard) 
```
{
  "name": "F1 Car #1",
  "description": "F1 CAR NFT used for F1 DAO Membership",
  "image": "ipfs://bafybeict2kq6gt4ikgulypt7h7nwj4hmfi2kevrqvnx2osibfulyy5x3hu/no-time-to-explain.jpeg"
}
```