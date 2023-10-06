DecentralizedShop V1.1 Smart Contract User Guide
The Shop smart contract is a decentralized application (DApp) that facilitates buying and selling products on the Ethereum blockchain. This user guide will walk you through how to interact with the contract's functions.

Table of Contents
Prerequisites
Deploying the Contract
Seller Functions
Creating Products
Updating Products
Deleting Products
Buyer Functions
Placing Orders
Managing Orders
Shopping Cart
Order Tracking
Statistics
Prerequisites
Before using the Shop smart contract, ensure you have:

A compatible Ethereum wallet (e.g., MetaMask).
Sufficient Ether (ETH) in your wallet to cover transaction fees.
Deploying the Contract
Deploy the Shop smart contract using a compatible Ethereum wallet by specifying the creation fee.
Seller Functions
Creating Products
Sellers can add their products to the marketplace using the createProduct function:

solidity
Copy code
function createProduct(
    string memory sku,
    string memory name,
    string memory description,
    string memory imageURL,
    uint price,
    uint stock
) public payable returns (bool)
sku: A unique identifier for the product.
name: The name of the product.
description: A description of the product.
imageURL: URL of the product image.
price: The price of the product.
stock: The available stock quantity.
Pay the creation fee in Ether.
Updating Products
Sellers can update their product details using the updateProduct function:

solidity
Copy code
function updateProduct(
    uint id,
    string memory name,
    string memory description,
    string memory imageURL,
    uint price,
    uint stock
) public returns (bool)
id: The ID of the product to be updated.
name: The new name of the product.
description: The new description of the product.
imageURL: The new URL of the product image.
price: The new price of the product.
stock: The new available stock quantity.
Deleting Products
Sellers can mark their products as deleted using the deleteProduct function:

solidity
Copy code
function deleteProduct(uint id) public returns (bool)
id: The ID of the product to be marked as deleted.
Buyer Functions
Placing Orders
Buyers can place orders for products they wish to purchase using the createOrder function:

solidity
Copy code
function createOrder(
    uint[] memory ids,
    uint[] memory qtys,
    string memory destination,
    string memory phone
) public payable returns (bool)
ids: An array of product IDs to order.
qtys: An array of quantities corresponding to the products.
destination: The shipping destination.
phone: The contact phone number.
Pay the total order cost in Ether.
Managing Orders
Buyers and sellers can manage their orders using the following functions:

Deliver Order (Seller): Sellers can mark orders as "Delivered" using the deliverOrder function. This triggers payment to the seller.
Cancel Order (Buyer): Buyers can cancel their orders using the cancelOrder function. This initiates a refund.
Shopping Cart
Users can manage their shopping cart using the following functions:

Add to Cart: Users can add products to their shopping cart using the addToCart function.
View Cart: Users can view the contents of their shopping cart using the viewCart function.
Remove from Cart: Users can remove products from their shopping cart using the removeFromCart function.
Update Cart: Users can update the quantity of products in their shopping cart using the updateCartItem function.
Order Tracking
Ship Order (Seller): Sellers can update an order's status to "Shipped" and provide a tracking number using the shipOrder function.
Statistics
The contract keeps track of various statistics, including the number of products, orders, sellers, sales, paid amounts, and the contract's balance.

This user guide provides detailed instructions on how to use the Shop smart contract's functions for both sellers and buyers. Make sure to have a compatible Ethereum wallet and sufficient ETH to interact with the contract.




Gem-Dealer1.888
