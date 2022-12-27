// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
  function getPrice(
    AggregatorV3Interface priceFeed
  ) internal view returns (uint256) {
    // ETH in term of USD. eg: 150000000000
    (, int256 price, , , ) = priceFeed.latestRoundData();
    return uint256(price * 1e10);
  }

  function getConversionRate(
    uint256 ethAmount,
    AggregatorV3Interface priceFeed
  ) internal view returns (uint256) {
    // get eth price
    uint256 ethPrice = getPrice(priceFeed);
    // calculate eth amount to usd
    uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
    return ethAmountInUsd;
  }
}
