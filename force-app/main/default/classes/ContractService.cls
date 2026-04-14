
public with sharing class ContractService {
    public Contract contract {get; set;}

    public ContractService(ApexPages.StandardController controller) {
        contract = (Contract)controller.getRecord();
    }

    public ContractService(Contract inContract) {
        contract = inContract;
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
    }
}