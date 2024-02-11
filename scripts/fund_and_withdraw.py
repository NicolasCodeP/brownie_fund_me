""" Fund and withdraw functions """

# pylint: disable=no-name-in-module

from brownie import FundMe

from scripts.helpful_scripts import get_account


def fund():
    """Fund the Entrance fee"""
    fund_me = FundMe[-1]
    account = get_account()
    entrance_fee = fund_me.getEntranceFee()
    print(
        f"The current entry fee is {entrance_fee} Wei ({entrance_fee / 10 ** 18} Ether)"
    )
    print("Funding")
    fund_me.fund({"from": account, "value": entrance_fee})


def withdraw():
    """Withdraw money"""
    fund_me = FundMe[-1]
    account = get_account()
    fund_me.withdraw({"from": account})


def main():
    """main"""
    fund()
    withdraw()
