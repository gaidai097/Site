public class JobsLController {
   
    @AuraEnabled
    public static List<Job_Advertisement__c> getJobs( Map<String, Object> params){        
        System.debug(params);
        try{ 
            Map <String, String> stringParams = transformParamsMap(params);
            JobsLControllerHelper jch = new JobsLControllerHelper();
            List <Job_Advertisement__c> result = jch.getPageRecords(stringParams);   
            return result;
        }catch( Task6Exception e ){
            System.debug(' e ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }catch( Exception e ){
            System.debug(' e ' + e.getMessage());
            throw new AuraHandledException('Unexpected server Exception, try again!');
        }
    }
    @AuraEnabled
    public static Integer getTotalCount(Map<String, Object> params){
        System.debug(params);
        try{ 
            Map <String, String> stringParams = transformParamsMap(params);
            JobsLControllerHelper jch = new JobsLControllerHelper();
            Integer totalCount = jch.getTotalRecordsCount(stringParams); 
            System.debug( 'totalCount ' + totalCount  );
            return totalCount;
        }catch( Task6Exception e ){
            System.debug(' Task6Exception ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }catch( Exception e ){
            System.debug(' e ' + e.getMessage());
            throw new AuraHandledException('Unexpected server Exception, try again!');
        }
    }
    @AuraEnabled 
    public static String saveCV(List<String> selectedIDs, CV__c cv, Blob cvPhoto, String cvPhotoName){        
        try{
            List <Job_Advertisement__c> jobs = new List <Job_Advertisement__c>();
            for(String jobId : selectedIDs){
                jobs.add(new Job_Advertisement__c( ID = jobId ));
            }
            Map<Id,Job_Advertisement__c> jobsMap = Task9ControllerHelper.saveCV(cv, jobs, cvPhoto, cvPhotoName);            
            return 'Saved successfully !';
        }catch( Task6Exception e ){
            System.debug(' Task6Exception ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }catch( Exception e ){
            System.debug(' e ' + e.getMessage());
            throw new AuraHandledException('Unexpected server Exception, CV was not save correctly, try again!');
        }
    }   
    
    public static Map <String, String> transformParamsMap(Map<String, Object> params){
        try{
            if( params == null || params.isEmpty()) return new Map <String, String> ();
            Map <String, String> stringParams = new Map <String, String> ();
            for(String key : params.keySet() ){
                stringParams.put(key, (String) params.get(key));
            }
            return stringParams; 
        }catch( Exception e ){
            throw new Task6Exception('Request parameters were not parsed successfully');
        }
    }
}