({
	fetchNewList : function( component, event) {
        
        var salaryParam = event.getParam("salaryParam");
        console.log('JALH ' + salaryParam);
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.pageNumber");        
        var nameFilter = component.get("v.nameFilter");
        var dateFilter = component.get("v.dateFilter");
        var publishedDate = component.get("v.publishedDate");
        var salaryFilter = component.get("v.salaryFilter");
        var action = component.get("c.getJobs");
        console.log('pageSize = ' + pageSize + ' ; ' + 'pageNumber = ' + pageNumber + ' ; ' + 'nameFilter = ' + nameFilter + ' ; ' +
                    'dateFilter = ' + dateFilter + ' ; ' + 'salaryFilter = ' + salaryFilter + ' ; ' + 'salaryParam = ' + salaryParam + ' ; '
                    + 'publishedDate = ' + publishedDate
                   );
        
        // Create the action
        action.setParams(
            {
                "params": {
                    "pageSize": pageSize,
                    "pageNumber": pageNumber,
                    "nameFilter": nameFilter,
                    "dateFilter": dateFilter,
                    "publishedDate": publishedDate,
                    "salaryFilter": salaryFilter,
                    "salaryParam": salaryParam,
                }
            }
        );        
        
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.jobs", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
       
        
	}
})