@isTest
public class ArchivateJobAdvertisementTest {
    @isTest
    public static void doPostValidTest(){
        integer count = 101;
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(count);
        List <String> ids = new List <String>();
        for(Job_Advertisement__c obj : jAs){
            ids.add(obj.id);
        }
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        String json = JSON.serialize( ids );
        req.requestBody = Blob.valueOf(json );
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        ArchivateJobAdvertisement.doPost();
        Test.stopTest();
        String newStatus = 'Archived';                 
        List <Job_Advertisement__c> createdObj = [Select ID, Name, Status__c from Job_Advertisement__c Where Status__c = : newStatus];
        System.assertEquals(count, createdObj.size());
        System.assertEquals('success', RestContext.response.responseBody.toString());
        System.assertNotEquals(500, RestContext.response.statusCode);
    }
    @isTest
    public static void doPostInvalidJSONTest(){
        integer count = 5;
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(count);
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        req.requestBody = Blob.valueOf('{[invalid JSON example' );
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        ArchivateJobAdvertisement.doPost();
        Test.stopTest();
        String newStatus = 'Archived';                 
        List <Job_Advertisement__c> createdObj = [Select ID, Name, Status__c from Job_Advertisement__c Where Status__c = : newStatus];
        System.assertEquals(0, createdObj.size());
        System.assertEquals('JSON deserialization Exception', RestContext.response.responseBody.toString());
        System.assertEquals(500, RestContext.response.statusCode);
    }
    @isTest
    public static void doPostInvalidBodyTest(){
        integer count = 5;
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(count);
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        ArchivateJobAdvertisement.doPost();
        Test.stopTest();
        String newStatus = 'Archived';                 
        List <Job_Advertisement__c> createdObj = [Select ID, Name, Status__c from Job_Advertisement__c Where Status__c = : newStatus];
        System.assertEquals(0, createdObj.size());
        System.assertEquals('Records were not archived', RestContext.response.responseBody.toString());
        System.assertEquals(500, RestContext.response.statusCode);
    }
	
}