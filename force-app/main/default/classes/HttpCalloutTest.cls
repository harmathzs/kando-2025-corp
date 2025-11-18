/**
 * Created by User on 2025. 11. 18..
 */

@IsTest
private class HttpCalloutTest {
    @IsTest
    static void testBehavior() {
        // Run Http callout
        Map<String, String> headers = new Map<String, String>();
        //headers.put('Content-Type', 'application/json');

        Map<String, Object> results = HttpCalloutService.callout(
                'GET', 'https://kkando.hu/',
                headers, null
        );
        System.debug(results);

    }
}