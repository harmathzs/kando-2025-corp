/**
 * Created by User on 2026. 03. 23..
 */

@IsTest
private class ApologizeServiceTest {
    @TestSetup
    static void testFactory() {
        Contact contact = new Contact(
            FirstName='Kanalas',
            LastName='Dzsordzs',
            Email='kanalas@dzsordzs.ro'
        );
        insert contact;
    }

    @IsTest
    static void testBehavior() {
        Contact contact = [SELECT Id, Email, FirstName, LastName FROM Contact WHERE Email='kanalas@dzsordzs.ro'];
        ApologizeService.EmailSendResult result = ApologizeService.sendApologyEmail(contact.Id, null);
        System.debug('Email sent, result: '+result);
    }

    // test LWC method
    @IsTest static void testLwc() {
        Contact contact = [SELECT Id, Email, FirstName, LastName FROM Contact WHERE Email='kanalas@dzsordzs.ro'];
        String json = ApologizeService.sendApologyEmailLWC(contact.Id, null);
        System.debug('json: '+json);
        /*
        Map<String, Object> emailSendResult = (Map<String, Object>) JSON.deserializeUntyped(json);
        System.assert(emailSendResult.containsKey('contactId'));
        System.assert(emailSendResult.containsKey('success'));
        System.assert(emailSendResult.containsKey('errorMessage'));
        */

    }

    // TODO test VF property
    // TODO test Invocable Action method
    // TODO test contactId input error
}