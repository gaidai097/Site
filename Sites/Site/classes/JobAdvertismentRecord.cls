@RestResource(urlMapping='/JobAdvertisementRecord')
global with sharing class JobAdvertismentRecord {
    @HttpGet
    global static void doGet(){
        RestResponse res = RestContext.response;
        try{
            String id = RestContext.request.params.get('id');
            String json = JobAdvertisementApiHelper.getOneJobAdvertisementAsJSON(id);
            if( json != null && json != ''){
                RestContext.response.responseBody =  Blob.valueOf( json );
            }
            res.statusCode = 200;        
        }catch(Exception e ){
            System.debug('Current record was not received, Exception e ' + e);
            res.responseBody = Blob.valueOf( 'Exception during retrieving records' );
            RestContext.response.statusCode = 500;
        }
    }    
    @HttpDelete
    global static void doDelete(){
        RestResponse res = RestContext.response;
        try{
            String id = RestContext.request.params.get('id'); 
            JobAdvertisementApiHelper.deleteJobAdvertisement(id);
            res.statusCode = 200;
            res.responseBody = Blob.valueOf( 'success' );
        }catch(Task6Exception e ){
            res.responseBody = Blob.valueOf( e.getMessage() );
            RestContext.response.statusCode = 500;            
        }catch(Exception e ){
            System.debug('Record was not deleted, Exception e ' + e);
            res.responseBody = Blob.valueOf( 'Record was not deleted' );
            RestContext.response.statusCode = 500;            
        }        
    }
    @HttpPost
    global static void doPost(){
        RestResponse res = RestContext.response;
        try{
            String jobAdvertisementId = JobAdvertisementApiHelper.createJobAdvertisement( RestContext.request.requestBody.toString() );
            RestContext.response.responseBody = Blob.valueOf( jobAdvertisementId );
        }catch(Task6Exception e ){
            res.responseBody = Blob.valueOf( e.getMessage() );
            RestContext.response.statusCode = 500;
        }catch(Exception e ){
            System.debug('Exception catched during insertion, Exception e ' + e);
            res.responseBody = Blob.valueOf( 'Exception catched during insertion' );
            RestContext.response.statusCode = 500;            
        }
    }
    @HttpPut
    global static void doPut(){
        RestResponse res = RestContext.response;
        try{
            JobAdvertisementApiHelper.updateJobAdvertisementWithJSON( RestContext.request.requestBody.toString());
            res.responseBody = Blob.valueOf( 'success' );
            RestContext.response.statusCode = 200;  
        }catch(Task6Exception e ){
            res.responseBody = Blob.valueOf( e.getMessage() );
            RestContext.response.statusCode = 500;            
        }catch(Exception e ){
            System.debug('Exception catched during updating, Exception e ' + e);
            res.responseBody = Blob.valueOf( 'Exception catched during updating' );
            RestContext.response.statusCode = 500;            
        }
    }
}