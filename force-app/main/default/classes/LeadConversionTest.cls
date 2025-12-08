@IsTest
private class LeadConversionTest {
    @TestSetup static void testFactory() {
        Lead lead = new Lead(
            FirstName = 'Test',
            LastName = 'Jolán',
            Email = 'test@test.com',
            Company = 'Test Corp'
        );
        insert lead;
    }

    @IsTest
    static void testBehaviorOnSingleLead() {
        Lead lead = [SELECT Id, Email FROM Lead
            WHERE Email = 'test@test.com' LIMIT 1
        ];
        String jsonMap = LeadConversionService.customConvertLead(lead.Id);
        Map<String, Object> obj = (Map<String, Object>) JSON.deserializeUntyped(jsonMap);
        System.debug(obj);

        System.assert(obj.containsKey('accountId'));
        System.assert(obj.containsKey('contactId'));
        System.assert(obj.containsKey('opportunityId'));

        System.assertNotEquals(null, obj.get('accountId'));
        System.assertNotEquals(null, obj.get('contactId'));
        System.assertNotEquals(null, obj.get('opportunityId'));
    }
/*
    @IsTest static void testError() {
        Lead lead = [SELECT Id, Email FROM Lead
        WHERE Email = 'test@test.com' LIMIT 1
        ];
        LeadConversionService.customConvertLead(lead.Id);

        lead = [SELECT Id, Email FROM Lead
        WHERE Email = 'test@test.com' LIMIT 1
        ];
        LeadConversionService.customConvertLead(lead.Id);
    }

 */

@IsTest
    static void testBehaviorOnMultipleLeads() {
        Lead lead = [SELECT Id, Email FROM Lead
            WHERE Email = 'test@test.com' LIMIT 1
        ];
        Lead[] leads = new List<Lead>{lead};
        String[] leadIds = new List<String>{lead.Id};
        String jsonMap = LeadConversionService.customConvertLeads(leadIds);
        /*
        Map<String, Map<String, Object>> obj = (Map<String, Map<String, Object>>) JSON.deserializeUntyped(jsonMap);
        System.debug(obj);

        System.assert(obj.get(lead.Id).containsKey('accountId'));
        System.assert(obj.get(lead.Id).containsKey('contactId'));
        System.assert(obj.get(lead.Id).containsKey('opportunityId'));

        System.assertNotEquals(null, obj.get(lead.Id).get('accountId'));
        System.assertNotEquals(null, obj.get(lead.Id).get('contactId'));
        System.assertNotEquals(null, obj.get(lead.Id).get('opportunityId'));
        */
    } 
}