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

        Lead[] leads = [SELECT Name, Funny_Score__c FROM Lead];
        for (Lead lead: leads) {
            if (lead.Name.contains('Bob')) {
                Lead lead1 = lead;
                System.assertEquals(0, lead1.Funny_Score__c);
            } else {
                if (lead.Name.contains('Max')) {
                    Lead lead2 = lead;
                    System.assertEquals(+10, lead2.Funny_Score__c);
                }
            }
        }
    }
}