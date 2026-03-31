/* Send apology email to me for testing */
Contact contact = [SELECT Id, Email, FirstName, LastName FROM Contact WHERE Email='harmathzs@gmail.com'];
ApologizeService.EmailSendResult result = ApologizeService.sendApologyEmail(contact.Id, null);
System.debug('Email sent, result: '+result);