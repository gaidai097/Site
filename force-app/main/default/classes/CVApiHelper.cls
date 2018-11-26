public class CVApiHelper {
    public static List <CVImageWrapper> getCVsWithImageIds(String offset, String limitSize){
		Integer integerOffset = Integer.valueOf(offset);   
        Integer sizeLimit = Integer.valueOf(limitSize);  
        String json;    
        DateTime yesterdayStart = Datetime.newInstance( Date.today().addDays(-8), Time.newInstance(8, 0, 0, 0) );        
        DateTime todaydaysEnd = Datetime.newInstance( Date.today(), Time.newInstance(23, 0, 0, 0) );
        
        List <CV__c> cvsResults = [SELECT Name, Status__c,Phone__c, Age__c, Email__c, CreatedDate, Salary__c , ID, Additional_info__c,
                                   (SELECT id,CV__c, Email__c, Job_Advertisement__c from CVJAs__r )
                                   FROM CV__c 
                                   WHERE CreatedDate >= :yesterdayStart AND CreatedDate <= :todaydaysEnd 
                                   ORDER BY CreatedDate LIMIT :sizeLimit OFFSET :integerOffset];
        Map <ID, CV__c> cvsMap = (new Map <ID, CV__c>(cvsResults));
        Set <ID> cvIDs = cvsMap.keySet();
        List <ContentVersion> images = [SELECT Id, CV__c FROM ContentVersion WHERE CV__c IN :cvIDs LIMIT :sizeLimit];
        List <CVImageWrapper> cvsWrapped = new List <CVImageWrapper>();
        for(ContentVersion conVer : images){
            cvsWrapped.add( new CVImageWrapper(cvsMap.get(conVer.CV__c), conVer.id) );
        }
        //Select id, LinkedEntityId, SystemModstamp from ContentDocumentLink Where ContentDocumentId IN ('0691t000000geH2AAI')
		System.debug( ' cvsWrapped.size() => ' + cvsWrapped.size() );
        return cvsWrapped;
        
    }    

    public static Integer getNewCVsCount(){
        
        DateTime yesterdayStart = Datetime.newInstance(
            Date.today().addDays(-8),
            Time.newInstance( 8, 0, 0, 0 )
        );
        DateTime todaydaysEnd  = Datetime.newInstance(
            Date.today(),
            Time.newInstance( 23, 0, 0, 0 )
        );
        
        Integer count = database.countQuery('SELECT count() from CV__c WHERE CreatedDate >= :yesterdayStart AND CreatedDate <= :todaydaysEnd ');
		System.debug( ' count => ' + count);
        return count;
    }
  
    public class CVImageWrapper{
        public String contentVersionId;
        public String email;
        public String phone;
        public String cvId;
        public Decimal age;
        public Decimal salary;
        public String name;
        public String status;
        public string additionalInfo;
        public List <ID> jobs;
        
        public CVImageWrapper( CV__c cv, Id contentVersionId ){
            this.contentVersionId = contentVersionId;
            this.phone = cv.Phone__c;
            this.email = cv.Email__c;
            this.salary = cv.Salary__c;
            this.age = cv.Age__c;
            this.name = cv.Name;
            this.cvId = cv.id;
            this.status = cv.Status__c;
            this.additionalInfo = cv.Additional_info__c;
            this.jobs = new List <ID>();
            for(CVJA__c cvja: cv.CVJAs__r){
            	jobs.add( cvja.Job_Advertisement__c );
            }            
        }
    } 
}