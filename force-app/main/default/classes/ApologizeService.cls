/** ApologizeService */
public class ApologizeService {
    /**
     * Sends an apology email to a contact using the Apologize_Email_Template_1 template
     *
     * @param contactId The ID of the Contact to send the email to
     * @param whatId Optional ID of an object to associate with the email (e.g., Case, Opportunity)
     * @return Boolean indicating whether the email was sent successfully
     */

    @AuraEnabled
    public static String sendApologyEmailLWC(String contactId, String whatId) {
        EmailSendResult result = sendApologyEmail(contactId, whatId);
        return JSON.serializePretty(result); // JS = JSON.stringify()
    }

    // Visualforce
    public String contactId_VF { get; set; }
    public Id whatId_VF { get; set; }

    public EmailSendResult sendApologyEmailVF {
        get {
            return ApologizeService.sendApologyEmail(contactId_VF, whatId_VF);
        }
    }

    public class InputParams {
        @InvocableVariable
        public String contactId;
        @InvocableVariable
        public Id whatId;
    }

    @InvocableMethod
    public static List<String> sendApologyEmail_IA
        (List<InputParams> inputs) {

        List<String> results = new List<String>();
        EmailSendResult emailSendResult = sendApologyEmail(inputs.get(0).contactId, inputs.get(0).whatId);
        results.add(JSON.serializePretty(emailSendResult));
        return results;
    }

    public static EmailSendResult sendApologyEmail(String contactId, Id whatId) {


        // Query the contact information
        String trimmedContactId = contactId.trim();
        Contact[] contacts = [SELECT Id, Email, FirstName, LastName FROM Contact WHERE Id = :trimmedContactId];
        if (contacts.isEmpty()) {
            return new EmailSendResult(
                    null,
                    false,
                    'Wrong contact id!'
            );
        }
        Contact contact = contacts[0];

        // Query the email template
        EmailTemplate template =
            [SELECT
                Id,
                    Subject,
                    HtmlValue,
                    Body,
                DeveloperName
            FROM
                EmailTemplate
            WHERE DeveloperName='Apologize_Email_Template_1'];

        // Create the email message
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        // Set target object ID (Contact ID)
        email.setTargetObjectId(contactId);

        // Set what ID if provided (associates email with an object like Case, Opportunity)
        if (String.isNotBlank(whatId)) {
            email.setWhatId(whatId);
        }

        // Set template ID
        email.setTemplateId(template.Id);

        // Set sender display name (optional)
        // 'Customer Support'
        email.setSenderDisplayName('Customer Support');

        // Set save as activity flag (optional)
        email.setSaveAsActivity(true);

        // Send the email
        Messaging.sendEmail(new List<Messaging.Email>{email});

        // Check if email was sent successfully
        return new EmailSendResult(
            contactId,
            true,
            null
        );


    }

    /**
     * Sends apology emails to multiple contacts
     *
     * @param contactIds List of Contact IDs to send emails to
     * @param whatId Optional ID of an object to associate with the emails
     * @return List of results indicating success/failure for each contact
     */
    public static List<EmailSendResult> sendApologyEmails(List<Id> contactIds, Id whatId) {
        List<EmailSendResult> results = new List<EmailSendResult>();



        return results;
    }

    /**
     * Inner class to represent email send results
     */
    public class EmailSendResult {
        public Id contactId;
        public Boolean success;
        public String errorMessage;

        public EmailSendResult(Id contactId, Boolean success, String errorMessage) {
            this.contactId = contactId;
            this.success = success;
            this.errorMessage = errorMessage;
        }
    }
}