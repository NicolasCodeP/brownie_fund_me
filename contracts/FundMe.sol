// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @title A simple contract for decentralized crowdfunding
 * @author NicolasCodeP
 * @notice Fund your project and track contributions
 * @dev This contract has been updated to work with Solidity version 0.8.0 and above
 *
 * NOTE: SafeMath has been removed since it is obsolete for Solidity version 0.8.0 and above
 */
contract FundMe {
    /// @notice Owner of the smart contract
    /// @dev Only the owner can withdraw the funds
    /// @return owner the address of this smart contract's owner
    address public owner;

    /// @notice List of funders who contributed ETH
    /// @return funders the list of funders who contributed ETH
    address[] public funders;

    /// @notice The amount funded by each account
    /// @return amountFunded the amount funded by the queried account
    mapping(address => uint256) public addressToAmountFunded;

    /// @notice Interface using AggregatorV3Interface
    AggregatorV3Interface internal ethUsdPriceFeed;

    /**
     * @notice Deploys the smart contract
     * @param _ethUsdPriceFeed The address of a proxy aggregator contract
     * @dev Initializes the contract's deployer as the contract's owner
     *
     * Initializes an interface object named ethUsdPriceFeed using AggregatorV3Interface
     * and connects specifically to a contract already deployed at _ethUsdPriceFeed.
     *
     * NOTE: The interface allows your contract to run functions on that deployed aggregator contract.
     */
    constructor(address _ethUsdPriceFeed) {
        ethUsdPriceFeed = AggregatorV3Interface(_ethUsdPriceFeed);
        owner = msg.sender;
    }

    /**
     * @notice Funds ETH to the contract address
     * @dev Cancels transaction if the amount sent is under the minimum amount required
     */
    function fund() public payable {
        // The minimum amount is set to $50 for the example
        uint256 minimumUSD = 50 * 10 ** 18;
        require(
            getConversionRate(msg.value) >= minimumUSD,
            "You need to spend more ETH!"
        );

        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    /// @notice Returns the version of the AggregatorV3Interface
    /// @return version the version of the AggregatorV3Interface
    function getPriceFeedVersion() public view returns (uint256) {
        return ethUsdPriceFeed.version();
    }

    /**
     * @notice Returns the price of an ETH in USD
     * @dev Returns the price of an ETH in USD with precision 18
     *
     * Gets latest price rounded to the 8th decimal
     * Add 10 decimals to get price in Wei
     *
     * NOTE Solidity does not work with decimals
     *
     * @return price the price of an ETH in USD with precision 18
     */
    function getPrice() public view returns (uint256) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int256 price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = ethUsdPriceFeed.latestRoundData();
        // price = 229377529242 => $2,293.77529242 (8 Decimals)
        // price * 10 ** 10 = 2293775292420000000000
        return uint256(price * 10 ** 10);
    }

    /**
     * @notice Converts ETH amount into USD
     * @dev TODO
     * NOTE 1000000000 = 1 GWEI
     * @param ethAmount the amoutn of ETH to convert
     * @return ethAmountInUsd the amount of ETH converted in USD
     */
    function getConversionRate(
        uint256 ethAmount
    ) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / (10 ** 18);
        return ethAmountInUsd;
        // 2293775292420 ==> 0.000002293775292420 (18 decimals)
    }

    /// @notice Returns the entrance fee in Wei
    /// @dev TODO
    /// @return entranceFee the entrance fee in Wei
    function getEntranceFee() public view returns (uint256) {
        uint256 minimumUSD = 50 * 10 ** 18;
        uint256 price = getPrice();
        uint256 precision = 1 * 10 ** 18;
        return (minimumUSD * precision) / price;
    }

    /// @notice Modifier requiring ownership of the contract
    modifier onlyOwner() {
        require(msg.sender == owner, "Ownership required!");
        _;
    }

    /// @notice Transfers funds to owner and resets amount funded
    /// @dev This function can only be called by the contract's owner
    function withdraw() public payable onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}
