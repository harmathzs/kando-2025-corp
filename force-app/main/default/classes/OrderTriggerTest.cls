/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class OrderTriggerTest {
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

        Account acc = new Account(Name='Jill Test');
        insert acc;

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

        Contract contract = new Contract(
                AccountId = acc.Id
        );
        insert contract;

        Order order = new Order(
                AccountId = acc.Id,
                EffectiveDate = Date.today(),
                Status = 'Draft',
                Pricebook2Id = Test.getStandardPricebookId()
        );
        insert order;

        OrderItem oi = new OrderItem(
                OrderId = order.Id,
                PricebookEntryId = pbe.Id,
                Quantity = 1,
                UnitPrice = 100
        );
        insert oi;
    }    

    @isTest
    static void myUnitTest() {
        Order order = [SELECT Id, Status FROM Order WHERE Status = 'Draft' LIMIT 1];
        order.Status = 'Activated';
        update order;
    }
}