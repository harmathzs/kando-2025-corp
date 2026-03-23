/* Send apology email to me for testing */
Contact contact = [SELECT Id, Email, FirstName, LastName FROM Contact WHERE Email='harmathzs@gmail.com'];
Boolean success = ApologizeService.sendApologyEmail(contact.Id, null);
System.debug('Email sent, success: '+success);