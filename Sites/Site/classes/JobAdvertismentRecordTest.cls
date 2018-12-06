@isTest
public class JobAdvertismentRecordTest {
	@isTest
    public static void doGetValidTest(){
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(101);
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.addParameter('id', jAs[55].id);
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        JobAdvertismentRecord.doGet();
        Test.stopTest();
        String testJSON = res.responseBody.toString();
        System.assertEquals(1, testJSON.countMatches('email'));
        System.assertEquals(true, testJSON.contains(jAs[55].id));
        System.assertEquals(true, testJSON.contains(jAs[55].name));
    }
    @isTest
    public static void doGetFalseIdInvalidTest(){
        Job_Advertisement__c jA = TestDataFactory.createJobAdvertisement(1)[0];
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.addParameter('id', jA.id);
        delete jA;
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;        
        Test.startTest();
        JobAdvertismentRecord.doGet();
        Test.stopTest();
        System.assertEquals(500, RestContext.response.statusCode);
        System.assertEquals('Exception during retrieving records', RestContext.response.responseBody.toString());
    }
    @isTest
    public static void doGetEmptyIdInvalidTest(){       
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';        
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        JobAdvertismentRecord.doGet();
        Test.stopTest();
        System.assertEquals( 500 , RestContext.response.statusCode);
        System.assertEquals('Exception during retrieving records', RestContext.response.responseBody.toString());
    }   
    @isTest
    public static void doDeleteValidTest(){
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(101);
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.addParameter('id', jAs[55].id);
        req.httpMethod = 'DELETE';
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        JobAdvertismentRecord.doDelete();
        Test.stopTest();
        System.assertEquals( 'success' , RestContext.response.responseBody.toString());
        System.assertEquals(100, [Select ID from Job_Advertisement__c ].size());
    }
    @isTest
    public static void doDeleteFalseIdInvalidTest(){
        Job_Advertisement__c jA = TestDataFactory.createJobAdvertisement(1)[0];
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.addParameter('id', jA.id);
        //delete record immediately 
        delete jA;
        req.httpMethod = 'DELETE';
        RestContext.request = req;
        RestContext.response = res;        
        Test.startTest();
        JobAdvertismentRecord.doDelete();  
        Test.stopTest();
       // System.assertEquals(false, result);
    }
    @isTest
    public static void doDeleteEmptyIdInvalidTest(){       
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        // Send request without parameter
        req.httpMethod = 'DELETE';
        RestContext.request = req;
        RestContext.response = res;        
        Test.startTest();
        JobAdvertismentRecord.doDelete();  
        Test.stopTest();
         System.assertEquals( 500 , RestContext.response.statusCode);
    }
    @isTest
    public static void doPostValidTest(){
       // create JobAdvertisementsWrapper for JSON requestBody
        JobAdvertisementsWrapper objWrapped = new JobAdvertisementsWrapper();
        objWrapped.name = 'testName';
        objWrapped.phone = '0987654321';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        String json = JSON.serialize( objWrapped );
        req.requestBody = Blob.valueOf(json );
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        JobAdvertismentRecord.doPost();
        Test.stopTest();
        
        //Check created record and id from responseBody JSON
        String responseJson = RestContext.response.responseBody.toString();         
        Job_Advertisement__c createdObj = [Select ID, Name, Phone__c from Job_Advertisement__c ][0];
        System.assertEquals(responseJson, createdObj.id);
        System.assertNotEquals(500, RestContext.response.statusCode);
    }
    @isTest
    public static void doPostInvalidTest(){
        // create JobAdvertisementsWrapper for JSON requestBody
        JobAdvertisementsWrapper objWrapped = new JobAdvertisementsWrapper();
       
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        JobAdvertismentRecord.doPost();
        Test.stopTest();
        
        //Check created record and id from responseBody JSON
        System.assertEquals(0, [Select ID from Job_Advertisement__c ].size());
        System.assertEquals(500, RestContext.response.statusCode);
    }
    @isTest
    public static void doPutValidTest(){
       // create JobAdvertisementsWrapper for JSON requestBody
        Job_Advertisement__c obj = TestDataFactory.createJobAdvertisement(101)[0];
        JobAdvertisementsWrapper objWrapped = new JobAdvertisementsWrapper();
        Id objId = obj.id;
        objWrapped.name = 'testName';
        objWrapped.phone = '0987654321';
        objWrapped.id = objId ;
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.httpMethod = 'PUT';
        req.addHeader('Content-Type', 'application/json');
        String json = JSON.serialize( objWrapped );
        req.requestBody = Blob.valueOf(json );
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        JobAdvertismentRecord.doPut();
        Test.stopTest();
        
        //Check updated record and id from responseBody JSON       
        Job_Advertisement__c updatedObj = [Select ID,  Name, Phone__c from Job_Advertisement__c where id =:objId][0];
        System.assertEquals(objWrapped.phone, updatedObj.phone__c);
        System.assertEquals( 'success' , RestContext.response.responseBody.toString());
        System.assertNotEquals(500, RestContext.response.statusCode);
        //System.assertEquals(true, responseJson.contains(updatedObj.name));
    }
    @isTest
    public static void doPutInvalidTest(){
        // create JobAdvertisementsWrapper for JSON requestBody
        Job_Advertisement__c obj = TestDataFactory.createJobAdvertisement(101)[0];       
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/JobAdvertisementRecord';
        req.httpMethod = 'PUT';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        JobAdvertismentRecord.doPut();
        Test.stopTest();                
        System.assertEquals( 500 , RestContext.response.statusCode);
    }
}