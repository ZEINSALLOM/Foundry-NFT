// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNFTTest is Test{
    DeployBasicNft deployer;
    BasicNFT basicNft;
    address public USER = makeAddr("user");
    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }
        function testNameIsCorrect() public view{
        string memory expected = "Dogie";
        string memory actual = basicNft.name();
      //  assertEq(expected, actual);
      assert(keccak256(abi.encodePacked(expected)) == keccak256(abi.encodePacked(actual)));
    }
    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);
        assertEq(basicNft.balanceOf(USER), 1);
       // assertEq(basicNft.tokenURI(0), PUG);
       assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(PUG)));

    }


}