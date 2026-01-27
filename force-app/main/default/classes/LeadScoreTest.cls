@IsTest
private class LeadScoreTest {
    @TestSetup
    static void testFactory() {
        Lead lead1 = new Lead(FirstName='Test', LastName='Bob', Company='Umbrella Corp');
        Lead lead2 = new Lead(FirstName='Test', LastName='Max', Company='Funny Pickle Ltd');
        Lead[] leads = new List<Lead>{lead1, lead2};
        insert leads;
    }

    @IsTest
    static void testBehavior() {
        SchedulableContext context = null;
        LeadScoreScheduler instance = new LeadScoreScheduler();
        instance.execute(context);
    }

    @IsTest static void testAwait() {
        LeadScoreScheduler instance = new LeadScoreScheduler();

        Test.startTest();
        Database.executeBatch(instance);
        Test.stopTest();

        System.debug('counter: '+instance.counter);
    }
}