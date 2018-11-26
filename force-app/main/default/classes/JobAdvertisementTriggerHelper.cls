public class JobAdvertisementTriggerHelper {
    
    public static void removeCVs( List <Job_Advertisement__c> jobs ){
        System.debug('jobs => ' + jobs);
        Set <ID> jobsIds = (new Map <ID,Job_Advertisement__c >( jobs )).keySet();
        try{
            List <CV__c> cvsToDelete = getCvs ( jobsIds );
            if(!cvsToDelete.isEmpty()){
                removeAllImages( (new Map < ID, CV__c >( cvsToDelete )).keySet() );
            	delete cvsToDelete;
            }
        }catch(Exception e){
            System.debug( ' DB exception : ' + e.getMessage());
        }
    }
    public static List <CV__c> getCvs( Set<ID> jobsIds ){
        // Select junction objects CV - Job
        List <CVJA__c> cvjas = [ SELECT CV__c, ID FROM CVJA__c WHERE Job_Advertisement__c IN :jobsIds ];
        System.debug('cvjas => ' + cvjas);
        //Form Set of related CVs        
        Set <ID> cvsIds = new Set <ID>();
        for(CVJA__c cvs: cvjas){
        	cvsIds.add( cvs.CV__c );
        }
        delete cvjas;
        System.debug('cvsIds => ' + cvsIds);
        List <CVJA__c> cvjasNotForDelete = [ SELECT CV__c, ID FROM CVJA__c WHERE CV__c IN :cvsIds ];
        //Find CVs which related to another Jobs 
        System.debug('cvjasNotForDelete => ' + cvjasNotForDelete);
        for( CVJA__c cvjaNotDelete : cvjasNotForDelete ){
            if(cvsIds.contains(cvjaNotDelete.CV__c)){
                cvsIds.remove( cvjaNotDelete.CV__c );
            }
        }
        List <CV__c> cvsToDelete = new List <CV__C> ();
        for( ID cvId : cvsIds ){
            cvsToDelete.add(new CV__C(ID = cvId));
        }
        System.debug('cvsToDelete => ' + cvsToDelete);
        return cvsToDelete;
    }
    public static void removeAllImages( Set <ID> cvIds ){
        List <ContentDocument> documents = new List <ContentDocument>();
        for(ContentVersion conVer : [ Select id, ContentDocumentId, ContentDocument.LatestPublishedVersionId from ContentVersion where CV__c IN :cvIds]){
        	documents.add(new ContentDocument( ID = conVer.ContentDocumentId ));
        }
        delete documents;
    }    
}