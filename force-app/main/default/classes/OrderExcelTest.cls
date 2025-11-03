@IsTest
private class OrderExcelTest {
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

    @IsTest
    static void testBehavior() {

    }
}