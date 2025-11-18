@IsTest
private class HttpCalloutTest {
    private class SuccessMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            return res;
        }
    }

    @IsTest
    static void testBehavior() {
        // Run Http callout
        Map<String, String> headers = new Map<String, String>();
        //headers.put('Content-Type', 'application/json');

        SuccessMock mock = new SuccessMock();
        Test.setMock(HttpCalloutMock.class, mock);
        Map<String, Object> results = HttpCalloutService.callout(
                'GET', 'https://kkando.hu/',
                headers, null
        );
        System.debug(results);

    }
}