// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OrganDonation {
    // Define a structure to represent a donor
    struct Donor {
        string name;
        string bloodType;
        string organ;
        bool isRegistered;
    }

    // Define a structure to represent a recipient
    struct Recipient {
        string name;
        string bloodType;
        string organ;
        bool isRegistered;
    }

    // Mapping to store registered donors
    mapping(address => Donor) public donors;

    // Mapping to store registered recipients
    mapping(address => Recipient) public recipients;

    // Event to be emitted when a new donor is registered
    event DonorRegistered(address donorAddress, string name, string bloodType, string organ);

    // Event to be emitted when a new recipient is registered
    event RecipientRegistered(address recipientAddress, string name, string bloodType, string organ);

    // Function to register a new donor
    function registerDonor(string memory _name, string memory _bloodType, string memory _organ) public {
        require(!donors[msg.sender].isRegistered, "Donor is already registered.");
        
        donors[msg.sender] = Donor({
            name: _name,
            bloodType: _bloodType,
            organ: _organ,
            isRegistered: true
        });

        emit DonorRegistered(msg.sender, _name, _bloodType, _organ);
    }

    // Function to register a new recipient
    function registerRecipient(string memory _name, string memory _bloodType, string memory _organ) public {
        require(!recipients[msg.sender].isRegistered, "Recipient is already registered.");
        
        recipients[msg.sender] = Recipient({
            name: _name,
            bloodType: _bloodType,
            organ: _organ,
            isRegistered: true
        });

        emit RecipientRegistered(msg.sender, _name, _bloodType, _organ);
    }

    // Function to match a donor with a recipient
    function matchDonorRecipient(address donorAddress, address recipientAddress) public view returns (bool) {
        require(donors[donorAddress].isRegistered, "Donor is not registered.");
        require(recipients[recipientAddress].isRegistered, "Recipient is not registered.");
        
        if (keccak256(abi.encodePacked(donors[donorAddress].bloodType)) == keccak256(abi.encodePacked(recipients[recipientAddress].bloodType)) &&
            keccak256(abi.encodePacked(donors[donorAddress].organ)) == keccak256(abi.encodePacked(recipients[recipientAddress].organ))) {
            return true;
        } else {
            return false;
        }
    }
}