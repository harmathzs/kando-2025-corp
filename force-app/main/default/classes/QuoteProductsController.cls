public with sharing class QuoteProductsController {
    public Quote quote {get; set;}
    public Id qliId {get; set;}

    public QuoteProductsController(ApexPages.StandardController stdController) {
        quote = (Quote) stdController.getRecord(); // quote = [SELECT...]

        if (ApexPages.currentPage().getParameters().containsKey('qliid'))
        {
            qliId = ApexPages.currentPage().getParameters().get('qliid');
            System.debug('qliId: '+qliId);
        }
    }
}