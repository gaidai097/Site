({
    updateSelectedPageSize : function(component, newPagesize, pageNumber) {
       console.log('updateSelectedPageSize newPagesize' + newPagesize);
        console.log('updateSelectedPageSize pageNumber' + pageNumber);
        var event = $A.get("e.c:pageUpdate");
        event.setParams({ "pageSize": newPagesize + '' });
        event.setParams({ "pageNumber": pageNumber });
        event.fire();
        component.set("v.pageNumber", pageNumber );
        
        var pageSize = component.get("v.pageSize");
        if(pageNumber == 0){
            component.find('previous').set('v.disabled', true);
            component.find('first').set( 'v.disabled', true);
        };
        if( (pageNumber+1)*(parseInt(pageSize)) >= component.get("v.totalCount")){                    
            component.find('next').set('v.disabled', true);
            component.find('last').set( 'v.disabled', true);
        }
        
    },
    fetchCount: function( component, event){       
        var nameFilter = event.getParam("nameFilter");
        var dateFilter = event.getParam("dateFilter");
        var publishedDate = event.getParam("publishedDate");
        var salaryFilter = event.getParam("salaryFilter");
        var salaryParam = event.getParam("salaryParam");
        var action = component.get("c.getTotalCount");
        console.log( 'fetchCount => ' );
        console.log( 'nameFilter = ' + nameFilter + ' ; ' +
                    'dateFilter = ' + dateFilter + ' ; ' + 'salaryFilter = ' + salaryFilter + ' ; ' + 'salaryParam = ' + salaryParam + ' ; '
                    + 'publishedDate = ' + publishedDate
                   );
        
        // Create the action
        action.setParams(
            {
                "params": {
                    "nameFilter": nameFilter,
                    "dateFilter": dateFilter,
                    "publishedDate": publishedDate,
                    "salaryFilter": salaryFilter,
                    "salaryParam": salaryParam,
                }
            }
        ); 
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.totalCount", response.getReturnValue());
                var pageSize = component.get("v.pageSize");
                var pageNumber = component.get("v.pageNumber");
                if(pageNumber == 0){
                    component.find('previous').set('v.disabled', true);
                    component.find('first').set( 'v.disabled', true);
                };
                if( (pageNumber+1)*(parseInt(pageSize)) >= component.get("v.totalCount")){                    
                    component.find('next').set('v.disabled', true);
                    component.find('last').set( 'v.disabled', true);
                }
            }else {
                console.log("Failed with state: " + state);
            }   
        });        
        $A.enqueueAction(action);
    }    
})