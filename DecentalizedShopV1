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
        // ... (previous fields)
    }

    struct OrderStruct {
        // ... (previous fields)
        string trackingNumber; // New field to store the tracking number
    }

    // ... (previous struct definitions)

    event Sale(
        // ... (previous event fields)
    );

    // ... (previous state variables)

    constructor(uint _fee) {
        // ... (previous constructor code)
    }

    function createProduct(
        // ... (previous function code)
    }

    function updateProduct(
        // ... (previous function code)
    }

    function deleteProduct(
        // ... (previous function code)
    }

    function getProduct(
        // ... (previous function code)
    }

    function getProducts(
        // ... (previous function code)
    }

    function createOrder(
        // ... (previous function code)
    }

    function totalCost(
        // ... (previous function code)
    }

    function deliverOrder(uint pid, uint id) public returns (bool) {
        // ... (previous deliverOrder code)
    }

    function cancelOrder(uint pid, uint id) public returns (bool) {
        // ... (previous cancelOrder code)
    }

    function getOrders() public view returns (OrderStruct[] memory props) {
        // ... (previous getOrders code)
    }

    function getOrder(uint pid, uint id) public view returns (OrderStruct memory) {
        // ... (previous getOrder code)
    }

    function getBuyers(uint pid) public view returns (BuyerStruct[] memory buyers) {
        // ... (previous getBuyers code)
    }

    function shipOrder(uint pid, uint id, string memory trackingNumber) public returns (bool) {
        require(orderExist[pid][id], "Order not found");
        OrderStruct storage order = ordersOf[pid][id];
        require(order.seller == msg.sender, "Unauthorized Entity");
        require(order.status == OrderEnum.PLACED, "Order cannot be shipped");
        
        order.status = OrderEnum.SHIPPED;
        order.trackingNumber = trackingNumber; // Set the tracking number

        // Emit an event or perform additional actions here if needed

        return true;
    }

    function payTo(address to, uint256 amount) internal {
        (bool success1, ) = payable(to).call{value: amount}("");
        require(success1);
    }
}
