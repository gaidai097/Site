public class JobsLController {
 // STERN LECTURE ABOUT WHAT'S MISSING HERE COMING SOON
    @AuraEnabled
    public static List<Job_Advertisement__c> getJobs(Map<String, Object> params){        
        System.debug(params);
        List <Job_Advertisement__c> result = JobsLControllerHelper.getPageRecords(
            (String)params.get('pageNumber'),
            (String)params.get('pageSize'),
            (String)params.get('nameFilter'),
            (String)params.get('publishedDate'),
            (String)params.get('dateFilter'),
            (String)params.get('salaryFilter'),
            (String)params.get('salaryParam')
        );   
        return result;
    }
    @AuraEnabled
    public static Integer getTotalCount(String pageNumber, String pageSize, String nameFilter, String dateFilter, String salaryFilter){
        Integer totalCount = [SELECT COUNT() FROM Job_Advertisement__c];
        return totalCount;
    }
}