//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../../interfaces/ICoinLeagueSettingsV2.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// stores all settings of game
contract CoinLeagueSettingsMumbaiV2 is ICoinLeagueSettingsV2 {
    mapping(address => bool) private _chainlink_feeds;
    mapping(uint256 => bool) private _allowed_amount_players;
    mapping(uint256 => bool) private _allowed_amount_coins;
    mapping(address => bool) private _allowed_coins_to_play;
    mapping(uint256 => bool) private _allowed_amounts;
    mapping(uint256 => bool) private _allowed_amounts_stable;
    mapping(uint256 => bool) private _allowed_time_frames;
    IERC20 internal immutable BITTOKEN =
        IERC20(0x82941691fBAeE671740Ed1B6A326B45081E6a011);
    IERC20 internal immutable DEXKIT =
        IERC20(0xdf2e4383363609351637d262f6963D385b387340);
    uint256 constant HOLDING_BITT_MULTIPLIER = 200 * 10**18;
    uint256 constant HOLDING_KIT_MULTIPLIER = 50 * 10**18;

    constructor() {
        // BTC / USD
        _chainlink_feeds[0x007A22900a3B98143368Bd5906f8E17e9867581b] = true;
        // DAI / USD
        _chainlink_feeds[0x0FCAa9c899EC5A91eBc3D5Dd869De833b06fB046] = true;
        // ETH / USD
        _chainlink_feeds[0x0715A7794a1dc8e42615F059dD6e406A6594651A] = true;
        // MATIC / USD
        _chainlink_feeds[0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada] = true;
        // USDC / USD
        _chainlink_feeds[0x572dDec9087154dC5dfBB1546Bb62713147e0Ab0] = true;
        // USDT / USD
        _chainlink_feeds[0x92C09849638959196E976289418e5973CC96d645] = true;

        // Allowed Amounts
        _allowed_amounts[0.001 ether] = true;
        _allowed_amounts[0.01 ether] = true;
        _allowed_amounts[0.1 ether] = true;
        _allowed_amounts[1 ether] = true;
        _allowed_amounts[3 ether] = true;
        _allowed_amounts[5 ether] = true;
        _allowed_amounts[10 ether] = true;
        _allowed_amounts[25 ether] = true;
        _allowed_amounts[50 ether] = true;
        _allowed_amounts[100 ether] = true;
        _allowed_amounts[250 ether] = true;
        _allowed_amounts[500 ether] = true;

        // Allowed Coins to Play
        _allowed_coins_to_play[
            0xd3FC7D494ce25303BF8BeC111310629429e6cDEA
        ] = true;
        _allowed_coins_to_play[
            0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        ] = true;

        // Allowed Amounts Stable: Tether has 6 decimals on MATIC
        _allowed_amounts_stable[0.001 * 10**6] = true;
        _allowed_amounts_stable[1 * 10**6] = true;
        _allowed_amounts_stable[5 * 10**6] = true;
        _allowed_amounts_stable[10 * 10**6] = true;
        _allowed_amounts_stable[20 * 10**6] = true;
        _allowed_amounts_stable[50 * 10**6] = true;
        _allowed_amounts_stable[100 * 10**6] = true;
        _allowed_amounts_stable[250 * 10**6] = true;
        _allowed_amounts_stable[500 * 10**6] = true;
        _allowed_amounts_stable[1000 * 10**6] = true;
        _allowed_amounts_stable[2500 * 10**6] = true;
        _allowed_amounts_stable[5000 * 10**6] = true;

        // Allowed Players Amount
        _allowed_amount_players[2] = true;
        _allowed_amount_players[3] = true;
        _allowed_amount_players[5] = true;
        _allowed_amount_players[10] = true;
        _allowed_amount_players[25] = true;
        _allowed_amount_players[50] = true;
        // Allowed Amount Coins
        _allowed_amount_coins[1] = true;
        _allowed_amount_coins[2] = true;
        _allowed_amount_coins[3] = true;
        _allowed_amount_coins[5] = true;
        // Allowed Time Frames
        _allowed_time_frames[60 * 5] = true;
        _allowed_time_frames[60 * 60] = true;
        _allowed_time_frames[60 * 60 * 4] = true;
        _allowed_time_frames[60 * 60 * 8] = true;
        _allowed_time_frames[60 * 60 * 24] = true;
        _allowed_time_frames[60 * 60 * 24 * 7] = true;
        _allowed_time_frames[60 * 60 * 24 * 7 * 30] = true;
    }

    function isChainLinkFeed(address feed)
        external
        view
        override
        returns (bool)
    {
        require(feed != address(0), "No zero address feed");
        return _chainlink_feeds[feed];
    }

    function isAllowedAmountPlayers(uint256 num)
        external
        view
        override
        returns (bool)
    {
        return _allowed_amount_players[num];
    }

    function isAllowedAmountsNativeCurrency(uint256 amount)
        external
        view
        override
        returns (bool)
    {
        return _allowed_amounts[amount];
    }

    function isAllowedAmountsStableCurrency(uint256 amount)
        external
        view
        override
        returns (bool)
    {
        return _allowed_amounts_stable[amount];
    }

    function isAllowedCurrency(address coin)
        external
        view
        override
        returns (bool)
    {
        return _allowed_coins_to_play[coin];
    }

    function isAllowedAmountCoins(uint256 num)
        external
        view
        override
        returns (bool)
    {
        return _allowed_amount_coins[num];
    }

    function isAllowedTimeFrame(uint256 time)
        external
        view
        override
        returns (bool)
    {
        return _allowed_time_frames[time];
    }

    function getHouseAddress() external pure override returns (address) {
        return 0x3330b5cbdADB53e91968c6bc12E6A8c5D0C944dd;
    }

    function getEmergencyAddress() external pure override returns (address) {
        return 0xD00995A10dB2E58A1A90270485056629134B151B;
    }

    function getPrizesPlayers()
        external
        pure
        override
        returns (uint256[3] memory)
    {
        return [uint256(60), uint256(30), uint256(10)];
    }

    function getHoldingMultiplier() external view override returns (int256) {
        if (
            BITTOKEN.balanceOf(msg.sender) >= HOLDING_BITT_MULTIPLIER ||
            DEXKIT.balanceOf(msg.sender) >= HOLDING_KIT_MULTIPLIER
        ) {
            return int256(1200);
        } else {
            return int256(1200);
        }
    }

    function getChampionsMultiplier()
        external
        pure
        override
        returns (int256[8] memory)
    {
        return [
            int256(1700),
            int256(1650),
            int256(1600),
            int256(1550),
            int256(1500),
            int256(1450),
            int256(1400),
            int256(1350)
        ];
    }
}
