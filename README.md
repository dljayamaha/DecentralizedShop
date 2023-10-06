# Shop Smart Contract

## Introduction

Welcome to the Shop smart contract, a decentralized e-commerce solution built on the Ethereum blockchain. This contract allows users to create, manage, and purchase products and track their orders.

## Getting Started

### Prerequisites

To interact with this smart contract, you'll need the following:

1. An Ethereum wallet (e.g., MetaMask) connected to the Ethereum mainnet or a testnet.
2. Some Ether (ETH) in your wallet to pay for gas fees.

### Deploying the Contract

To deploy the Shop smart contract:

1. Copy the contract code from `DecentralizedShop.sol`.
2. Access an Ethereum development environment like Remix or use the command-line Solidity compiler.
3. Deploy the contract, specifying the initial fee required for product creation.

### Interacting with the Contract

#### Creating a Product

To create a product, use the `createProduct` function:

```solidity
function createProduct(
    string memory sku,
    string memory name,
    string memory description,
    string memory imageURL,
    uint price,
    uint stock
) public payable returns (bool)
Provide product details, including SKU, name, description, image URL, price, and stock.
Send Ether (ETH) as payment to cover the product creation fee.
Updating a Product
Owners of products can update their details using the updateProduct function:

solidity
 
function updateProduct(
    uint id,
    string memory name,
    string memory description,
    string memory imageURL,
    uint price,
    uint stock
) public returns (bool)
Specify the product ID and new details.
Creating an Order
To place an order, use the createOrder function:

solidity
 
function createOrder(
    uint[] memory ids,
    uint[] memory qtys,
    string memory destination,
    string memory phone
) public payable returns (bool)
Provide an array of product IDs (ids), quantities (qtys), destination, and phone number.
Send enough Ether to cover the total cost of the order.
Managing Orders
Sellers can mark orders as delivered using the deliverOrder function.
Buyers can cancel orders using the cancelOrder function.
Shipping Orders
To add a tracking number to an order and mark it as "shipped," use the shipOrder function:

solidity
 
function shipOrder(uint pid, uint id, string memory trackingNumber) public returns (bool)
Specify the product ID (pid), order ID (id), and tracking number.
Retrieving Data
Use various get functions to retrieve product, order, and buyer data.
Example Usage
Here's an example of how to use the Shop smart contract:

Deploy the contract on the Ethereum blockchain.
Create products with createProduct and set their details.
Users can place orders with createOrder by specifying product IDs and quantities.
Sellers can mark orders as "shipped" using shipOrder.
Buyers or sellers can manage orders with cancelOrder or deliverOrder.
Retrieve product and order information using getProducts, getOrders, and related functions.
License
This smart contract is available under the MIT License. See the LICENSE file for details.

Acknowledgments
Special thanks to the Ethereum community and Solidity developers for their contributions to decentralized applications.
