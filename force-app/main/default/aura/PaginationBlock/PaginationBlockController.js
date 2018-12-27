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
    },    
    handleRefreshCount: function( component, event, helper) {
        console.log('Pagination count fetch event.getParam("nameFilter") ' + event.getParam("nameFilter"));
        /*
        var dateFilter = event.getParam("dateFilter");
        var salaryFilter = event.getParam("salaryFilter");
        var nameFilter = event.getParam("nameFilter");
        component.set("v.dateFilter" , dateFilter ) ; 
        component.set("v.salaryFilter" , salaryFilter ) ; 
        component.set("v.nameFilter" , nameFilter ) ; 
        component.set("v.publishedDate" , event.getParam("publishedDate") ) ; 
        event.stopPropagation();
        console.log('event.getParam("publishedDate") ' + event.getParam("publishedDate"));
        */
        helper.fetchCount(component, event);
    }
})