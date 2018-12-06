@isTest(seeAllData=false)
global class JobAdvertisementApiHelperTest {
    @isTest
    public static void ValidTest() {
        integer count = 1;
        Job_Advertisement__c jA = TestDataFactory.createJobAdvertisement(count)[0];    
        Test.startTest();
        String str = JobAdvertisementApiHelper.getOneJobAdvertisementAsJSON( jA.id );        
        System.assert(str.contains(jA.id)) ; 
        System.assert(str.contains(jA.name)) ; 
        //Delete row, check that DBObject is empty
        JobAdvertisementApiHelper.deleteJobAdvertisement(jA.id) ;         
        Test.stopTest();
        System.assertEquals(0, [SELECT ID from Job_Advertisement__c].size());
        JobAdvertisementsWrapper wr = new JobAdvertisementsWrapper();
        jA = new Job_Advertisement__c(Name = 'testing');
		String objectJSON = JSON.serialize( wr.convertToWrapper(jA));
        
        // create new record, check id
        String resultJSON = JobAdvertisementApiHelper.createJobAdvertisement(objectJSON);
        Job_Advertisement__c resultObj = [SELECT ID, Name from Job_Advertisement__c][0];
        System.assertEquals(true, resultJSON.contains(resultObj.id));        
        
        // update description
        resultObj.Description__c = 'Test Description';
        JobAdvertisementApiHelper.updateJobAdvertisementWithJSON(JSON.serialize( wr.convertToWrapper(resultObj)));
        System.assertEquals(resultObj.Description__c, [SELECT ID, Description__c from Job_Advertisement__c][0].Description__c);
       
    }
    @isTest
    public static void InvalidTest() {
        
        integer count = 1;
        Job_Advertisement__c jA = TestDataFactory.createJobAdvertisement(count)[0];
        String str = JobAdvertisementApiHelper.getOneJobAdvertisementAsJSON(jA.id);
        // try to create record with existing ID
        String exceptionMsg ; 
         Test.startTest();
        try{
            JobAdvertisementApiHelper.createJobAdvertisement(str);
        }catch(Task6Exception e ){
            exceptionMsg = e.getMessage();
        }
        System.assertEquals('DML Exception, record was not inserted', exceptionMsg);
        try{
            JobAdvertisementApiHelper.createJobAdvertisement('[ Invalid JSON String } }}');
        }catch(Task6Exception e ){
            exceptionMsg = e.getMessage();
        }        
        System.assertEquals('JSON serialization Exception', exceptionMsg);
        exceptionMsg = null;
       
        JobAdvertisementApiHelper.deleteJobAdvertisement(jA.id); 
         
        Test.stopTest();
        Integer emptySize = [SELECT ID from Job_Advertisement__c].size();
        System.assertEquals(0, emptySize);
       
          
        //remove ID, try to update deleted record        
        JobAdvertisementsWrapper wr = new JobAdvertisementsWrapper();
        jA = new Job_Advertisement__c(Name = 'testing');
		String objectJSON = JSON.serialize( wr.convertToWrapper(jA));
        try{
            JobAdvertisementApiHelper.updateJobAdvertisementWithJSON(objectJSON);
        }catch(Task6Exception e ){
            exceptionMsg = e.getMessage();
        }
        System.assert( exceptionMsg.contains('DMLException ,Record with ID:'));
        
        //updating with false JSON
        try{
            JobAdvertisementApiHelper.updateJobAdvertisementWithJSON('[ Invalid JSON String } }}');
        }catch(Task6Exception e ){
            exceptionMsg = e.getMessage();
        }        
        System.assertEquals('JSON serialization Exception', exceptionMsg);
        // Check that Object is Empty
        System.assertEquals(0, [SELECT ID from Job_Advertisement__c].size());       
 
	}
    @isTest
    public static void archivateValidTest(){
        integer count = 101;
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(count);
        List <String> ids = new List <String>();
        for(Job_Advertisement__c obj : jAs){
            ids.add(obj.id);
        }
        Test.startTest();
        String json = JSON.serialize( ids );
        JobAdvertisementApiHelper.archivateJobAdvertisementFromJSON(json);
        Test.stopTest();
        String newStatus = 'Archived';                 
        List <Job_Advertisement__c> createdObj = [Select ID, Name, Status__c from Job_Advertisement__c Where Status__c = : newStatus];
        System.assertEquals(count, createdObj.size());
    }
    @isTest
    public static void archivateInvalidJSONTest(){
        integer count = 5;
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(count);
        
        Test.startTest();
        String json = JSON.serialize( '[{"invalid JSON]}' );
        String exceptionMsg ;
        try{
        JobAdvertisementApiHelper.archivateJobAdvertisementFromJSON(json);
        }catch(Task6Exception e){
            exceptionMsg = e.getMessage();
        }
        Test.stopTest();
        String newStatus = 'Archived';                 
        List <Job_Advertisement__c> createdObj = [Select ID, Name, Status__c from Job_Advertisement__c Where Status__c = : newStatus];
        System.assertEquals(0, createdObj.size());
        System.assertEquals('JSON deserialization Exception', exceptionMsg);
    }
    @isTest
    public static void archivateInvalidIDsTest(){
        integer count = 5;
        List<Job_Advertisement__c> jAs = TestDataFactory.createJobAdvertisement(count);
        List <String> ids = new List <String>();
        for(Job_Advertisement__c obj : jAs){
            ids.add(obj.id);
        }        
        Test.startTest();
        String json = JSON.serialize( ids );
        String exceptionMsg ;
        // remove all records 
        delete jAs;
        try{
            JobAdvertisementApiHelper.archivateJobAdvertisementFromJSON(json);
        }catch(Exception e){
            exceptionMsg = e.getMessage();
        }
        System.debug('archivateInvalidIDsTest end : ' + exceptionMsg);
        
        String newStatus = 'Archived';                 
        List <Job_Advertisement__c> createdObj = [Select ID, Name, Status__c from Job_Advertisement__c Where Status__c = : newStatus];
        System.assertEquals(0, createdObj.size());
        System.assertEquals(null, exceptionMsg);
        Test.stopTest();
    }
    @isTest
    public static void jobQueueableInvalidIDsTest(){
        JobAdvertisementApiHelper.JobQueueable job = new JobAdvertisementApiHelper.JobQueueable(new List <Job_Advertisement__c>{new Job_Advertisement__c()}, 'update');    
        Test.startTest();
        String exceptionMsg ;
        // update mock collection 
        try{
            job.execute(null);
        }catch(Exception e){
            exceptionMsg = e.getMessage();
        }
        System.assertEquals(null, exceptionMsg);
        Test.stopTest();
    }
}