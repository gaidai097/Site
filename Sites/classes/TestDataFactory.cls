@isTest
public class TestDataFactory {
    public static List <CV__c> createCVs(Integer count){
        List <CV__c> cvs = new List <CV__c>();        
        for(integer i = 0; i < count; i++){
            cvs.add( 
                new CV__c( Name = 'Test CVName '+ i, Status__c = 'Employeed',
                          Phone__c = '0584545450'+ i, Salary__c = 450+i ,
                          Age__c = '45',
                          Additional_info__c = 'info' +i, Email__c = i +'test@gmail.com'
                )
            );
        }
        insert cvs; 
        DateTime yesterday = Datetime.newInstance( Date.today().addDays(-1), Time.newInstance(23, 59, 0, 0) );
        for(CV__c cv: cvs){            
            Test.setCreatedDate(cv.id, yesterday);
        }
        return cvs;
    }
    public static List < ContentVersion >  createContentVersions(List <CV__c> cvs){
        List <ContentVersion> conVers = new List <ContentVersion>(); 
        Blob image = Blob.valueOf('Test data');
        for(CV__c cv: cvs){
            conVers.add( 
                new ContentVersion( CV__c = cv.id, SharingOption = 'A',SharingPrivacy = 'N',                                                   
                                                   VersionData = image, title = 'Test Name', PathOnClient = 'Test' , Description = 'CVImage')
            );
        }
        insert conVers;
        return conVers;
    }
    public static List <CVJA__c> createCVJAs(List <CV__c> cvs, Job_Advertisement__c job ){
        List <CVJA__c> cvjas = new List <CVJA__c>();
        for(CV__c cv: cvs){
            cvjas.add( new CVJA__c( Job_Advertisement__c = job.id, 
                                   Email__c = cv.Email__c, CV__c = cv.id
                                  )
                     );
        }
        insert cvjas;
        return cvjas ;
    }
	public static List <Job_Advertisement__c> createJobAdvertisement(Integer count){
        List <Job_Advertisement__c> jAs = new List <Job_Advertisement__c>();        
        for(integer i = 0; i < count; i++){
            jAs.add( 
                // Owner is an Admin (current user)
                new Job_Advertisement__c( Name = 'unclaimedPositionTest '+ i,
                                         Status__c='Active',
                                         email__c = i +'test@gmail.com'
                                        )
            );
        }
        insert jAs;        
        return jAs;
    }
    public static List <Job_Advertisement__c> createDifferentJobAdvertisements(Integer count){
        List <Job_Advertisement__c> jAs = new List <Job_Advertisement__c>();        
        for(integer i = 0; i < count; i++){           
            Job_Advertisement__c obj =  new Job_Advertisement__c( email__c = i +'test@gmail.com' );
            if( i<=30 ){
                obj.Status__c = 'Active';
                obj.SalaryMin__c = 50;
                obj.SalaryMax__c = 75;
                obj.Name = 'Low '+ i;
            }
            if( i>30 && i<=60){
                obj.Status__c = 'Archived';
                obj.SalaryMin__c = 75;
                obj.SalaryMax__c = 90;
                obj.Name = 'Middle '+ i;
            }
            if( i>60 && i <= 90){
                obj.Status__c = 'On hold';
                obj.SalaryMin__c = 90;
                obj.SalaryMax__c = 120;
                obj.Name = 'High '+ i;
            }
            if( i>90 ){
                obj.Status__c = 'Active';
                obj.SalaryMin__c = 120;
                obj.Name = 'Top '+ i;
            }
            
            jAs.add(obj);
        }
        insert jAs;  
        for(integer i = 0 ; i < jAs.size(); i++){
            Test.setCreatedDate(jAs[i].id, Date.today().addDays(-i));
        }
        return jAs;
    }
}