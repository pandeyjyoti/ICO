// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.7;
import "./crowdSale.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MyTokenSale is Crowdsale, Ownable {
    using SafeMath for uint256;
    uint256 preSaleSupply = 30000000;
    uint256 seedSaleSupply = 50000000;
    uint256 remainingSupply = 20000000;
    uint256 n = 10;

    //default for pre-sale
    uint256 public tokenAvailabe = preSaleSupply;
    // Stages
    enum Stages {
        PreSale,
        SeedSale,
        RemainingSale
    }
    // Default stage
    Stages public stage = Stages.PreSale;

    constructor(
        uint256 rate, // rate in TKNbits
        address payable wallet,
        IERC20 token
    ) public Crowdsale(rate, wallet, token) {}

    function _preValidatePurchase(address beneficiary, uint256 weiAmount)
        internal
        view
        override
    {
        super._preValidatePurchase(beneficiary, weiAmount);
    }

    function _getTokenAmount(uint256 weiAmount)
        internal
        view
        override
        returns (uint256)
    {
        return weiAmount.mul(rateOfToken());
    }

    function rateOfToken() public view returns (uint256) {
        if (stage == Stages.PreSale) {
            // _rate = 300000;
            return 300000;
        } else if (stage == Stages.SeedSale) {
            return 15000;
        } else if (stage == Stages.RemainingSale) {
            return 7500; // test purpose
            // return dynamic();
        }
    }

    function _processPurchase(address beneficiary, uint256 tokenAmount)
        internal
        override
    {
        require(
            tokenAmount <= tokenAvailabe * 10**18,
            "Request for less quantity "
        );
        tokenAvailabe -= tokenAmount / 10**18;
        if (tokenAvailabe == 0) {
            changeCrowdsaleStage();
        }
        super._processPurchase(beneficiary, tokenAmount);
    }

    function changeCrowdsaleStage() internal {
        if (stage == Stages.PreSale && tokenAvailabe == 0) {
            //changing stage
            stage = Stages.SeedSale;
            tokenAvailabe = seedSaleSupply;
        } else if (stage == Stages.SeedSale && tokenAvailabe == 0) {
            stage = Stages.RemainingSale;
            tokenAvailabe = remainingSupply;
        }
    }
}
