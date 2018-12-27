public class JobsLController {
   
    @AuraEnabled
    public static List<Job_Advertisement__c> getJobs(Map<String, Object> params){        
        System.debug(params);
        Map <String, String> stringParams = transformParamsMap(params);
        JobsLControllerHelper jch = new JobsLControllerHelper();
        List <Job_Advertisement__c> result = jch.getPageRecords(stringParams);   
        return result;
    }
    @AuraEnabled
    public static Integer getTotalCount(Map<String, Object> params){
        System.debug(params);
        Map <String, String> stringParams = transformParamsMap(params);
        JobsLControllerHelper jch = new JobsLControllerHelper();
        Integer totalCount = jch.getTotalRecordsCount(stringParams); 
        System.debug( 'totalCount ' + totalCount  );
        return totalCount;
    }
    
    public static Map <String, String> transformParamsMap(Map<String, Object> params){
        if( params == null || params.isEmpty()) return new Map <String, String> ();
        Map <String, String> stringParams = new Map <String, String> ();
        for(String key : params.keySet() ){
            stringParams.put(key, (String) params.get(key));
        }
        return stringParams;        
    }
}