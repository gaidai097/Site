trigger JobAdvertisementTrigger on Job_Advertisement__c (before delete, after update) {
    //Remove all related CVs 
    if(Trigger.isBefore && Trigger.isDelete){        
        JobAdvertisementTriggerHelper.removeCVs(Trigger.old);        
    }
    if(Trigger.isAfter && Trigger.isUpdate){        
        List <Job_Advertisement__c> jobs = new List <Job_Advertisement__c>();
        for(Job_Advertisement__c ja: Trigger.new){
            if( Trigger.OldMap.get(ja.Id).Status__c != ja.Status__c && ja.Status__c == 'Archived' ){
                jobs.add( ja );
            }
        }
        if(!jobs.isempty()) JobAdvertisementTriggerHelper.removeCVs(jobs);        
    }    
}