({
    addToChecked : function( component, selectedJob ) {
                
        var event = $A.get("e.c:selectJob");
        event.setParams({ "selectedJob": selectedJob });
        event.fire();
    },
    removeFromChecked : function( component, delectedJob ) {
                     
        var event = $A.get("e.c:deselectJob");
        event.setParams({ "deselectedJob": delectedJob });
        event.fire();        
    }
})