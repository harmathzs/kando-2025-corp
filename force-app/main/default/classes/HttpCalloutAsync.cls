public with sharing class HttpCalloutAsync implements Queueable, Database.AllowsCallouts, Schedulable {
    public String method;
    public String endpoint;
    public Map<String, String> headers;
    public String reqBody;

    public Map<String, Object> results;
    public Id jobId;

    public HttpCalloutAsync(
        String method,
        String endpoint,
        Map<String, String> headers,
        String reqBody
    ) {
        this.method = method;
        this.endpoint = endpoint;
        this.headers = headers;
        this.reqBody = reqBody;
    }

    public void execute(QueueableContext context) {
        results = HttpCalloutService.callout(method, endpoint, headers, reqBody);
        System.debug('HttpCalloutAsync results: '+results);
    }

    public void execute(SchedulableContext context) {
        jobId = System.enqueueJob(this);
        System.debug('HttpCalloutAsync jobId: '+jobId);
    }
}