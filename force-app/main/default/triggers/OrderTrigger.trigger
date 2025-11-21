trigger OrderTrigger on Order (before insert, before update, before delete, after insert, after update, after delete) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        Set<Id> sendOrderIds = new Set<Id>();
        for (Order orderNew: Trigger.new) {
            if (Trigger.oldMap!=null && !Trigger.oldMap.isEmpty() && Trigger.oldMap.containsKey(orderNew.Id)) {
                Order orderOld = Trigger.oldMap.get(orderNew.Id);
                if (orderOld.Status != 'Activated' && orderNew.Status == 'Activated') {
                    sendOrderIds.add(orderNew.Id);
                }
            }
        }
        Order[] sendOrders = [
            SELECT Id, CreatedDate
                ,OrderNumber
                ,TotalAmount
                ,AccountId
                ,Account.Name
                ,ContractId
                ,Contract.ContractNumber
                ,Pricebook2Id
                ,Pricebook2.Name
                ,(SELECT Id, CreatedDate
                    ,Product2Id
                    ,Product2.Name
                    ,Quantity
                    ,UnitPrice
                    ,PricebookEntryId
                    ,PricebookEntry.Name
                FROM OrderItems)
            FROM Order
            WHERE Id IN :sendOrderIds
        ];
        String ordersJson = JSON.serializePretty(sendOrders);
        System.debug('ordersJson: '+ordersJson);

        HttpCalloutAsync httpCalloutAsync = new HttpCalloutAsync('POST', 'https://kando-2025-external-harmathzs.netlify.app/.netlify/functions/order', null, ordersJson);
        Id jobId = System.enqueueJob(httpCalloutAsync);
        System.debug('OrderTrigger httpCalloutAsync jobId: '+jobId);
    }
}