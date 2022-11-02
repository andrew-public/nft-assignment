// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "base64/base64.sol" as Base64Lib;
import "../src/DappCampNFT.sol";

contract DappCampNFTTest is Test {
    DappCampNFT public dappcampNFT;

    struct NFT {
        string description;
        string image;
        string name;
    }

    function substring(
        string memory str,
        uint256 startIndex,
        uint256 endIndex
    ) public pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }

    function setUp() public {
        dappcampNFT = new DappCampNFT();
    }

    function testClaimWithValidTokenId() public {
        dappcampNFT.claim(1);

        string memory tokenURI = dappcampNFT.tokenURI(1);
        uint256 tokenURILen = bytes(tokenURI).length;

        string memory metadataJson = substring(tokenURI, 29, tokenURILen);

        bytes memory base64DecodedJSON = Base64Lib.Base64.decode(metadataJson);
        string memory jsonString = string(base64DecodedJSON);
        bytes memory parsedJSON = vm.parseJson(jsonString);

        abi.decode(parsedJSON, (NFT));
    }
}
