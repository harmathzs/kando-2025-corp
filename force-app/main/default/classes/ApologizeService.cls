/** ApologizeService */
public class ApologizeService {
    /**
     * Sends an apology email to a contact using the Apologize_Email_Template_1 template
     *
     * @param contactId The ID of the Contact to send the email to
     * @param whatId Optional ID of an object to associate with the email (e.g., Case, Opportunity)
     * @return Boolean indicating whether the email was sent successfully
     */
    public static Boolean sendApologyEmail(Id contactId, Id whatId) {

        // Query the contact information
        Contact contact = [SELECT Id, Email, FirstName, LastName FROM Contact WHERE Id = :contactId];

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
        // TODO

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
        // TODO
        return true;


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