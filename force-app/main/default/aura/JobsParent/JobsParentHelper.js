({
	calcSelectedCount : function(component) {
        var selectedJobs = component.get('v.selectedJobs');
		if(selectedJobs == null || typeof selectedJobs == 'undefined' || selectedJobs.length < 1 ){
            component.set('v.isSelected', false);
            component.set('v.selectedCount', 0);
        }else{
            component.set('v.isSelected', true);
            component.set('v.selectedCount', selectedJobs.length);
        }
	}
})