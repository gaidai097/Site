public with sharing class Task9ControllerHelper {

    public static Map<Id,Job_Advertisement__c> saveCV(CV__c cv, List <Job_Advertisement__c> jobs , Blob image , String fileName){
		validateCV(cv);
        Map<Id,Job_Advertisement__c> jobsMap = filterSelectedJobs(new Map<Id,Job_Advertisement__c>(jobs) , cv.Email__c);
        if( jobsMap.isEmpty() ) throw new Task6Exception(Label.All_selected_Jobs_were_checked);
        insertCV(cv);        
        insertCVJs(cv, jobsMap);
        sendEmailNotification(cv, jobsMap.values() );
        saveImage( cv, image, fileName);
        return jobsMap;
    }
    public static void validateCV(CV__c cv){
        if( !Pattern.matches('[1-9]{1}[0-9]{1}', cv.age__c) || Integer.valueOf(cv.age__c) < 18 ){
            throw new Task6Exception(Label.Incorrect_Age);
        }
        if( !Pattern.matches('^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$', cv.Email__c)){
            throw new Task6Exception(Label.Incorrect_Email);
        }
        if( !Pattern.matches('([0-9\\(\\)\\/\\+ \\-]){7,20}', cv.Phone__c)){
            throw new Task6Exception(Label.Incorrect_Phone_number);
        }
    }
    public static void insertCV( CV__c cv ){
        try{
            insert cv;
        }catch(Exception e){
            System.debug('Exception inserting e ' + e.getCause() + ' ' + e.getLineNumber() +' ' + e.getMessage());
            throw new Task6Exception( Label.Your_CV_was_not_saved_successfully);
        }
    }
    public static void insertCVJs( CV__c cv, Map<Id, Job_Advertisement__c> jobsMap){
        try{
            List <CVJA__c>cvjas = new List <CVJA__c>();
            for(ID id: jobsMap.keySet()){
                cvjas.add( new CVJA__c(Job_Advertisement__c = id, Email__c = cv.Email__c, CV__c = cv.id) );
            }
            insert cvjas;
        }catch(Exception e){
            System.debug('Exception inserting e ' + e.getCause() + ' ' + e.getLineNumber() +' ' + e.getMessage());
            throw new Task6Exception( Label.CVJAs_were_not_saved_successfully);
        }
    }
    

    public static void sendEmailNotification( CV__c cv, List <Job_Advertisement__c> jobs ){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses( new String[]{ cv.Email__c } );
        email.setSubject( ' Hello, ' + cv.Name );
        if(jobs[0].Name == null){
            jobs = [SELECT ID, Name FROM Job_Advertisement__c WHERE ID IN :jobs];
        }
        String body = ' Your CV was successfully posted for these Jobs: \n  ' + jobs[0].Name ;
        for( Integer i = 1; i < jobs.size(); i++ ){
            body += ', \n  ' + jobs[i].Name  ;
        }
        body += ' . ' ;
        email.setPlainTextBody( body );
        Messaging.sendEmail( new Messaging.SingleEmailMessage[] { email });
    }
    public static Map <Id,Job_Advertisement__c> filterSelectedJobs(Map <Id,Job_Advertisement__c> jobsMap, String email){
        Map <Id,Job_Advertisement__c> filteredJobsMap = jobsMap;
        for(CVJA__c cvja: [SELECT ID, Job_Advertisement__c FROM CVJA__c WHERE Email__c =:email]){
            if( filteredJobsMap.keySet().contains(cvja.Job_Advertisement__c )) {
                filteredJobsMap.remove(cvja.Job_Advertisement__c);
                System.debug('Removed ' +cvja.Job_Advertisement__c );
            }
        }
        return filteredJobsMap;
    }
    public static void saveImage( CV__c cv, Blob image ,String fileName){
        ContentVersion conVer = new ContentVersion( CV__c = cv.id, SharingOption = 'A',SharingPrivacy = 'N',                                                   
                                                   VersionData = image, title = fileName, PathOnClient = fileName , Description = 'CVImage');
        saveContentVersion( cv, conVer);
    }
    public static void saveContentVersion( CV__c cv, ContentVersion conVer){
        try {
            ContentVersion con = conVer;
            insert con;
            System.debug(' saveContentVersion conVer.id  ' + conVer.id); 
            ID idcon = con.id;
            ID docId = [ SELECT ID FROM ContentDocument where LatestPublishedVersionId = :idcon][0].id;            
            ContentDocumentLink link = new ContentDocumentLink(LinkedEntityId = UserInfo.getOrganizationId(), ShareType = 'C', ContentDocumentId = docId , Visibility = 'AllUsers');
            insert link ;
        }catch (Exception e){
            System.debug('Exception uploading e ' + e.getCause() + ' ' + e.getLineNumber() +' ' + e.getMessage());
            throw new Task6Exception( ' Your Image was not saved successfully, contact the site administrator!');
        }
    }
    public static String formQuery( Task9Controller con ){
        if( con.size == null || con.size == 0) con.size = 10;
        String queryString = 'Select Name,ID, Location__c, Status__c,Phone__c, Email__c,Education__c, Manager_name__c, SalaryMax__c, CreatedDate, SalaryMin__c from Job_Advertisement__c WHERE Status__c != \'Archived\'';
        List <String> paramsRows = new List <String>();
        if( con.nameFilter != null && con.nameFilter != '' ){
            paramsRows.add(' Name LIKE ' + '\'%' + con.nameFilter + '%\'');
        }
        if(con.publishedDate != null && con.publishedDate <= System.today()){
            if( con.dateFilter != 'ALL' || con.dateFilter != null || con.dateFilter!=''){
                String dateFilter = con.dateFilter;
                Date publishedDate = con.publishedDate;
                
                if( con.dateFilter == 'DAY' || con.dateFilter == null || con.dateFilter=='')paramsRows.add(' DAY_ONLY(convertTimezone(CreatedDate)) = :publishedDate' );
                if( con.dateFilter == 'BEFORE' ) paramsRows.add(' DAY_ONLY(convertTimezone(CreatedDate)) <= :publishedDate'  );
                if( con.dateFilter == 'AFTER' ) paramsRows.add(' DAY_ONLY(convertTimezone(CreatedDate)) >= :publishedDate'  );
            }
        }
        if(con.salaryParam != null && con.salaryParam != 0 && con.salaryFilter != null){
            Integer salaryParam = con.salaryParam;
            String salaryFilter = con.salaryFilter;
            switch on con.salaryFilter{
                when 'LESS' { paramsRows.add(' SalaryMin__c < :salaryParam '); }
                when 'MORE' {paramsRows.add(' (SalaryMax__c > :salaryParam OR (SalaryMin__c !=null AND SalaryMax__c = null)) ');}
                when 'EQUAL' { paramsRows.add(' SalaryMin__c <= :salaryParam AND (SalaryMax__c >= :salaryParam OR SalaryMax__c = null )');}
                when 'NOTEQUAL' {paramsRows.add(' ((SalaryMin__c > :salaryParam OR SalaryMax__c < :salaryParam) OR SalaryMin__c = null)');}
                when 'LESSOREQUAL' { paramsRows.add(' SalaryMin__c <= :salaryParam '); }
                when 'MOREOREQUAL' {
                    paramsRows.add(' (SalaryMax__c >= :salaryParam OR (SalaryMin__c !=null AND SalaryMax__c = null)) ');
                }
            }
        }
        if(paramsRows != null && !paramsRows.isEmpty()){
           
                for(integer i = 0; i< paramsRows.size(); i++){
                    queryString += ' AND ' + paramsRows[i];
                }
                              
        }
        System.debug('queryString => ' + queryString);
        queryString += ' ORDER BY Name ';
        return queryString;
    }
}