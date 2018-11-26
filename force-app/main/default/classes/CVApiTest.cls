@isTest
public class CVApiTest {
	@isTest
    public static void doGetCountValidTest(){
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(101);
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/newCVs';
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        req.addParameter('start', 'true');
        RestContext.request = req;
        RestContext.response = res;
        TestDataFactory.createCVs(101);
        Test.startTest();        
        CVApi.doGet();
        Test.stopTest();
        System.assertEquals('101', res.responseBody.toString());
    }
    @isTest
    public static void doGetValidCVsTest(){
        
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(1);
        List < CV__c >svs = TestDataFactory.createCVs(50);
        TestDataFactory.createContentVersions(svs);
        TestDataFactory.createCVJAs(svs, jAs[0]);
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/newCVs';
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        req.addParameter('offset', '25');
        req.addParameter('limit', '25');
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        CVApi.doGet();
        Test.stopTest();
        String json = res.responseBody.toString();
        
        System.assertEquals(25, json.countMatches('email'));
    }
    @isTest
    public static void paramsValueInvalidTest(){
        
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/newCVs';
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        req.addParameter('offset', 'invalid');
        req.addParameter('limit', 'invalid');
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        CVApi.doGet();
        Test.stopTest();
        String msg = res.responseBody.toString();
        
        System.assert( msg.contains('Records were not received'));
    }
    @isTest
    public static void paramsRequiredInvalidTest(){
        
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/newCVs';
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        req.addParameter('offset', 'invalid');
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        CVApi.doGet();
        Test.stopTest();
        String msg = res.responseBody.toString();
        System.assert( msg.contains('Records were not received'));
    }
}