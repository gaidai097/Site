({
	handleSelect : function(component,event, helper) {
        var selectedPagesize = event.getParam("value");
        component.set("v.pageSize", selectedPagesize ) ; 
        helper.updateSelectedPageSize( component, selectedPagesize, 0);
      
	},  
    toNextPage : function(component,event, helper) {
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.pageNumber");
        helper.updateSelectedPageSize( component, pageSize , ++pageNumber);
        component.find('previous').set( 'v.disabled', false);
        if( (pageNumber+1)*(parseInt(pageSize)) >= component.get("v.totalCount")){
            console.log('Disable next BTN');
            event.getSource().set('v.disabled', true);
            component.find('last').set( 'v.disabled', true);
        }
        component.find('first').set( 'v.disabled', false);
	}, 
    toPreviousPage : function(component,event, helper) {
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.pageNumber");
        helper.updateSelectedPageSize( component, pageSize , --pageNumber); 
        component.find('next').set( 'v.disabled', false);
        component.find('last').set( 'v.disabled', false);
        if(pageNumber == 0){
            event.getSource().set('v.disabled', true);
            component.find('first').set( 'v.disabled', true);
        };
	}, 
    toFirstPage : function(component,event, helper) {
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.pageNumber");
        helper.updateSelectedPageSize( component, pageSize , --pageNumber); 
        component.find('next').set( 'v.disabled', false);
        component.find('last').set( 'v.disabled', false);
        if(pageNumber == 0){
            event.getSource().set('v.disabled', true);
            component.find('first').set( 'v.disabled', true);
        };
	},
    toLastPage : function(component,event, helper) {
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.pageNumber");
        helper.updateSelectedPageSize( component, pageSize , --pageNumber); 
        component.find('next').set( 'v.disabled', false);
        component.find('last').set( 'v.disabled', false);
        if(pageNumber == 0){
            event.getSource().set('v.disabled', true);
            component.find('first').set( 'v.disabled', true);
        };
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
        component.set("v.pageNumber", 0);       
        helper.fetchCount(component, event);
        
    },
    refreshButtons: function( component, event, helper) {
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.pageNumber");
        if(pageNumber == 0){
            component.find('previous').set('v.disabled', true);
            component.find('first').set( 'v.disabled', true);
        };
        console.log('(pageNumber+1) ' +(pageNumber+1)  + '*(parseInt(pageSize)) ' + (parseInt(pageSize)));
        if( (pageNumber+1)*(parseInt(pageSize)) >= component.get("v.totalCount")){                    
            component.find('next').set('v.disabled', true);
            component.find('last').set( 'v.disabled', true);
        }
    }
})