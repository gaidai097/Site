({
    addAlert : function(component, event, helper) {
        var msg = event.getParam("msg");
        var severity = event.getParam("severity");
        var alerts = component.get("v.alerts" ) ;
        var closedAlerts = document.querySelectorAll('.cCustomAlert>div.toggle');
        console.log( '===');
        console.log( closedAlerts.length);
        console.log( alerts.length);
        if( closedAlerts.length == alerts.length){
            alerts = [];
        }      
        alerts.unshift({"msg":msg, "severity":severity});         
        if( alerts.length == 7){
            alerts.splice(  alerts.length -1, 1);
        }
        component.set("v.alerts" , alerts) ; 
        event.stopPropagation();
    },
})