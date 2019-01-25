@isTest
public class JobsLControllerTest {
	@isTest
    public static void filterInvalidTest(){
        Integer count = 101;
        Exception ex;
        try{
            List <Job_Advertisement__c> jobsForTest = TestDataFactory.createDifferentJobAdvertisements(count);
            JobsLController.getJobs( new Map<String, Object>() ).size();
        }catch(Exception e ){
            ex = e;
        }
        System.assertNotEquals(ex, null);
    }
}
//System.assertEquals(count, JobsLController.getJobs( new Map<String, Object>() ).size() );