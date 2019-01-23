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
    @AuraEnabled 
    public static String saveCV(List<String> selectedIDs, CV__c cv, Blob cvPhoto, String cvPhotoName){
        
        System.debug('*******-------*******');
        System.debug(selectedIDs.size());
        System.debug(selectedIDs);
        System.debug('Phone__c '+ cv.Age__c);
        System.debug('Phone__c '+ cv.Phone__c);
        System.debug('Phone__c '+ cv.Age__c);
        System.debug(cvPhoto.size());
        System.debug(cvPhotoName);
        System.debug('*******=======*******');
        
        List <Job_Advertisement__c> jobs = new List <Job_Advertisement__c>();
        for(String jobId : selectedIDs){
            jobs.add(new Job_Advertisement__c( ID = jobId ));
        }
        try{
            Map<Id,Job_Advertisement__c> jobsMap = Task9ControllerHelper.saveCV(cv, jobs, cvPhoto, cvPhotoName);
            System.debug( ' ** ' + jobsMap.size());
            return 'saved successfully';
        }catch( Task6Exception e ){
            system.debug(' e ' + e.getMessage());
            return e.getMessage();
        }
        catch( Exception e ){
            system.debug(' e ' + e.getMessage());
            return e.getMessage();
        }
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