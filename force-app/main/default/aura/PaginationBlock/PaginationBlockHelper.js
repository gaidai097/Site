({
    updateSelectedPageSize : function(component, newPagesize) {
       
        var event = $A.get("e.c:pageUpdate");
        event.setParams({ "pageSize": newPagesize + '' });
        event.fire();
    },
    fetchCount: function( component, event) {       
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
            }else {
                console.log("Failed with state: " + state);
            }   
        });        
        $A.enqueueAction(action);
    }
})