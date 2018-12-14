@isTest
public class JobsLControllerTest {
    @isTest
    public static void getJobsTest() {
        List<Job_Advertisement__c> jobs = JobsLController.getJobs();      
    }
}