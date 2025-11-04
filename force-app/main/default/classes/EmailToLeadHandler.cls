public with sharing class EmailToLeadHandler implements Messaging.InboundEmailHandler {
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        // process email
        String fromAddress = email.fromAddress;
        Lead[] existingLeads = [SELECT Id, Email FROM Lead WHERE Email = :fromAddress];
        if (existingLeads.isEmpty()) {

            String subject = email.subject;
            String body = email.plainTextBody; // TODO - HTML body?

            System.debug('fromAddress: ' + fromAddress);
            System.debug('subject: ' + subject);
            System.debug('body: ' + body);

            Lead lead = new Lead();
            lead.Email = fromAddress;
            lead.LastName = email.fromName;
            lead.Company = 'Todo Company'; // TODO - callout to AI ! :)

            lead.Title = subject;
            lead.Description = body;

            Database.SaveResult sr = null;
            try {
                sr = Database.insert(lead);
                if (sr.isSuccess()) {
                    System.debug('New Lead Id: ' + lead.Id);
                    result.success = true;
                } else {
                    System.debug('Insert Lead failed: ' + sr.getErrors());
                    result.success = false;
                }
            } catch (Exception e) {
                System.debug('Insert Lead failed: ' + sr.getErrors());
                result.success = false;
            }
        }

        return result;
    }
}