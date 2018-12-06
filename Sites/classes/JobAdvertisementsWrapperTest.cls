@isTest
public class JobAdvertisementsWrapperTest {
    @isTest
    public static void JobAdvertisementsWrapperValidTest(){        
        JobAdvertisementsWrapper obj = new JobAdvertisementsWrapper();
        Job_Advertisement__c ja = new Job_Advertisement__c(
             name = 'TestName', 
            status__c = 'Active', phone__c = '252222', email__c = 'test@test.com'
        );
        JobAdvertisementsWrapper wrappedObj = obj.convertToWrapper(ja);
        Job_Advertisement__c unwrappedObj = JobAdvertisementsWrapper.convertFromWrapper(wrappedObj);
        System.assertEquals(wrappedObj.name, unwrappedObj.name);
    }
    @isTest
    public static void JobAdvertisementsWrapperBulkValidTest(){        

        List <Job_Advertisement__c> jas = new List <Job_Advertisement__c>();
        for(Integer i = 0 ; i < 101; i++){
            Job_Advertisement__c ja = new Job_Advertisement__c(
                 name = 'TestName' + i, 
                status__c = 'Active'
            );
            jas.add(ja);
        }       
        List <JobAdvertisementsWrapper> wrappedObjs = JobAdvertisementsWrapper.convertToWrapper(jas);
        
        System.assertEquals(101, wrappedObjs.size());
        //System.assertEquals(wrappedObj.name, unwrappedObj.name);
    }
    @isTest
    public static void JobAdvertisementsWrapperInvalidTest(){        
        JobAdvertisementsWrapper obj = new JobAdvertisementsWrapper();
        Job_Advertisement__c ja = new Job_Advertisement__c( name = '' );      
        JobAdvertisementsWrapper wrappedObj = obj.convertToWrapper(ja);
        Job_Advertisement__c unwrappedObj = JobAdvertisementsWrapper.convertFromWrapper(wrappedObj);
        System.assertEquals(null, unwrappedObj);
    }
}