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
        component.find('dateFilter').set("v.value", 'ALL');
        component.find('publishedDate').set("v.value", null);
        component.find('salaryParam').set("v.value", null);
        component.find('salaryFilter').set("v.value", 'MORE');
        helper.refilterPage(component );
    },
    selectDateFilter: function(component, event, helper) {
        var selectedMenuItemValue = event.getParam("value");
        component.set("v.dateFilter", selectedMenuItemValue);
        component.find('dateFilter').set("v.value", selectedMenuItemValue);        
    },
    selectSalaryFilter: function(component, event, helper) {
        var selectedMenuItemValue = event.getParam("value");
        component.set("v.salaryFilter", selectedMenuItemValue);
        component.find('salaryFilter').set("v.value", selectedMenuItemValue);
        
    }
})