public with sharing class Task9Controller {
    public String msgInfo {public get; public set;}
    public String msgError {public get; public set;}
    public String salaryFilter {public get; public set;}
    public String nameFilter;
    public String dateFilter {public get; public set;}
    public String cvFirstName {public get; public set;}
    public String cvLastName {public get; public set;}
    public String fileName {public get; public set;}
    public Integer salaryParam {public get; public set;}
    public Integer noOfRecords {get; set;}
    public Integer size;
    public Integer rowIndex {get; set;}
    public Date publishedDate ;
    public Blob image {get; set;}
    public List <VacancyWrapper> jobs ;
    public List <Job_Advertisement__c> selectedJobs ;
    public List<Job_Advertisement__c> currentList = new List<Job_Advertisement__c>();
    public ApexPages.StandardSetController ssc { get; set; }
    public Set <ID> checkedIDs = new Set <ID>();    
    public CV__c cv {get;set;}
        
    public List <Job_Advertisement__c> getSelectedJobs(){
        return selectedJobs;
    }
   
    public integer getCheckedIDsSize(){
        if(checkedIDs == null)return 0;
        return checkedIDs.size();
    }
    public String getSelectedSize(){
        System.debug('getSelectedSize() ');
        if(selectedJobs == null || selectedJobs.size() == 0) return '0';
        if(selectedJobs.size() <10) return '0'+ selectedJobs.size();
        return selectedJobs.size()+'' ;
    }
    public void setPublishedDate(Date publishedDate){
        System.debug('setPublishedDate => ' + publishedDate);
        this.publishedDate = publishedDate;
        refreshSSC();
    }
    public Date getPublishedDate(){
        System.debug('getPublishedDate => ' + publishedDate);
        return publishedDate;
    }
    
    public List <VacancyWrapper> getJobs(){       
        List <Job_Advertisement__c> fetchedJobs = new List<Job_Advertisement__c>();           
        for(Job_Advertisement__c a : ( List<Job_Advertisement__c> ) ssc.getRecords()) fetchedJobs.add(a);
        System.debug('getJobs ' + size);
        List <VacancyWrapper> vacancies = new List <VacancyWrapper>();
        for(integer i = 0; i < fetchedJobs.size(); i++){
            VacancyWrapper vacancy = new VacancyWrapper();
            vacancy.job = fetchedJobs[i];
            vacancy.isSelected = (checkedIDs.contains(fetchedJobs[i].id)) ? true : false;
            vacancy.index = i;
            vacancies.add(vacancy);
        }
        currentList = fetchedJobs;  
        return vacancies;
    }
    
    public Task9Controller(){
        salaryFilter = 'EQUAL';
        dateFilter = 'ALL';
        cv = new CV__c();
        if(ssc == null) refreshSSC();               
    }
    public void clearMSGs(){
        this.msgInfo = null ;
        this.msgError = null ;
    }
    public void doChecked(){
        
        List <Job_Advertisement__c> recordsOnPage = currentList;        
        if( selectedJobs == null ){
            selectedJobs= new List<Job_Advertisement__c>();
            checkedIDs = new Set<ID>();
        }
        if(!checkedIDs.contains( recordsOnPage[rowIndex].ID )){
            addSelectedRow( recordsOnPage );            
        }else{
            checkedIDs.remove( recordsOnPage[rowIndex].ID );
            for(integer i = 0; i< selectedJobs.size(); i++){
                if( selectedJobs[i].id == recordsOnPage[rowIndex].ID ){
                    selectedJobs.remove(i);
                    break;
                }                
            }
        }   
    }
    public void addSelectedRow( List <Job_Advertisement__c> recordsOnPage){
        if(selectedJobs.size() == 0){
            selectedJobs.add( recordsOnPage[rowIndex]);
        }else{
            selectedJobs.add(0, recordsOnPage[rowIndex]);
        }
        checkedIDs.add(recordsOnPage[rowIndex].ID);
    }
    public void removeChecked(){        
        ID idToRemove = selectedJobs.get(rowIndex).id;
        selectedJobs.remove(rowIndex);
        checkedIDs.remove(idToRemove);
    }
  
    public void refreshSSC(){
        clearMSGs();
        System.debug('refreshSSC() ');
        String queryString = Task9ControllerHelper.formQuery(this);
        ssc = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
        ssc.setPageSize(size);
        noOfRecords = ssc.getResultSize();
    }
    public void saveCV(){
            
        try{
            filterImage();
            filterName();            
            Map<Id,Job_Advertisement__c> filteredJobsMap = Task9ControllerHelper.saveCV( cv , selectedJobs, image ,fileName);
            formResultMsg(filteredJobsMap);
            clearFields();  
        }catch( Task6Exception e ){
            this.image = null;
            System.debug( ' saving => ' +  e.getCause() + ' ' + e.getLineNumber() +' ' + e.getMessage() );
            msgError = e.getMessage();
        }
       // cloneCVS();
       // duplicateCloning(); 
    }
    public void filterImage(){
        if(image == null || image.size() > 1024*128){
            throw new Task6Exception( 'File is too big! Select a file less than 128K');            
        }
    }
    public void filterName(){
        if( !Pattern.matches('[A-Z]{1}[a-z]{1,12}', cvFirstName) || !Pattern.matches('[A-Z]{1}[a-z]{1,12}', cvLastName)){               
            throw new Task6Exception( 'Incorrect Name !');                    
        }
        cv.Name = cvFirstName + ' ' + cvLastName ;
    }
    public void formResultMsg( Map<Id,Job_Advertisement__c> filteredJobsMap ){
        List <String> approvedJobs = new List <String> ();
        List <String> removedJobs = new List <String> ();
        for(Job_Advertisement__c selected: selectedJobs){
            if( filteredJobsMap.containsKey(selected.id)){
                approvedJobs.add(selected.Name);
            }else{
                removedJobs.add(selected.Name);
            }
        }
        if(approvedJobs.size() == selectedJobs.size()){
            msgInfo = 'CV successfully saved for all jobs';
        }else{
            msgInfo ='CV was posted for ' + approvedJobs + '\n ' + 'Removed jobs, which were selected before ' + removedJobs;
        }
    }
    public void clearFields(){
        cv.Salary__c = null;
        cv.id = null;
        checkedIDs.clear();
        selectedJobs.clear();
    }
  /*
    public void duplicateCloning(){
          
        cvLastName= cvLastName + 'o';
        cv.Email__c = 'o'+ cv.Email__c;
        cloneCVS(); 
        cvLastName= cvLastName + 'f';
        cv.Email__c = 'f'+ cv.Email__c;
        cloneCVS(); 
        
        cv.Email__c = 'k'+ cv.Email__c;
        cloneCVS();
        cv.Email__c = 'b'+ cv.Email__c;
        cloneCVS();       
        cv.Email__c = 'c'+ cv.Email__c;
        cloneCVS(); 		
        cv.Email__c = 'w'+ cv.Email__c;
        cloneCVS();       
        cv.Email__c = 'a'+ cv.Email__c;
        cloneCVS();
        cv.Email__c = 'e'+ cv.Email__c;
        cloneCVS();
        cv.Email__c = 'i'+ cv.Email__c;
        cloneCVS();
        cv.Email__c = 'u'+ cv.Email__c;
        cloneCVS();
		
        cv.Email__c = 'y'+ cv.Email__c;
        cloneCVS();
        cv.Email__c = 't'+ cv.Email__c;
        cloneCVS();
        cv.Email__c = 'r'+ cv.Email__c;
        cloneCVS();
        cv.Email__c = 's'+ cv.Email__c;
        cloneCVS();
	
    }
    
    public void cloneCVS() {
        List <CV__c> cvs = new List <CV__c>();
        List <ContentVersion> images = new List <ContentVersion>();
        List <ContentDocumentLink> links = new List <ContentDocumentLink>();
        List <CVJA__c> cvjas = new List <CVJA__c>();
        String nameBasic = cvFirstName + ' ' + cvLastName ;
        Integer count = 200;
        String emailBasic =  cv.Email__c ;
        for(Integer i = 0; i<count; i++){
            CV__c someCV = new CV__c();
            someCV.Email__c = i+  emailBasic;
            someCV.Name = nameBasic + i;
            someCV.Additional_info__c = 'test'+i;
            someCV.Salary__c = cv.Salary__c;
            someCV.Status__c = cv.Status__c;
            someCV.Phone__c = cv.Phone__c;
            someCV.Age__c = cv.Age__c;
            cvs.add(someCV);
        }
        insert cvs;
        for(CV__c cvVar : cvs){
            
            cvjas.add( new CVJA__c(Job_Advertisement__c = selectedJobs[0].id, Email__c = cvVar.Email__c, CV__c = cvVar.id) );
        }
        insert cvjas;
      
        for(CV__c cvVar : cvs){
            images.add( 
                new ContentVersion(
                    CV__c = cvVar.id, SharingOption = 'A',SharingPrivacy = 'N',                                                   
                    VersionData = image, title = fileName, PathOnClient = fileName , Description = 'CVImage'
                )
            );
            cvjas.add( new CVJA__c(Job_Advertisement__c = selectedJobs[0].id, Email__c = cvVar.Email__c, CV__c = cvVar.id) );
        }
        insert images;
        Map<Id,ContentVersion> conVerMap = new Map<Id,ContentVersion>(images);
        List<ContentDocument> docs = [ SELECT ID,LatestPublishedVersionId FROM ContentDocument where LatestPublishedVersionId = :conVerMap.keySet()];         
        for(ContentDocument doc: docs){
            links.add(
                new ContentDocumentLink(LinkedEntityId = UserInfo.getOrganizationId(), ShareType = 'C', ContentDocumentId = doc.id , Visibility = 'AllUsers')
            );
        }
        insert links;
        insert cvjas;
		
        
    }
*/
    public void refresh() {
        nameFilter = null;
        salaryFilter = 'EQUAL';
        dateFilter = 'ALL';
        publishedDate = null;
        salaryParam = null;
        refreshSSC();
    }
    
    public void setSize(Integer size){          
        this.size = Integer.valueOf(size);
        system.debug(' setSize PageSize : '+ ssc.getPageSize() + ' | size ' + this.size);
        ssc.setPageSize(this.size); 
        getJobs();
    }
    public Integer getSize(){
        return this.size;
    }
    public void setNameFilter(String nameFilter){
        this.nameFilter = nameFilter;
        refreshSSC();
    }
    public String getNameFilter(){
        return nameFilter;
    }
    public void onSalaryFilterChange(){
        if( salaryParam != null && salaryParam != 0 ) refreshSSC();
    }
    public class VacancyWrapper{
        public Job_Advertisement__c job {public get; public set;}
        public boolean isSelected {public get; public set;}
        public Integer index {public get; public set;}
    }
    /*
    public void showAll(){
		List <ContentVersion> cvs =  [Select Title,CreatedDate, ID , ContentDocumentId from ContentVersion];      
        String str =  (new Map<Id,ContentVersion>(cvs)) + '';
        //ContentVersion ver ;
        //ver.SharingOption = 'Allowed';
        //ver.SharingPrivacy = 'None';
        sendInfo( str );
    }
    public void clearAll(){        
        sendInfo( 'clearAll' );
        Id userID = UserInfo.getUserId();
        List <ContentDocument> cvs =  [Select Title, ID from ContentDocument WHERE  Description = 'CVImage' ];   
        delete cvs;
        cvs = [Select Title, ID from ContentDocument];
        String str =  (new Map<Id,ContentDocument>(cvs)).keySet() + '';
        sendInfo( 'clearAll' );
    }
*/

}