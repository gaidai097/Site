public class DataFactory {
	// Use this method to fill new scratch org with Test data
    public static void createJobs(){
        List <Job_Advertisement__c> jobs = new List <Job_Advertisement__c>();
            
            List <String> names = new List <String> {
                	'Java Junior', 'Java Senior ','Java Middle',' Java TeamLead' ,
                    'PHP Junior', 'PHP Senior ','PHP Middle','PHP TeamLead' ,
                    'C++ Junior', 'C++ Senior ','C++ Middle','C++ TeamLead' ,
                    'JS Junior', 'JS Senior ','JS Middle','JS TeamLead' ,
                    'Barmen', 'Dancer', 'Cleaner',
                    'Break Dancer', 'Oficiant', 'Administrator', 
                    'Manager', 'TopManager' ,'Director', 'Engineer',
                    'X-men', 'songer', 'actor' , 'saller', 'resaller', 'poet', 'driver',
                    'C# Junior', 'C# Senior ','C# Middle',
                    'Android Junior', 'Android Senior ','Android Middle','Android TeamLead' ,
                    'C++ Junior', 'C++ Senior ','C++ Middle','C++  TeamLead' ,
                    'Ruby Junior', 'Ruby Senior ','Ruby Middle','Ruby TeamLead'                     
            };
        for(Integer i = 0; i <names.size(); i++ ){
            
            jobs.add( new Job_Advertisement__c(
                Description__c ='TestDescription +',
                email__c = i +'testEmail@gmail.com' ,
                Education__c = 'high'+i,
                Location__c = 'USA',
                SalaryMax__c = 120 + i,
                SalaryMin__c = 75 - i,
                Manager_name__c = 'TestName',
                phone__c = '097654321'+ i,
                Status__c = 'Active',
                Name = names[i]
                
                
            
       		 ) ); 
        }
        insert jobs;
        
    }
}