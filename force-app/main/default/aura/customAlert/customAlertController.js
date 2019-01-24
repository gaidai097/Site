({
	closeAlert : function(component, event, helper) {
        $A.util.addClass( component.find('currentAlert'), 'toggle'); 
        console.log('clicked');
	}
})