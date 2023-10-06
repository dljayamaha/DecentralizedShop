// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Shop {
    enum OrderEnum {
        PLACED,
        DELIVERED,
        CANCELED,
        REFUNDED,
        SHIPPED // New order status for shipped orders
    }

    struct ProductStruct {
        uint id;
        string sku;
        address seller;
        string name;
        string imageURL;
        string description;
        uint price;
        uint timestamp;
        bool deleted;
        uint stock;
    }

    struct OrderStruct {
        uint pid;
        uint id;
        string sku;
        string name;
        string imageURL;
        address buyer;
        address seller;
        uint qty;
        uint total;
        uint timestamp;
        string destination;
        string phone;
        OrderEnum status;
        string trackingNumber; // New field to store the tracking number
    }

    struct CartStruct {
        uint[] productIds;
        uint[] quantities;
    }

    struct BuyerStruct {
        address buyer;
        uint price;
        uint qty;
        uint timestamp;
    }

    struct ShopStats {
        uint products;
        uint orders;
        uint sellers;
        uint sales;
        uint paid;
        uint balance;
    }

    address public owner;
    ShopStats public stats;
    uint public fee;
    ProductStruct[] public products;
    mapping(address => ProductStruct[]) public productsOf;
    mapping(uint => OrderStruct[]) public ordersOf;
    mapping(address => ShopStats) public statsOf;
    mapping(uint => BuyerStruct[]) public buyersOf;
    mapping(uint => bool) public productExist;
    mapping(uint => mapping(uint => bool)) public orderExist;
    mapping(address => CartStruct) public shoppingCarts; // Shopping carts associated with wallet addresses

    event Sale(
        uint256 id,
        address indexed buyer,
        address indexed seller,
        uint256 price,
        uint256 timestamp
    );

    constructor(uint _fee) {
        owner = msg.sender;
        fee = _fee;
    }

    function createProduct(
        string memory sku,
        string memory name,
        string memory description,
        string memory imageURL,
        uint price,
        uint stock
    ) public payable returns (bool) {
        require(msg.value >= fee, "Insufficient fund");
        require(bytes(sku).length > 0, "sku cannot be empty");
        require(bytes(name).length > 0, "name cannot be empty");
        require(bytes(description).length > 0, "description cannot be empty");
        require(bytes(imageURL).length > 0, "image URL cannot be empty");
        require(price > 0, "price cannot be zero");
        require(stock > 0, "stock cannot be zero");

        productExist[stats.products] = true;
        statsOf[msg.sender].products++;
        stats.sellers++;
        ProductStruct memory product;

        product.id = stats.products++;
        product.sku = sku;
        product.seller = msg.sender;
        product.name = name;
        product.imageURL = imageURL;
        product.description = description;
        product.price = price;
        product.stock = stock;
        product.timestamp = block.timestamp;

        products.push(product);
        return true;
    }

    function updateProduct(
        uint id,
        string memory name,
        string memory description,
        string memory imageURL,
        uint price,
        uint stock
    ) public returns (bool) {
        require(products[id].seller == msg.sender, "Unauthorized Personnel");
        require(bytes(name).length > 0, "name cannot be empty");
        require(bytes(description).length > 0, "description cannot be empty");
        require(price > 0, "price cannot be zero");
        require(stock > 0, "stock cannot be zero");

        ProductStruct memory product;
        product.id = id;
        product.seller = msg.sender;
        product.name = name;
        product.imageURL = imageURL;
        product.description = description;
        product.price = price;
        product.stock = stock;

        products[id] = product;
        updateOrderDetails(product);

        return true;
    }

    function updateOrderDetails(ProductStruct memory product) internal {
        for (uint i = 0; i < ordersOf[product.id].length; i++) {
            OrderStruct memory order = ordersOf[product.id][i];
            order.name = product.name;
            order.imageURL = product.imageURL;
            ordersOf[product.id][i] = order;
        }
    }

    function deleteProduct(uint id) public returns (bool) {
        require(products[id].seller == msg.sender, "Unauthorized Personnel");
        products[id].deleted = true;
        return true;
    }

    function getProduct(uint id) public view returns (ProductStruct memory) {
        require(productExist[id], "Product not found");
        return products[id];
    }

    function getProducts() public view returns (ProductStruct[] memory) {
        return products;
    }

    function createOrder(
        uint[] memory ids,
        uint[] memory qtys,
        string memory destination,
        string memory phone
    ) public payable returns (bool) {
        require(msg.value >= totalCost(ids, qtys), "Insufficient amount");
        require(bytes(destination).length > 0, "destination cannot be empty");
        require(bytes(phone).length > 0, "phone cannot be empty");

        stats.balance += totalCost(ids, qtys);

        for (uint i = 0; i < ids.length; i++) {
            if (productExist[ids[i]] && products[ids[i]].stock >= qtys[i]) {
                products[ids[i]].stock -= qtys[i];
                statsOf[msg.sender].orders++;
                stats.orders++;

                OrderStruct memory order;

                order.pid = products[ids[i]].id;
                order.id = ordersOf[order.pid].length; // order Id resolved
                order.sku = products[ids[i]].sku;
                order.buyer = msg.sender;
                order.seller = products[ids[i]].seller;
                order.name = products[ids[i]].name;
                order.imageURL = products[ids[i]].imageURL;
                order.qty = qtys[i];
                order.total = qtys[i] * products[ids[i]].price;
                order.timestamp = block.timestamp;
                order.destination = destination;
                order.phone = phone;
                order.status = OrderEnum.PLACED; // Initial order status

                ordersOf[order.pid].push(order);
                orderExist[order.pid][order.id] = true;

                emit Sale(order.id, order.buyer, order.seller, order.total, block.timestamp);
            }
        }

        return true;
    }

    function totalCost(uint[] memory ids, uint[] memory qtys) internal view returns (uint) {
        uint total;
        for (uint i = 0; i < ids.length; i++) {
            total += products[i].price * qtys[i];
        }
        return total;
    }

    function deliverOrder(uint pid, uint id) public returns (bool) {
        require(orderExist[pid][id], "Order not found");
        OrderStruct memory order = ordersOf[pid][id];
        require(order.seller == msg.sender, "Unauthorized Entity");
        require(order.status != OrderEnum.DELIVERED, "Order already delivered");

        order.status = OrderEnum.DELIVERED;
        ordersOf[pid][id] = order;

        stats.balance -= order.total;
        statsOf[order.seller].paid += order.total;
        statsOf[order.seller].sales++;
        stats.sales++;

        payTo(order.seller, order.total);

        buyersOf[id].push(
            BuyerStruct(order.buyer, order.total, order.qty, block.timestamp)
        );
        return true;
    }

    function cancelOrder(uint pid, uint id) public returns (bool) {
        require(orderExist[pid][id], "Order not found");
        OrderStruct memory order = ordersOf[pid][id];
        require(order.buyer == msg.sender, "Unauthorized Entity");
        require(order.status != OrderEnum.CANCELED, "Order already canceled");

        order.status = OrderEnum.CANCELED;
        products[order.pid].stock += order.qty;
        ordersOf[pid][id] = order;

        payTo(order.buyer, order.total);
        return true;
    }

    function getOrders() public view returns (OrderStruct[] memory props) {
        props = new OrderStruct[](stats.orders);

        for (uint i = 0; i < stats.orders; i++) {
            for (uint j = 0; j < ordersOf[i].length; j++) {
                props[i] = ordersOf[i][j];
            }
        }
    }

    function getOrder(uint pid, uint id) public view returns (OrderStruct memory) {
        require(orderExist[pid][id], "Order not found");
        return ordersOf[pid][id];
    }

    function getBuyers(uint pid) public view returns (BuyerStruct[] memory buyers) {
        require(productExist[pid], "Product does not exist");
        return buyersOf[pid];
    }

    function shipOrder(uint pid, uint id, string memory trackingNumber) public returns (bool) {
        require(orderExist[pid][id], "Order not found");
        OrderStruct storage order = ordersOf[pid][id];
        require(order.seller == msg.sender, "Unauthorized Entity");
        require(order.status == OrderEnum.PLACED, "Order cannot be shipped");

        order.status = OrderEnum.SHIPPED;
        order.trackingNumber = trackingNumber; // Set the tracking number

        // You can add additional logic here if needed

        return true;
    }

    function payTo(address to, uint256 amount) internal {
        (bool success1, ) = payable(to).call{value: amount}("");
        require(success1);
    }

    // Shopping cart functionality

    // Add a product to the shopping cart
    function addToCart(uint productId, uint quantity) public {
        require(productExist[productId], "Product not found");
        require(quantity > 0, "Quantity must be greater than 0");

        CartStruct storage cart = shoppingCarts[msg.sender];
        cart.productIds.push(productId);
        cart.quantities.push(quantity);
    }

    // View the contents of the shopping cart
    function viewCart() public view returns (uint[] memory, uint[] memory) {
        CartStruct storage cart = shoppingCarts[msg.sender];
        return (cart.productIds, cart.quantities);
    }

    // Remove a product from the shopping cart
    function removeFromCart(uint index) public {
        CartStruct storage cart = shoppingCarts[msg.sender];
        require(index < cart.productIds.length, "Invalid index");

        // Remove the selected item from the cart
        for (uint i = index; i < cart.productIds.length - 1; i++) {
            cart.productIds[i] = cart.productIds[i + 1];
            cart.quantities[i] = cart.quantities[i + 1];
        }
        cart.productIds.pop();
        cart.quantities.pop();
    }

    // Update the quantity of a product in the shopping cart
    function updateCartItem(uint index, uint newQuantity) public {
        CartStruct storage cart = shoppingCarts[msg.sender];
        require(index < cart.productIds.length, "Invalid index");
        require(newQuantity > 0, "Quantity must be greater than 0");

        cart.quantities[index] = newQuantity;
    }
}
