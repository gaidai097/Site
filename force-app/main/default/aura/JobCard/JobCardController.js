({
    doInit : function(component, event, helper) {
		var job = component.get('v.job');
        var selectedJobs = component.get('v.selectedJobs');               
        for(var i=0 ; i < selectedJobs.length ; i++){
            if(selectedJobs[i].Id == job.Id){
                component.find('isSelected').set('v.checked', true);
            }
        }
        
	},
	toggleCard : function(component, event, helper) {
		var job = component.get('v.job');        
        var isToggled = event.getSource().get('v.checked');
        if(isToggled ){
            helper.addToChecked(component, job);
        }else{
            helper.removeFromChecked(component, job);
        }
	},
    removeFromSelectedList: function(component, event, helper) {
        var job = component.get('v.job');        
        var jobToDeselect = event.getParam('jobToDeselect'); 
        if( job.Id == jobToDeselect.Id ){
            component.find('isSelected').set('v.checked', false);
        }  
        
	},
   
})