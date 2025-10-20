/**
 * Created by User on 2025. 10. 14..
 */

@IsTest
private class QuoteProductsTest {
    @TestSetup static void testFactory() {
        Product2 prod = new Product2(Name='Test Product');
        insert prod;

        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = prod.Id,
            UnitPrice = 100,
            IsActive = true
        );
        insert pbe;

        Opportunity oppy = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Closed Won',
            CloseDate = Date.today()
        );
        insert oppy;

        Quote quote = new Quote(
            Name = 'Test Quote',
            OpportunityId = oppy.Id,
            Pricebook2Id = Test.getStandardPricebookId()
        );
        insert quote;

        QuoteLineItem qli = new QuoteLineItem(
            QuoteId = quote.Id,
            Product2Id = prod.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 2,
            UnitPrice = 100
        );
        insert qli;
    }

    @IsTest
    static void testQuoteInput() {
        Quote quote = [SELECT Id FROM Quote LIMIT 1];
        ApexPages.StandardController stdController = new ApexPages.StandardController(quote);
        QuoteProductsController controller = new QuoteProductsController(stdController);
    }
    @IsTest
    static void testQliInput() {
    }
}