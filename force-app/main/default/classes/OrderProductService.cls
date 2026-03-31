public with sharing class OrderProductService {
    @AuraEnabled
    public static OrderItem getOrderProductById(String orderProductId) {
        OrderItem[] orderProducts = [
                SELECT
                        Id, Product2Id, Quantity, UnitPrice, TotalPrice, OrderId
                    ,Total_Price_with_VAT__c
                    ,VAT_Setting__r.Country_Code__c
                    ,VAT_Setting__r.Product_Category__c
                    ,VAT_Setting__r.Percentage__c
                FROM OrderItem WHERE Id = :orderProductId];
        if (orderProducts.isEmpty()) {
            return null;
        } else {
            return orderProducts[0];
        }
    }
}