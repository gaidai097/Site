({
	addSelectedJob : function(component, event, helper) {
		var selectedJob = event.getParam("selectedJob");       
        var selectedJobs = component.get("v.selectedJobs");
        selectedJobs.push(selectedJob);
        component.set("v.selectedJobs",selectedJobs );
         helper.calcSelectedCount(component);
        
	},
    removeFromSelectedList: function(component, event, helper) {
		var job = event.getParam("jobToDeselect");
        var selectedJobs = component.get("v.selectedJobs");
        for(var i = 0; i < selectedJobs.length; i++){
            if(selectedJobs[i].Id == job.Id){
                selectedJobs.splice(i, 1);
                component.set("v.selectedJobs",selectedJobs );
                break;
            }
        }
        helper.calcSelectedCount(component);
        
	},
    removeDeselectedJob : function(component, event, helper) {
		var job = event.getParam("deselectedJob");
        var selectedJobs = component.get("v.selectedJobs");
        for(var i = 0; i < selectedJobs.length; i++){
            if(selectedJobs[i].Id == job.Id){
                selectedJobs.splice(i, 1);
                component.set("v.selectedJobs",selectedJobs );
                break;
            }
        }
         helper.calcSelectedCount(component);
	}
})