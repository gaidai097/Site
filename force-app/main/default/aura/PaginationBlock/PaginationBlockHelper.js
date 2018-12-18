({
    updateSelectedPageSize : function(component, newPagesize) {
       
        var event = $A.get("e.c:pageUpdate");
        event.setParams({ "pageSize": newPagesize + '' });
        console.log('fire => ' + newPagesize);
        event.fire();
    }
})