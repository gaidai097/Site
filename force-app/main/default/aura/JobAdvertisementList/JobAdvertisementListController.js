({
	doInit: function(component, event, helper) {
        helper.fetchNewList(component, event);
    },
    handlePageSizeUpdate: function( component, event, helper) {
        var pageSize = event.getParam("pageSize");
        var pageNumber = event.getParam("pageNumber");
        console.log('handlePageSizeUpdate  pageSize ' + pageSize );
        console.log('handlePageSizeUpdate  pageNumber ' + pageNumber );
        component.set("v.pageSize" , pageSize ) ; 
        component.set("v.pageNumber" , pageNumber+'') ; 
        event.stopPropagation();
        helper.fetchNewList(component, event);
        
    },
    handleFilterEvent: function( component, event, helper) {
        console.log('JobAdvListContr');
        var dateFilter = event.getParam("dateFilter");
        var salaryFilter = event.getParam("salaryFilter");
        var salaryParam = event.getParam("salaryParam");
        var nameFilter = event.getParam("nameFilter");
        component.set("v.pageNumber" , '0' ) ; 
        component.set("v.dateFilter" , dateFilter ) ; 
        component.set("v.salaryFilter" , salaryFilter ) ; 
        component.set("v.nameFilter" , nameFilter ) ; 
        component.set("v.publishedDate" , event.getParam("publishedDate") ) ;         
        console.log('handleFilterEvent ' + event.getParam("publishedDate"));
        helper.fetchNewList(component, event);
    }
})