({
    refilterPage : function(component) {
        var filters = {}; 
        filters.nameFilter = component.find('nameFilter').get("v.value");
        filters.publishedDate = component.find('publishedDate').get("v.value");        
        filters.dateFilter = component.find('dateFilter').get("v.value");    
        filters.salaryFilter = component.find('salaryFilter').get("v.value");
        filters.salaryParam = component.find('salaryParam').get("v.value");
        filters.pageNumber = '1';
        this.sendRefilterEvent(component, filters);
		      
    },
    sendRefilterEvent : function( component, filters ){
		
        var event = $A.get("e.c:filterUpdate");
        event.setParams({ "nameFilter": filters.nameFilter ,"publishedDate": filters.publishedDate, "salaryParam": filters.salaryParam,
                         "dateFilter": filters.dateFilter , "salaryFilter": filters.salaryFilter, "pageNumber": filters.pageNumber  });
        
        event.fire();
	}
})