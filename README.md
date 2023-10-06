Shop Smart Contract
This is a Solidity smart contract that facilitates a simple e-commerce platform with various features. Below are the key features of this smart contract and instructions on how to use them.

Features
1. Product Management
Create a Product: Sellers can create new products with details such as SKU, name, description, image URL, price, and stock.

Update a Product: Sellers can update product details, including name, description, image URL, price, and stock.

Delete a Product: Sellers can mark a product as deleted.

Get Product Information: Anyone can retrieve detailed information about a product.

2. Order Management
Create an Order: Buyers can create orders by specifying the products they want to purchase, quantities, destination, and contact information.

View Orders: Buyers and sellers can view their respective orders.

Cancel an Order: Buyers can cancel their orders.

Deliver an Order: Sellers can mark an order as delivered.

Get Order Information: Anyone can retrieve detailed information about an order.

3. Shopping Cart
Add Products to Cart: Buyers can add products to their shopping cart.

Remove Products from Cart: Buyers can remove products from their shopping cart.

Update Product Quantities in Cart: Buyers can update the quantities of products in their shopping cart.

Checkout: Buyers can checkout and create an order from the items in their cart.

4. NFT Ownership Discounts
Set NFT Ownership Discounts: Sellers can set discounts for buyers who own specific NFTs. The seller can specify the NFT contract address and the discount amount.

Claim NFT Discount: Buyers can claim their NFT ownership discount.

Apply NFT Discount at Checkout: The NFT discount is applied automatically at checkout if the buyer has claimed it.

How to Use
Product Management
Create a Product:

Use the createProduct function, providing details such as SKU, name, description, image URL, price, and stock.
Update a Product:

Use the updateProduct function, specifying the product ID and updated details.
Delete a Product:

Use the deleteProduct function, specifying the product ID.
Get Product Information:

Use the getProduct function, specifying the product ID, to retrieve product details.
Order Management
Create an Order:

Use the createOrder function, providing an array of product IDs, quantities, destination, and contact information.
View Orders:

Use the getOrders function to view all orders.

Use the getOrder function, specifying the product ID and order ID, to view details of a specific order.

Cancel an Order:

Use the cancelOrder function, specifying the product ID and order ID.
Deliver an Order:

Use the deliverOrder function, specifying the product ID and order ID.
Shopping Cart
Add Products to Cart:

Use the addToCart function, specifying the product ID and quantity.
Remove Products from Cart:

Use the removeFromCart function, specifying the product ID.
Update Product Quantities in Cart:

Use the updateCartQuantity function, specifying the product ID and new quantity.
Checkout:

Use the checkout function to create an order from the items in your cart.
NFT Ownership Discounts
Set NFT Ownership Discounts (Sellers Only):

Use the addNFTDiscount function to set NFT ownership discounts by specifying the NFT contract address and discount amount.
Claim NFT Discount (Buyers Only):

Use the claimNFTDiscount function to claim your NFT ownership discount.
Apply NFT Discount at Checkout:

The NFT discount will be applied automatical
