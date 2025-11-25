// Convert a Lead
Lead lead = [SELECT Id, FirstName, LastName FROM Lead
    WHERE LastName = 'Dzsúlió'
        LIMIT 1
];

LeadStatus convertStatus = [SELECT Id, ApiName FROM LeadStatus WHERE IsConverted=TRUE LIMIT 1];

Database.LeadConvert lc = new Database.LeadConvert();
lc.setLeadId(lead.Id);

Map<String, Object> results = new Map<String, Object>();

Database.LeadConvertResult lcr = Database.convertLead(lc);
if (lcr.isSuccess()) {
    Id accountId = lcr.getAccountId();
    Id contactId = lcr.getContactId();
    Id opportunityId = lcr.getOpportunityId();
    
    results.put('accountId', accountId);
    results.put('contactId', contactId);
    results.put('opportunityId', opportunityId);
} else {
    Database.Error[] errors = lcr.getErrors();

    results.put('errors', errors);
}
System.debug('results: '+results);
