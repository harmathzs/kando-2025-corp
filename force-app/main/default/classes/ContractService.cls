
public with sharing class ContractService {
    public Contract contract {get; set;}
    public Contract_Product__c[] contractProducts {get; set;}

    public Contract_Product__c[] queryContractProducts(Id contractId) {
        return [
            SELECT Id
                ,Contract__c
                ,Product__r.Name
                ,Quantity__c
                ,Unit_Price__c
                ,Subtotal_Price__c
            FROM Contract_Product__c
            WHERE Contract__c = :contractId
        ];
    }

    public ContractService(ApexPages.StandardController controller) {
        contract = (Contract)controller.getRecord();
        contractProducts = queryContractProducts(contract.Id);
    }

    public ContractService(Contract inContract) {
        contract = inContract;
        contractProducts = queryContractProducts(contract.Id);
    }

    public ContractService(Id contractId) {
        contract = [SELECT Id
            , StartDate
            , Account.Name
            , Account.BillingCountryCode
            , Account.BillingState
            , Account.BillingCity
            , Account.BillingStreet
            , Total_Price__c
            , Total_Price_with_VAT__c
        FROM Contract WHERE Id = :contractId LIMIT 1];
        contractProducts = queryContractProducts(contract.Id);
    }
}