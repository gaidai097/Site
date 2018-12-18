({
	doInit: function(component, event, helper) {
        helper.fetchNewList(component);
    },
    handlePageSizeUpdate: function( component, event, helper) {
        var pageSize = event.getParam("pageSize");
        component.set("v.pageSize" , pageSize ) ; 
        component.set("v.pageNumber" , '0' ) ; 
        event.stopPropagation();
        helper.fetchNewList(component);
        
    },
    handleFilterEvent: function( component, event, helper) {
        var dateFilter = event.getParam("dateFilter");
        var salaryFilter = event.getParam("salaryFilter");
        var nameFilter = event.getParam("nameFilter");
        component.set("v.dateFilter" , dateFilter ) ; 
        component.set("v.salaryFilter" , salaryFilter ) ; 
        component.set("v.nameFilter" , nameFilter ) ; 
        event.stopPropagation();
        console.log('handleFilterEvent');
        helper.fetchNewList(component);
    }
})