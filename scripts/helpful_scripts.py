""" Helpful script functions """

# pylint: disable=no-name-in-module
from brownie import MockV3Aggregator, accounts, config, network

# from web3 import Web3

FORKED_LOCAL_ENVIRONMENTS = ["mainnet-fork-dev"]
LOCAL_BLOCKCHAIN_ENVIRONMENTS = ["development", "ganache-local"]

# Used to harcode price directly: 2000,00000000
DECIMAL = 8
STARTING_PRICE = 200000000000

# Used with Web3.toWei function
# DECIMAL = 18
# STARTING_PRICE = 2000


def get_account():
    """Return account"""
    if (
        network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS
        or network.show_active() in FORKED_LOCAL_ENVIRONMENTS
    ):
        return accounts[0]
    return accounts.add(config["wallets"]["from_key"])


def deploy_mocks():
    """Deploy moc"""
    print(f"THe active network is {network.show_active()}")
    print("Deploying Mocks...")
    if len(MockV3Aggregator) <= 0:
        MockV3Aggregator.deploy(
            # DECIMAL, Web3.toWei(STARTING_PRICE, "ether"), {"from": get_account()}
            DECIMAL,
            STARTING_PRICE,
            {"from": get_account()},
        )
    print("Mocks Deployed!")
