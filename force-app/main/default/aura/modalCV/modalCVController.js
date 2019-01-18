({
	 show: function(component, event, helper){
         console.log('show');
         
         var modal = component.find('cvModalWindow');
         var mask = component.find('cvModalMask');
         $A.util.addClass(modal, 'slds-fade-in-open');
         $A.util.addClass(mask, 'slds-backdrop_open');
    },
    
    hide: function(component, event, helper){
       // console.log(event.getSource().get("v.name"));
        //console.log(event.currentTarget.get("v.name"));
       
    	console.log(event.target);
        var modal = component.find('cvModalWindow');
        var mask = component.find('cvModalMask');
        $A.util.removeClass(modal, 'slds-fade-in-open');
        $A.util.removeClass(mask, 'slds-backdrop_open');
    },
    doInit: function (component, event, helper) {
        window.addEventListener("keydown", function(event) {
            var kcode = event.code;
            if(kcode == 'Escape'){
                document.getElementsByClassName('slds-fade-in-open')[0].classList.remove('slds-fade-in-open');
                document.getElementsByClassName('slds-backdrop_open')[0].classList.remove('slds-backdrop_open');              
                event.preventDefault();
                event.stopImmediatePropagation();
            }
        }, true);
    },
    hideOutside : function (component, event, helper) {
       
        if(event.target.classList.contains('slds-fade-in-open') || event.target.classList.contains('slds-modal__container')
          ){
            var modal = component.find('cvModalWindow');
            var mask = component.find('cvModalMask');
            $A.util.removeClass(modal, 'slds-fade-in-open');
            $A.util.removeClass(mask, 'slds-backdrop_open');
        }
        
    },
    numberValidation  : function (component, event, helper) {
        var numberInput = event.getSource();
        var pasrsedValue = parseInt( numberInput.get('v.value') );
        if(isNaN(pasrsedValue)){
            numberInput.set('v.value', '');
        }else{
            numberInput.set('v.value', pasrsedValue);           
        }
    },
    handleUploadFinished: function (component, event, helper) {   
        
        var uploadedFiles = event.getParam("files");
        console.log(uploadedFiles.length + ' ' + uploadedFiles[0].name);        
    }
})