Decentralized Shop Smart Contract V1.1
Overview
The Shop smart contract is a decentralized application (DApp) that allows users to buy and sell products. It includes features such as product creation, order placement, order tracking, and a shopping cart. The contract is designed to be easy to use and transparent, providing a secure platform for e-commerce on the Ethereum blockchain.

Features
Product Management
Create Product: Sellers can create new products with details such as SKU, name, description, image URL, price, and stock. A fee must be paid to create a product.

Update Product: Sellers can update the details of their existing products, including name, description, image URL, price, and stock.

Delete Product: Sellers can mark a product as deleted, effectively removing it from the marketplace.

View Products: Anyone can view the list of available products.

Order Management
Create Order: Buyers can place orders for products, specifying the quantity and destination. Orders require payment, and the total cost is calculated based on the selected products and quantities.

Deliver Order: Sellers can mark orders as "Delivered" once the products are shipped. This action triggers payment to the seller and updates the order status.

Cancel Order: Buyers can cancel their orders, resulting in a refund and returning the purchased quantity to the product's stock.

View Orders: Users can view their order history and check order status.

Shopping Cart
Add to Cart: Users can add products to their shopping cart by specifying the product ID and quantity.

View Cart: Users can view the contents of their shopping cart, including product IDs and quantities.

Remove from Cart: Users can remove products from their shopping cart by specifying the index of the item in the cart.

Update Cart: Users can update the quantity of products in their shopping cart.

Order Tracking
Ship Order: Sellers can update an order's status to "Shipped" and provide a tracking number. This functionality enables buyers to track their orders.
Statistics
The contract keeps track of various statistics, including the number of products, orders, sellers, sales, paid amounts, and the contract's balance.
Usage
Deploying the Contract
To deploy the Shop contract, specify the creation fee during deployment. The deploying address becomes the owner of the contract.

Creating Products
Sellers can create products by calling the createProduct function, providing product details and paying the creation fee.

Managing Products
Sellers can update or delete their products using the respective functions. Deleted products are marked as such but remain in the contract's storage.

Placing Orders
Buyers can place orders by calling the createOrder function, specifying the product IDs, quantities, destination, and phone number. Orders require payment.

Managing Orders
Sellers can mark orders as "Delivered" to trigger payment and update order status. Buyers can cancel orders to receive refunds.

Shopping Cart
Users can manage their shopping cart by adding, viewing, updating, or removing items.

Order Tracking
Sellers can update order status to "Shipped" and provide tracking numbers for buyer reference.

Statistics
The contract tracks various statistics, providing insights into the marketplace's performance.

Development
The Shop smart contract can be further enhanced with additional features and improvements. Developers can contribute to its development by implementing new functionalities or optimizing existing ones.

Disclaimer
This smart contract is provided as-is, without warranties or guarantees. Use it at your own risk and make sure to thoroughly test it before deploying on the Ethereum blockchain.

Gem-Dealer1.888
