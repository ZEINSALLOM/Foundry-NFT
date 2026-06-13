//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {

    error MoodNft_CantFlipMood();

    uint256 private s_tokenCounter;
    string private s_sadSvgImagUri;
    string private s_happySvgImagUri;
    enum Mood{
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadsvgImagUri,
        string memory happysvgImagUri)
        ERC721("MoodNFT", "MOOD") {
        s_tokenCounter = 0;
        s_sadSvgImagUri = sadsvgImagUri;
        s_happySvgImagUri = happysvgImagUri;
    }
    function mintNft() public{
        uint256 tokenId = s_tokenCounter;
        s_tokenIdToMood[tokenId] = Mood.HAPPY;
        _safeMint(msg.sender, tokenId);
        s_tokenCounter++;

    }
    function flipMood(uint256 tokenId) public{
       if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNft_CantFlipMood();
            
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY){
            s_tokenIdToMood[tokenId] = Mood.SAD;}
            else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;}
        }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if(s_tokenIdToMood[tokenId] == Mood.HAPPY){
            imageURI = s_happySvgImagUri;
        }else{
            imageURI = s_sadSvgImagUri;
        }
        return string(
            abi.encodePacked(
                    _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                           "moode", // You can add whatever name here
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );

    }

     function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
    }