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
    static void testBehavior() {
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
}