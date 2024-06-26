""" Test fundMe Solidity contract"""

import pytest
from brownie import accounts, exceptions, network
from scripts.deploy import deploy_fund_me
from scripts.helpful_scripts import LOCAL_BLOCKCHAIN_ENVIRONMENTS, get_account


def test_can_fund_and_withdraw():
    """Test fund and withdraw"""
    account = get_account()
    fund_me = deploy_fund_me()
    eth_price = fund_me.getPrice()
    print(f"ETH/USD price (18 decimals): {eth_price}")
    entrance_fee = fund_me.getEntranceFee() + 100
    print(f"Entrance fee (Wei): {entrance_fee}")
    tx = fund_me.fund({"from": account, "value": entrance_fee})
    tx.wait(1)  # Wait for next bock
    assert fund_me.addressToAmountFunded(account.address) == entrance_fee
    tx2 = fund_me.withdraw({"from": account})
    tx2.wait(1)
    assert fund_me.addressToAmountFunded(account.address) == 0


def test_only_owner_can_withdraw():
    """Test withdraw method"""
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("only for local testing")
    fund_me = deploy_fund_me()
    bad_actor = accounts.add()
    with pytest.raises(exceptions.VirtualMachineError):
        fund_me.withdraw({"from": bad_actor})
