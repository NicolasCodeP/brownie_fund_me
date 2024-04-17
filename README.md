# FundMe Smart Contract with Brownie - Solidity 0.8

## Introduction

**Note:** Brownie is no longer actively maintained. It is recommended for new users to consider using framework such as the [Ape framework](https://github.com/ApeWorX/ape) for smart contract development and testing.

Smart Contract Application updated to solidity >=0.8.0 <0.9.0 from Patrick Collins FreeCodeCamp course: [Solidity, Blockchain, and Smart Contract Course – Beginner to Expert Python Tutorial](https://www.youtube.com/watch?v=M576WGiDBdQ&t=27270s), with comments.

This `FundMe` smart contract project is inspired by the teachings of Patrick Collins in his blockchain and smart contract development course. It has been updated to work with Solidity version 0.8.0 and higher, incorporating best practices for smart contract development with Brownie, a Python-based development and testing framework for Ethereum.

The `FundMe` contract allows for decentralized crowdfunding, where users can contribute ETH and the contract owner can withdraw the accumulated funds. This project serves as a practical example of how to build, deploy, and test a smart contract using the latest Solidity features.

## Features

- Secure contribution functionality in compliance with Solidity 0.8.0's safety checks.
- Withdrawal capability for the contract owner with reentrancy protection.
- Contributor acknowledgement with the ability to track contributions.
- (Added) Udpate minimum amount to make a donation

## Prerequisites

To set up and interact with this project, you'll need:

- [Node.js and npm](https://nodejs.org/)
  - [Ganache](https://github.com/trufflesuite/ganache)
- [Python 3.6 or later](https://www.python.org/downloads/)
  - [Brownie](https://eth-brownie.readthedocs.io/en/stable/install.html)
- [MetaMask](https://metamask.io) with test ETH for deployment on testnets.

## Setup

Clone the repository and install the necessary Python dependencies:

```bash
git clone https://github.com/NicolasCodeP/brownie_fund_me.git
cd FundMe
pip install -r requirements.txt
```

## Configuration

Set up your environment variables in a `.env` file to store your Infura project ID and private key.
Ensure that you replace placeholders like `YourInfuraProjectId`, `YourWalletPrivateKey`, and `YourEtherscanToken` with your actual information.

```plaintext
export WEB3_INFURA_PROJECT_ID=`YourInfuraProjectId`
export PRIVATE_KEY=`YourWalletPrivateKey`
export ETHERSCAN_TOKEN=`YourEtherscanToken`
```

## Deployment

Deploy the `FundMe` contract on the Goerli test network with:

```bash
brownie run scripts/deploy.py --network goerli
```

## Contract Interaction

To contribute to the FundMe contract, use the `fund_and_withdraw.py` script:

```bash
brownie run scripts/fund_and_withdraw.py --network goerli
```

## Testing

Execute the following command to run automated tests:

```bash
brownie test
```

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

For queries, feel free to contact me at <nicolas.peteuil@protonmail.com>.

## Acknowledgments

- Patrick Collins and his educational content on Solidity and smart contract development.
- Brownie for the powerful Ethereum development framework.
- OpenZeppelin and Chainlink for their secure and reliable smart contract libraries.

```note
 ```
