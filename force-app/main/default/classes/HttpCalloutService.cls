public with sharing class HttpCalloutService {

    public class HttpCalloutAsync implements Queueable, Database.AllowsCallouts {
        public String method;
        public String endpoint;
        public Map<String, String> headers;
        public String reqBody;

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
            Map<String, Object> results = HttpCalloutService.callout(method, endpoint, headers, reqBody);
            System.debug('HttpCalloutAsync results: '+results);
        }
    }

    public static Map<String, Object> callout(
        String method,
        String endpoint,
        Map<String, String> headers,
        String reqBody
    ) {
        HttpRequest req = new HttpRequest();
        req.setMethod(method);
        req.setEndpoint(endpoint);

        if (headers != null && !headers.isEmpty()) {
            for (String headerKey : headers.keySet()) {
                req.setHeader(headerKey, headers.get(headerKey));
            }
        }
        if (String.isNotBlank(reqBody)) {
            req.setBody(reqBody);
        }

        Http http = new Http();

        Integer statusCode;
        String statusMessage;
        String resBody;
        String errorMessage;

        HttpResponse res;
        try {
            // TODO - mock test callout
            res = http.send(req);
            statusCode = res.getStatusCode();
            statusMessage = res.getStatus();
            resBody = res.getBody();
        } catch (Exception err) {
            errorMessage = err.getMessage();
        }

        Map<String, Object> results = new Map<String, Object>();
        results.put('statusCode', statusCode);
        results.put('statusMessage', statusMessage);
        results.put('resBody', resBody);
        results.put('errorMessage', errorMessage);
        return results;
    }
}