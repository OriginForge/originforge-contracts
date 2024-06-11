// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct User {
    string name;
    uint tokenId;
    //equpiment
    //inventory
    //stats
}

struct Item {
    uint itemId;
    uint price;
}

struct AppStorage {
    mapping(string => address) contracts;
    mapping(address => User) users;
    mapping(uint => Item) items;
}
