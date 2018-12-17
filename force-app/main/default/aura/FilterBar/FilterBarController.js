({
	handleClick : function(component, event, helper) {
        
        var nameFilter = component.find('nameFilter').get("v.value");
        var dateFilter = component.find('dateFilter').get("v.value");
        var salaryFilter = component.find('salaryFilter').get("v.value");
		helper.helperSubmit(nameFilter,dateFilter, salaryFilter );
	},
    handleSubmit : function(component, event, helper) {        
        if (event.keyCode === 13) {
            var nameFilter = component.find('nameFilter').get("v.value");
            var dateFilter = component.find('dateFilter').get("v.value");
            var salaryFilter = component.find('salaryFilter').get("v.value");
            helper.helperSubmit(nameFilter,dateFilter, salaryFilter );
        }
	}
})