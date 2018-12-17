({
	handleSelect : function(cmp, event)  {
        var selectedPagesize = event.getParam("value");
		console.log( 'selectedPagesize => ' + selectedPagesize);
        cmp.set("v.pageSizeValue" , selectedPagesize ) ;		
	}
})