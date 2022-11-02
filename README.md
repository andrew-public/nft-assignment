# On-Chain NFT Assignment

The goal of this exercise is to develop an on-chain NFT collection and host it on opensea.

A base contract is given here - `src/DappCampNFT.sol`. Use this contract to create your own NFT collection. Complete the following functions:

- The collection array can contain the different texts or attributes you want to randomize for SVG image. You can choose different texts or attributes for this collection based on your creativity.

- `random(string memory input)`: Given an input string(`input`), it should return a random number. This random number should be deterministic with the input value. Given same input it should return same random number each time

- `pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray)`: It should generate a random number using both `keyPrefix` and `tokenId` and then pick and return an element from the given `sourceArray` containing multiple elements. Here `keyPrefix` can be any string representing what type of collection you are picking from and `sourceArray` is the array of that collection items (called `collection` in our contract).

  For example, in `DeveloperDAO` [contract](https://github.com/Developer-DAO/developer-dao-nft-contract/blob/master/hh/contracts/Dev.sol) refer to `getOS` function, here `keyPrefix` is "OS" since it is representing the type of collection they are picking from and `sourceArray` is "osses" which is an array containing os names

- `tokenURI(uint256 tokenId)`: This function should use the pluck and random functions defined above to generate a unique NFT metadata for each tokenId. It should return a string containing base64 json data which further contains base64 encoded svg image. An example data has been broken down for you below

  - Returned value from tokenURI function -

    `data:application/json;base64,eyJuYW1lIjogIkNvbG9yICMxIiwgImRlc2NyaXB0aW9uIjogIkJyaW5nIGNvbG9ycyB0byBsaWZlLiIsICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBeE1EQWdNVEF3SWo0OGNtVmpkQ0IzYVdSMGFEMGlNVEF3SWlCb1pXbG5hSFE5SWpFd01DSWdabWxzYkQwaVlteDFaU0lnTHo0OEwzTjJaejQ9In0=`

  - Here the prefix `data:application/json;base64,` is followed by base64 json data which decodes into following -

    `{"name": "Color #1", "description": "Bring colors to life.", "image": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAxMDAgMTAwIj48cmVjdCB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgZmlsbD0iYmx1ZSIgLz48L3N2Zz4="}`

  - The `image` field of the json above is a base64 encoded SVG prefixed with `data:image/svg+xml;base64,`. On decoding the base64 SVG you get:

    `<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 100 100"><rect width="100" height="100" fill="blue" /></svg>`

  - You can use [base64decode.com](https://www.base64decode.org/) to decode base64 strings and use [svgviewer.dev](https://www.svgviewer.dev/) to view the svg image

## Evaluation

- Clone this repo
  ```
  git clone CLONE_URL
  ```
- Install the submodules

  ```
  forge install foundry-rs/forge-std openzeppelin/openzeppelin-contracts Brechtpd/base64 --no-commit
  ```

- Create a new branch with your name. You can use the following command:

  ```
  git checkout -b my-name
  ```

- Make changes to the `src/DappCampNFT.sol` file. The tests in `test/DappCampNFT.t.sol` should run successfully.

- Run Tests
  ```
  forge test
  ```
- Create a pull request from your forked repo to main branch of original repo to run the github workflow.

## Deployment

Follow these steps to deploy to your desired network:

- Rename `.env.example` to `.env` file.

- Add values for `PRIVATE_KEY` and `ETHERSCAN_KEY` variables in `.env` file.

- Get an rpc url of your desired network, this can be obtained by creating an account on [Alchemy](https://www.alchemy.com/). Replace `eth_rpc_url` in `foundry.toml` with the rpc url from Alchemy.

- Run the following command to deploy

  ```bash
  forge script script/DappCampNFT.s.sol:DeployScript --broadcast
  ```

- Alternatively, to also verify the contract on etherscan, you can run the following command

  ```
  source .env && forge script script/DappCampNFT.s.sol:DeployScript --broadcast --etherscan-api-key $ETHERSCAN_KEY --verify
  ```

- Once deployed, you can view your NFT collection on OpenSea. If you deployed on the Goerli testnet, you can substitue your `CONTRACT_ADDRESS` and `TOKEN_ID` in the below URL to view the NFT on OpenSea.

  ```
  https://testnets.opensea.io/assets/CONTRACT_ADDR/TOKEN_ID
  ```

## Note

- To understand the concept of on-chain NFTs better take a look `DeveloperDAO` contract [here](https://github.com/Developer-DAO/developer-dao-nft-contract/blob/master/hh/contracts/Dev.sol)
