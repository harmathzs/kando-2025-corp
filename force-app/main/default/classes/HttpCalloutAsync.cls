public with sharing class HttpCalloutAsync implements Queueable, Database.AllowsCallouts {
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
}