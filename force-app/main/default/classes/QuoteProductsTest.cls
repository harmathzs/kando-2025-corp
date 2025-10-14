/**
 * Created by User on 2025. 10. 14..
 */

@IsTest
private class QuoteProductsTest {
    @TestSetup static void testFactory() {
        Opportunity oppy = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Closed Won',
            CloseDate = Date.today()
        );
        insert oppy;

        Quote quote = new Quote(
            Name = 'Test Quote',
            OpportunityId = oppy.Id
        );
        insert quote;
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