@RestResource(urlMapping='/newCVs')
global with sharing class CVApi {
    @HttpGet
    global static void  doGet(){
        // Link for uploading
        // https://task9-developer-edition.eu16.force.com/Task9/sfc/servlet.shepherd/version/download/0681t000000gqBzAAI
        RestResponse res = RestContext.response;
        try{
            String start = RestContext.request.params.get('start');
            String offset = RestContext.request.params.get('offset');
            String limitSize = RestContext.request.params.get('limit');
            if( start == 'true'  ){
                Integer count = CVApiHelper.getNewCVsCount();
                RestContext.response.responseBody = Blob.valueOf( String.valueOf(count));
            }else if( offset != null && limitSize != null ){
                String json = JSON.serialize( CVApiHelper.getCVsWithImageIds(offset, limitSize));
                RestContext.response.responseBody = Blob.valueOf( json);                
            }else{
                throw new Task6Exception(' Invalid URL parameters ');
            }
            res.statusCode = 200; 
        }catch(Exception e ){
            RestContext.response.responseBody = Blob.valueOf( 'Records were not received , ' + e.getTypeName() +' ' + e.getMessage());
            System.debug('Records were not received, Exception e ' + e);
            res.statusCode = 500; 
        }        
    } 
}