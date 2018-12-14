public class JobsLController {
 // STERN LECTURE ABOUT WHAT'S MISSING HERE COMING SOON
    @AuraEnabled
    public static List<Job_Advertisement__c> getJobs() {
        
       
        // OK, they're cool, let 'em through
        return [SELECT Id, Name, Email__c, Phone__c, Status__c, Education__c, SalaryMin__c, SalaryMax__c, Location__c, Manager_name__c, CreatedDate FROM Job_Advertisement__c];
    }
}