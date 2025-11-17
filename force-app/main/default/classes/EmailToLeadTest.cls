@IsTest
private class EmailToLeadTest {
    @IsTest
    static void testBehavior() {
        // create mock email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        email.fromAddress = 'test@kkando.hu';
        email.fromName = 'Test Özséb';
        email.subject = 'Test subject';
        email.plainTextBody = 'Test body'; 

        // attachment
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.fileName = 'test.txt';
        attachment.body = Blob.valueOf('test');

        email.binaryAttachments = new Messaging.InboundEmail.BinaryAttachment[] { attachment };

        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();

        EmailToLeadHandler emailHandler = new EmailToLeadHandler();
        Messaging.InboundEmailResult result = emailHandler.handleInboundEmail(email, envelope);

        System.assert(result.success);
    }
}