public class JobAdvertisementsWrapper {
    public String salaryMax {get;set;}
    public String salaryMin {get;set;}
    public String email {get;set;}
    public String phone {get;set;}
    public String status {get;set;}
    public String id {get;set;}
    public String name {get;set;}
    public String skills {get;set;}
    public String description {get;set;}
    public String manager_name {get;set;}
    public String education {get;set;}
    public String location {get;set;}
    
    public JobAdvertisementsWrapper convertToWrapper(Job_Advertisement__c obj){
        this.salaryMax = obj.SalaryMax__c + '';
        this.salaryMin = obj.SalaryMin__c + '';
        this.email = obj.email__c;
        this.skills = obj.Skills_Required__c;
        this.name = obj.Name;
        this.id = obj.id;
        this.phone = obj.phone__c;
        this.description = obj.Description__c;
        this.manager_name = obj.Manager_name__c;
        this.education = obj.Education__c;
        this.status = obj.Status__c;
        this.location = obj.Location__c;
        
        return this;
    }
    public static Job_Advertisement__c convertFromWrapper(JobAdvertisementsWrapper model){
        Job_Advertisement__c obj = new Job_Advertisement__c();
        System.debug('model ' + model);
        if(model.name != null &&  model.name != ''){
            obj.Name = model.name ;
        }else { return null; }
        System.debug('SalaryMax__c ' + model.salaryMax);
        if( model.salaryMax != null  && model.salaryMax != 'null' ) obj.SalaryMax__c = Decimal.valueOf( model.salaryMax); 
        if( model.salaryMin != null && model.salaryMin != 'null' ) obj.SalaryMin__c = decimal.valueOf( model.salaryMin);  
        if(model.email != null &&  model.email != '') obj.email__c = model.email;    
        if(model.skills != null &&  model.skills != '') obj.Skills_Required__c = model.skills;        
        if(model.description != null &&  model.description != '') obj.Description__c = model.description;       
        if(model.manager_name != null &&  model.manager_name != '') obj.Manager_name__c = model.manager_name;
        if(model.education != null &&  model.education != '') obj.Education__c = model.education;        
        if(model.location != null &&  model.location !='') obj.Location__c = model.location;           
        if(model.phone != null &&  model.phone != '')obj.phone__c = model.phone;
        if(model.id != null &&  model.id != '') obj.id = model.id;   
        if(model.status == 'Open' ) obj.Status__c = 'Active'; 
        return obj;
    }
    
    public static List <JobAdvertisementsWrapper> convertToWrapper ( List <Job_Advertisement__c> jobs){
        List <JobAdvertisementsWrapper> wrappedJobAdvertisements = new List <JobAdvertisementsWrapper> ();
        for( Integer i = 0; i < jobs.size(); i++ ){
            JobAdvertisementsWrapper wr = new JobAdvertisementsWrapper();
            wrappedJobAdvertisements.add( wr.convertToWrapper(jobs[i]) );
        }
        return wrappedJobAdvertisements;
    }    
}