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
}