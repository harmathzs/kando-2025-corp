public with sharing class QuoteProductsController {
    public Quote quote {get; set;}
    public Id qliId {get; set;}

    public QuoteProductsController(ApexPages.StandardController stdController) {
        quote = (Quote) stdController.getRecord(); // quote = [SELECT...]

        if (ApexPages.currentPage().getParameters().containsKey('qliid'))
        {
            qliId = ApexPages.currentPage().getParameters().get('qliid');
            System.debug('qliId: '+qliId);

            QuoteLineItem[] qlis = [SELECT Id, QuoteId FROM QuoteLineItem WHERE Id= :qliId];
            if (!qlis.isEmpty()) {
                QuoteLineItem qli = qlis[0];
                Id quoteId = qli.QuoteId;
                Quote[] quotes = [
                    SELECT
                        Id
                        ,Name
                        ,Status
                        ,Opportunity.Name
                        ,(SELECT
                            Id
                            ,Product2Id
                            ,Product2.Name
                            ,Quantity
                            ,UnitPrice
                        FROM QuoteLineItems)
                    FROM Quote
                    WHERE Id = :qli.QuoteId
                ];
                if (!quotes.isEmpty()) quote = quotes[0];
            }
        }
    }
}