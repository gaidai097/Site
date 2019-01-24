({
    handleShowNotice : function(component, event, helper) {
        component.find('notifLib').showNotice({
            "variant": "error",
            "header": "Something has gone wrong!",
            "message": "Unfortunately, there was a problem updating the record.",
            closeCallback: function() {
                alert('You closed the alert!');
            }
        });
    },
    onRender: function(component,event, helper) {
        
		var alerts = document.querySelectorAll('.mainAlertBlock .close');
        console.log('alerts === ' + alerts.length);
        for(var i= 0 ; i < alerts.length ; i++){
            var onclickClose = function(alert){
                alert.onclick = function(e){
                    alert.parentElement.parentElement.parentElement.classList.add('toggle');
                    
                };
            };
            onclickClose( alerts[i]);            
        }
        alerts = document.querySelectorAll('.mainAlertBlock .toggle');
        console.log('alerts === ' + alerts.length);
	}
})