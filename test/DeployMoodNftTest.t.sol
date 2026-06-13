/SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test,console} from "forge-std/Test.sol";
//import {MoodNft} from "../src/MoodNft.sol";
import {DeployMoodNft} from "../script/DeployMoodNt.s.sol";

contract DeployMoodNftTest is Test{
    DeployMoodNft deployer;
    function setUp() external {
        deployer = new DeployMoodNft();
    }
    function testSvgToImgUri() public {
        string memory expected = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHZpZXdCb3g9JzAgMCAxMDAgMTAwJz48Y2lyY2xlIGN4PSc1MCcgY3k9JzUwJyByPSc0MCcgZmlsbD0ncmVkJy8+PC9zdmc+";
        string memory svg = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><circle cx='50' cy='50' r='40' fill='red'/></svg>";
        string memory actual = deployer.SvgToImgUri(svg);
        assert(keccak256(bytes(expected)) == keccak256(bytes(actual)));
    }
}