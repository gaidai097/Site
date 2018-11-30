global with sharing class JobAdvertisementApiHelper {
	
    
    public static String getOneJobAdvertisementAsJSON(String id){
        try{
            Job_Advertisement__c job = selectJobAdvertisementById(id);
            if( job == null ) return null;
            JobAdvertisementsWrapper wr = new JobAdvertisementsWrapper();
            String resultJSON = JSON.serialize( wr.convertToWrapper(job) );
            return resultJSON;
        }catch(Exception e ){
            throw new Task6Exception('Query exception, record was not selected !');
        }
        
    }
    public static Job_Advertisement__c selectJobAdvertisementById(String id){        
        return [SELECT id, Name, Phone__c, Location__c, Skills_Required__c,Status__c,
               Email__c,  Manager_name__c, Description__c  ,Education__c,
               SalaryMax__c, SalaryMin__c 
               FROM Job_Advertisement__c 
               where ID=:id limit 1
              ][0];         
    }
    public static void deleteJobAdvertisement(String idToDelete){
        System.debug('deleteJobAdvertisement ' + idToDelete);
        if( idToDelete == null || idToDelete == '') throw new Task6Exception('There is no ID for deleting'); 
        try{
            List <Job_Advertisement__c> jobs = [Select ID, Status__c From Job_Advertisement__c WHERE ID = :idToDelete];
            System.debug('jobs for removing ===> ' +jobs);
            System.enqueueJob(new JobQueueable(jobs, 'delete')); 
        }catch(DMLException e){
            System.debug('False deleting : e ' + e );
            throw new Task6Exception('DML exception, record was not deleted !');
        }    	
    }
    public static void archivateJobAdvertisementFromJSON( String json ){
        System.debug('json archivation :  ' + json );
        try{
            List <String> ids = (List<String>)System.JSON.deserialize(json, List<String>.class);
            if( ids == null || ids.isEmpty()) throw new Task6Exception('There is no any ID for archiving');            
            List <Job_Advertisement__c> jobs = [Select ID,Name, Status__c From Job_Advertisement__c WHERE ID IN : ids];
            for(Job_Advertisement__c job: jobs){
                job.Status__c = 'Archived';
            }            
            System.enqueueJob(new JobQueueable(jobs, 'update'));          
        }catch(JSONException e){
            System.debug('False deserialization : e ' + e.getMessage() );
            throw new Task6Exception('JSON deserialization Exception');
        }
    }
    
    public static String createJobAdvertisement(String str){
        try{ 
        	JobAdvertisementsWrapper modelWrapped = (JobAdvertisementsWrapper) JSON.deserialize( str, JobAdvertisementsWrapper.class);
        	Job_Advertisement__c obj = JobAdvertisementsWrapper.convertFromWrapper(modelWrapped);            
        	return insertJobAdvertisement(obj);
        }catch(JSONException e){
            System.debug('False insertion : e ' + e );
            throw new Task6Exception('JSON serialization Exception');
        }
    }
    public static String insertJobAdvertisement(Job_Advertisement__c obj){
        try{
        	insert obj;
            return obj.id;
        }catch(DMLException e){
            System.debug('DML Exception: False insertion : e ' + e );
            throw new Task6Exception('DML Exception, record was not inserted');
        }
    }
    public static void updateJobAdvertisementWithJSON(String str){
        try{
            JobAdvertisementsWrapper modelWrapped = (JobAdvertisementsWrapper)JSON.deserialize( str, JobAdvertisementsWrapper.class);
            Job_Advertisement__c model = JobAdvertisementsWrapper.convertFromWrapper(modelWrapped); 
            updateJobAdvertisement(model);        
            //return JSON.serialize(modelWrapped.convertToWrapper(resultObj));  
        }catch(JSONException e){
            System.debug('False convertion : e ' + e );
            throw new Task6Exception('JSON serialization Exception');
        }         	
    }
    public static void updateJobAdvertisement(Job_Advertisement__c obj){
        try{ 
            update obj;
        }catch(DMLException e){
            System.debug('False updating : e ' + e );
            throw new Task6Exception('DMLException ,Record with ID:' + obj.id + ' was not updated !');          
        }   
    }  
    
    public class JobQueueable implements Queueable {
        private List <Job_Advertisement__c> jobs;
        private String operation;
        public JobQueueable(List <Job_Advertisement__c> jobs, String operation){
            this.jobs = jobs;
            this.operation = operation;
        }
        public void execute(QueueableContext context) { 
            if(operation == 'update') update jobs;
            if(operation == 'delete') delete jobs;            
        }
    }
    
}