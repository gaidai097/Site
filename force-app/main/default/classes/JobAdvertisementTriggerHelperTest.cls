@isTest
public class JobAdvertisementTriggerHelperTest {
    @isTest
    public static void removeCVsValidTest(){
        
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(101);
        List < CV__c >cvs = TestDataFactory.createCVs(50);
        List < ContentVersion > conVers = TestDataFactory.createContentVersions(cvs);
        
        TestDataFactory.createCVJAs(cvs, jAs[0]);
        TestDataFactory.createCVJAs(new List < CV__c >{cvs[0],cvs[2]}, jAs[1]);
        Test.startTest();
        JobAdvertisementTriggerHelper.removeCVs(new List < Job_Advertisement__c >{jAs[0],jAs[2]});
        Test.stopTest();
        cvs = [SELECT ID, Name FROM CV__c];
        System.assertEquals(2, cvs.size());
        System.debug('cvs '+ cvs.size());
    }
    @isTest
    public static void removeCVsInvalidTest(){
       
        Test.startTest();
        JobAdvertisementTriggerHelper.removeAllImages(null);
        Test.stopTest();
    }
    
}