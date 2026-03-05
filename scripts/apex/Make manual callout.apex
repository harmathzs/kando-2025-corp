// Make manual callout
HttpCalloutController.InputParams inp = new HttpCalloutController.InputParams();
inp.method = 'GET';
inp.endpoint = 'https://jsonplaceholder.typicode.com/todos/1';
List<HttpCalloutController.OutputParams> outp = HttpCalloutController.httpCallout(new List<HttpCalloutController.InputParams>{inp});
System.debug(outp);

// Fire Platform Event
Callout_Log_Platform_Event__e pe = new Callout_Log_Platform_Event__e();
pe.Method__c = inp.method;
pe.Endpoint__c = inp.endpoint;
pe.Request_Body__c = inp.inputBody;
EventBus.publish(new List<Callout_Log_Platform_Event__e>{pe}, null);

/*
// Insert log
HTTP_Callout_Log_Entry__c log = new HTTP_Callout_Log_Entry__c();
log.Method__c = inp.method;
log.Endpoint__c = inp.endpoint;
log.Request_Body__c = inp.inputBody;
log.Response_Body__c = outp[0].responseBody;
log.Status_Code__c = outp[0].statusCode;
log.Status_Text__c = outp[0].statusText;
log.Error_Message__c = outp[0].errorMessage;
insert log;
System.debug(log);
*/


