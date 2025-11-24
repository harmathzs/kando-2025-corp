public with sharing class OrderTriggerHandler {
    public static void handleAfterUpdateOrder(Map<Id,SObject> oldMap, Map<Id,SObject> newMap) {
        Order[] orders = new List<Order>();
        for (Id id: oldMap.keySet()) {
            Order oldOrder = (Order) oldMap.get(id);
            Order newOrder = (Order) newMap.get(id);
            if (oldOrder.Status != 'Activated' && newOrder.Status == 'Activated') {
                orders.add(newOrder);
            }
        }
        if (!orders.isEmpty()) {
            Set<Id> orderIds = new Set<Id>();
            for (Order order: orders) {
                orderIds.add(order.Id);
            }
            orders = [
                SELECT Id
                    ,OrderNumber
                    ,TotalAmount
                    ,(SELECT Id
                        ,Product2Id
                        ,Product2.Name
                        ,Quantity
                        ,UnitPrice
                    FROM OrderItems)
                FROM Order
                WHERE Id IN :orderIds
            ];
            System.debug('orders: '+orders);

            String ordersJson = JSON.serializePretty(orders);
            System.debug('ordersJson: '+ordersJson);

            Map<String, String> headers = new Map<String,String>();
            headers.put('Content-Type', 'application/json');

            
        }
    }
}