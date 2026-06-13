//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script,console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";


contract DeployMoodNft is Script{
    function run() external returns(MoodNft) {
        string memory sad=vm.readFile("./img/dynaicimg/sad.svg");
        string memory happy=vm.readFile("./img/dynaicimg/happy.svg");
        //console.log(sad);
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(SvgToImgUri(sad),SvgToImgUri(happy));
        vm.stopBroadcast();
        return moodNft;

        
    }
    function SvgToImgUri(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
        
    }
}