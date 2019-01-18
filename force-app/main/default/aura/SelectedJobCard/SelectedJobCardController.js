({
	removeJob : function(component, event, helper) {	
        var jobToRemove = component.get('v.selectedJob');       
        var event = $A.get("e.c:removeFromSelectedList");
        event.setParams({ "jobToDeselect": jobToRemove });
        event.fire();
	}
})