@RestResource(urlMapping='/archivateJobAdvertisement')
global class ArchivateJobAdvertisement {
	  
    @HttpPost
    global static void  doPost(){
        RestResponse res = RestContext.response;
        try{  
            JobAdvertisementApiHelper.archivateJobAdvertisementFromJSON(RestContext.request.requestBody.toString());
            res.statusCode = 200; 
            res.responseBody = Blob.valueOf( 'success' );
        }catch(Task6Exception e ){
            res.responseBody = Blob.valueOf( e.getMessage() );
            RestContext.response.statusCode = 500;            
        }catch(Exception e ){
            System.debug('Records were not archived, Exception e ' + e);
            res.responseBody = Blob.valueOf( 'Records were not archived' );
            RestContext.response.statusCode = 500;            
        }        
    }
}