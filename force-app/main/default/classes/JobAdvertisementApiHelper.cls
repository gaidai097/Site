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
    public static void deleteJobAdvertisement(String id){
        Job_Advertisement__c obj = new Job_Advertisement__c(ID = id);
        try{
            delete obj;
        }catch(DMLException e){
            System.debug('False deleting : e ' + e );
            throw new Task6Exception('DML exception, record was not deleted !');
        }    	
    }
    public static void archivateJobAdvertisementFromJSON( String json ){
        System.debug('json archivation :  ' + json );
        try{
            LIst <String> ids = (List<String>)System.JSON.deserialize(json, List<String>.class);
            if(ids ==null || ids.isEmpty()) return;
            List <Job_Advertisement__c> jobs = new  List <Job_Advertisement__c>();
            for(String id: ids){
                jobs.add(new Job_Advertisement__c(ID = id, Status__c = 'Archived'));
                System.debug('id archivation :  ' + id );
            }
            update jobs;
        }catch(DMLException e){
            System.debug('False archivation : e ' + e );
            throw new Task6Exception('DML exception, record was not archived !');
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
    
}