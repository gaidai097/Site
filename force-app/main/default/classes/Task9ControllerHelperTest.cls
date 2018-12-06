@isTest
public class Task9ControllerHelperTest {
	@isTest
    public static void insertCVJsInvalidTest(){
        Test.startTest();
        Map<Id, Job_Advertisement__c> jobsMap = new Map<Id, Job_Advertisement__c>();
        jobsMap.put( null, new Job_Advertisement__c());
        boolean isException = false;
        try{
            Task9ControllerHelper.insertCVJs(null, jobsMap);
        }catch(Task6Exception e ){
            isException = true;
        }      
        Test.stopTest();
        System.assert(isException);
    }
    @isTest
    public static void saveContentVersionInvalidTest(){
        Test.startTest();
        boolean isException = false;
        try{
            Task9ControllerHelper.saveContentVersion(null, null);
        }catch(Task6Exception e ){
            isException = true;
        }      
        Test.stopTest();
        System.assert(isException);
    }
    @isTest
    public static void unsuccessfulValidationCVTest(){
        CV__c cv = new CV__c( Age__c = '0', Phone__c = 'gh', Email__c= 'test' );
        boolean isException = false;
        Test.startTest();
        try{
            Task9ControllerHelper.validateCV(cv);
        }catch(Task6Exception e ){
            isException = true;
        }
        System.assert(isException);
        cv.Age__c = '25';
        try{
            Task9ControllerHelper.validateCV(cv);
        }catch(Task6Exception e ){
            isException = true;
        }
        System.assert(isException);
        cv.Email__c = 'test@test.com';
        try{
            Task9ControllerHelper.validateCV(cv);
        }catch(Task6Exception e ){
            isException = true;
        }
        System.assert(isException);
        Test.stopTest();
    }
    @isTest
    public static void insertCVInvalidTest(){
        CV__c cv = new CV__c( Age__c = '0', Phone__c = 'gh', Email__c= 'test' );
        boolean isException = false;
        Test.startTest();
        try{
            Task9ControllerHelper.insertCV(cv);
        }catch(Task6Exception e ){
            isException = true;
        }
        System.assert(isException);
    }
    @isTest
    public static void filterSelectedJobsInvalidTest(){
        
    }
}