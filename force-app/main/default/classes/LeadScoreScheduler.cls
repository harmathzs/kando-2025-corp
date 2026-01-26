public without sharing class LeadScoreScheduler implements Database.Batchable<SObject>, Schedulable, Database.Stateful {
    public Integer counter;

    public Database.QueryLocator start(Database.BatchableContext context) {
        counter = 0;
        return Database.getQueryLocator([SELECT Id, Company, Funny_Score__c FROM Lead WHERE Company != NULL]);
    }

    public void execute(Database.BatchableContext context, List<Lead> leads) {
        Lead[] updatableLeads = new List<Lead>();
        for (Lead lead: leads) {
            Integer score = 0;
            if (lead.Company.toLowerCase().contains('pickle')) score += 10;
            if (lead.Company.toLowerCase().contains('kazoo')) score += 10;
            if (lead.Company.toLowerCase().contains('waffle')) score += 10;
            Lead updatableLead = lead;
            if (updatableLead.Funny_Score__c != null && updatableLead.Funny_Score__c != score)
            {
                updatableLead.Funny_Score__c = score;
                // update updatableLead;
                updatableLeads.add(updatableLead);
                counter++;
            }

        }
        update updatableLeads;
    }

    public void finish(Database.BatchableContext context) {
        System.debug('LeadScoreScheduler.counter: '+counter);
    }

    public void execute(SchedulableContext context) {
        Database.executeBatch(this, 50);
    }
}