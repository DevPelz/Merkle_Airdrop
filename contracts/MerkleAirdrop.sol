//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Merkle is ERC20 {
    bytes32 public merkleRoot;

    error AlreadyClaimed();
    error NotWhitelisted();

    mapping(address => bool) claimed;

    constructor(bytes32 _root) ERC20("Merkle", "MKT") {
        merkleRoot = _root;
    }

    function claimToken(
        bytes32[] calldata _merkleProof,
        address _account,
        uint256 _amount
    ) external returns (bool) {
        if (claimed[_account]) {
            revert AlreadyClaimed();
        }
        bytes32 leaf = keccak256(abi.encodePacked(_account, _amount));
        if (!MerkleProof.verify(_merkleProof, merkleRoot, leaf)) {
            revert NotWhitelisted();
        }

        claimed[_account] = true;

        _mint(_account, _amount);
        return true;
    }
}
