({  
	handleSelect : function(component,event, helper) { 
        var selectedPagesize = event.getParam("value");
        component.set("v.pageSize", selectedPagesize ) ; 
        helper.updateSelectedPageSize( component, selectedPagesize, 0);
      
	},  
    toNextPage : function(component,event, helper) {
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.pageNumber");
        event.getSource().set('v.disabled', true);
        helper.updateSelectedPageSize( component, pageSize, ++pageNumber);

	}, 
    toPreviousPage : function(component,event, helper) {
        
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.pageNumber");
        event.getSource().set('v.disabled', true);
        helper.updateSelectedPageSize( component, pageSize, --pageNumber); 
        
	}, 
    toFirstPage : function(component,event, helper) {
        var pageSize = component.get("v.pageSize");
        component.set("v.pageNumber", 0);
        event.getSource().set('v.disabled', true);
        helper.updateSelectedPageSize( component, pageSize, 0); 
        
	},
    toLastPage : function(component,event, helper) {
        
        var totalCount = component.get("v.totalCount");
        var pageSize = component.get("v.pageSize");
        var pageNumber ;
        if(totalCount%pageSize == 0){
            pageNumber = totalCount/pageSize -1;
        }else{
            pageNumber = (totalCount - totalCount%pageSize)/pageSize;
        }
        event.getSource().set('v.disabled', true);
        helper.updateSelectedPageSize( component, pageSize, pageNumber); 
	},
    doInit : function(component, event, helper) {
        helper.fetchCount( component, event);
        
        /*
        var action = component.get("c.getTotalCount");
        //action.setParams({ recordId :expname });        
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.totalCount", response.getReturnValue());
                helper.refreshButtons(component);
            }else {
                console.log("Failed with state: " + state);
            }   
        });        
        $A.enqueueAction(action);
        */
    },    
    handleRefreshCount: function( component, event, helper) {
        component.set("v.pageNumber", 0);
        helper.fetchCount(component, event);
        
    },
    refreshButtons: function( component, event, helper) {
        helper.refreshButtons(component);
       
    }
})