({
	refilter : function(component, event, helper) {
        
        helper.refilterPage(component );
	},
    handleSubmit : function(component, event, helper) {        
        if (event.keyCode === 13) {
            helper.refilterPage(component );
        }
	},
    clearFilters : function(component, event, helper) {
        
        component.find('nameFilter').set("v.value", null);
        component.find('dateFilter').set("v.value", null);
        component.find('salaryFilter').set("v.value", null);
        helper.refilterPage(component );
	}
})