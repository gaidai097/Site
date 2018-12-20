public class JobsLController {
   
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
    public static Integer getTotalCount(Map<String, Object> params){
        System.debug(params);
        Integer totalCount = JobsLControllerHelper.getTotalRecordsCount(
            (String)params.get('nameFilter'),
            (String)params.get('publishedDate'),
            (String)params.get('dateFilter'),
            (String)params.get('salaryFilter'),
            (String)params.get('salaryParam')
        ); 
        return totalCount;
    }
}