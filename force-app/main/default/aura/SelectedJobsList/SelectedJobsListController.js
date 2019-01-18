({
    openModal: function( component, event, helper ) {      
        var event = $A.get("e.c:openCVModal");
        event.fire();
    },
    doInit: function( component, event, helper ) {
        var selectedJobs = component.get('v.selectedJobs');
        if(selectedJobs == null || typeof selectedJobs == 'undefined' || selectedJobs.length < 1 ){
            component.find('ApplyBtn').set( 'v.disabled', true);
            component.set('v.selectedCount', 0);
        }else{
            component.find('ApplyBtn').set( 'v.disabled', false);
            component.set('v.selectedCount', selectedJobs.length);
        }
    }
    
})