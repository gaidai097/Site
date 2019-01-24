({
    updateSelectedPageSize : function(component, newPagesize, pageNumber) {
        var event = $A.get("e.c:pageUpdate");
        event.setParams({ "pageSize": newPagesize + '' });
        event.setParams({ "pageNumber": pageNumber });
        component.set("v.pageNumber", pageNumber );
        event.fire();
        this.refreshCurrentPageLabel(component);
        
    }, 
    fetchCount: function( component, event){       
        var nameFilter = event.getParam("nameFilter");
        var dateFilter = event.getParam("dateFilter");
        var publishedDate = event.getParam("publishedDate");
        var salaryFilter = event.getParam("salaryFilter");
        var salaryParam = event.getParam("salaryParam");
        var action = component.get("c.getTotalCount");               
       
        action.setParams({
            "params": {
                "nameFilter": nameFilter,
                "dateFilter": dateFilter,
                "publishedDate": publishedDate,
                "salaryFilter": salaryFilter,
                "salaryParam": salaryParam,
            }
        }); 
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                component.set("v.totalCount", response.getReturnValue());                
                this.refreshButtons( component );
                this.refreshCurrentPageLabel( component );
            }else{
                console.log("Failed with state: " + state);
            }   
        });        
        $A.enqueueAction(action);
    },
    refreshButtons: function( component){
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.pageNumber");
        
        if(pageNumber == 0){            
            component.find('previous').set('v.disabled', true);
            component.find('first').set( 'v.disabled', true);
            console.log('component.get("v.totalCount") ' + component.get("v.totalCount"));
            console.log('pageSize ' + pageSize);
            if( component.get("v.totalCount") > pageSize ){
                component.find('next').set('v.disabled', false);
                component.find('last').set( 'v.disabled', false);
            }else{
				component.find('next').set('v.disabled', true);
                component.find('last').set( 'v.disabled', true);                
            }
        };
        if(pageNumber > 0){
            component.find('previous').set('v.disabled', false);
            component.find('first').set( 'v.disabled', false);
            if( (( pageNumber + 1 )*pageSize ) >= component.get("v.totalCount")){
                
                component.find('next').set('v.disabled', true);
                component.find('last').set( 'v.disabled', true);
            }else{
                component.find('next').set('v.disabled', false);
                component.find('last').set( 'v.disabled', false);
            }            
        };        
    },
    refreshCurrentPageLabel: function( component){
        var label = '';
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.pageNumber");
        var total = component.get("v.totalCount");
        if( pageSize*(pageNumber + 1) > total){
            label = (pageSize*(pageNumber) + 1 ) + '-'+ total  + ' of ' + total;
        }else{
             label = (pageSize*(pageNumber) + 1 ) + '-'+ (pageSize*(pageNumber + 1))  + ' of ' + total;
        }       
        component.set("v.currentPageLabel", label);
    }  
})