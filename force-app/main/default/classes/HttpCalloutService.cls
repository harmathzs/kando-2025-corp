public with sharing class HttpCalloutService {
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