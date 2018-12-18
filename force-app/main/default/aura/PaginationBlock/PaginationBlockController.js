({
	handleSelect : function(component,event, helper) {
        var selectedPagesize = event.getParam("value");
        component.set("v.pageSizeValue" , selectedPagesize ) ;      
        helper.updateSelectedPageSize(component, selectedPagesize);
      
	},
    
    doInit : function(component, event, helper) {
        var action = component.get("c.getTotalCount");
        //action.setParams({ recordId :expname });
        
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.totalCount", response.getReturnValue());
            }else {
                console.log("Failed with state: " + state);
            }   
        });        
        $A.enqueueAction(action);
    }
})