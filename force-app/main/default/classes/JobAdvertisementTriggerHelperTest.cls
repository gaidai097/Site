@isTest
public class JobAdvertisementTriggerHelperTest {
    @isTest
    public static void helperRemoveCVsValidTest(){
        
        List<Job_Advertisement__c> jobs = TestDataFactory.createJobAdvertisement(101);
        List < CV__c >cvs = TestDataFactory.createCVs(50);
        List < ContentVersion > conVers = TestDataFactory.createContentVersions(cvs);
        TestDataFactory.createCVJAs(cvs, jobs[0]);
        // Create 2 CV which related to 2 JobAdvertisements and should not be deleted
        TestDataFactory.createCVJAs(new List < CV__c >{cvs[0],cvs[2]}, jobs[1]);
        Test.startTest();
        JobAdvertisementTriggerHelper.removeCVs(new List < Job_Advertisement__c >{jobs[0],jobs[2]});
        Test.stopTest();
        cvs = [SELECT ID, Name FROM CV__c];
        List <CVJA__c> cvjas = [SELECT ID, Name FROM CVJA__c];
        System.assertEquals(2, cvs.size());
        System.assertEquals(2, cvs.size());
        System.debug('cvs '+ cvs.size());
    }
    
    @isTest
    public static void helperInvalidTest(){
       
        Test.startTest();
        String msg = null;
        try{
            JobAdvertisementTriggerHelper.removeCVs(null);
           
        }catch(Exception e){
            msg = e.getMessage();
        }
        Test.stopTest();
        System.assertEquals(null, msg);
    }
 
}