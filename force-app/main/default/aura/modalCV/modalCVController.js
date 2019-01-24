({
	 show: function(component, event, helper){ 
         var modal = component.find('cvModalWindow');
         var mask = component.find('cvModalMask');
         $A.util.addClass(modal, 'slds-fade-in-open');
         $A.util.addClass(mask, 'slds-backdrop_open');
    },
    
    hide: function(component, event, helper){  
        var modal = component.find( 'cvModalWindow' );
        var mask = component.find( 'cvModalMask' );
        $A.util.removeClass( modal, 'slds-fade-in-open' );
        $A.util.removeClass( mask, 'slds-backdrop_open' );
    },
    sendCV: function (component, event, helper){
         helper.makeRequest(component, event) ;
    },
    doInit: function (component, event, helper) {
        window.addEventListener("keydown", function(event) {
            var kcode = event.code;
            if(kcode == 'Escape'){
                document.getElementsByClassName('slds-fade-in-open')[0].classList.remove('slds-fade-in-open');
                document.getElementsByClassName('slds-backdrop_open')[0].classList.remove('slds-backdrop_open');              
                event.preventDefault();
            }
        }, true);
    },
    hideOutside : function (component, event, helper) {       
        if(event.target.classList.contains('slds-fade-in-open') || event.target.classList.contains('slds-modal__container')){
            var modal = component.find('cvModalWindow');
            var mask = component.find('cvModalMask');
            $A.util.removeClass(modal, 'slds-fade-in-open');
            $A.util.removeClass(mask, 'slds-backdrop_open');
        }        
    },
    emailValidation:function (component, event, helper) {
        var EMAIL_REGEX = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,4}))$/;
		var emailInput = event.getSource();
        var email = emailInput.get('v.value'); 
        emailInput.set( 'v.value', email.trim());
        var cv = component.get('v.cvToSend', true);
        if(EMAIL_REGEX.test(email)){
            cv.Email__c = email ;
            component.set( 'v.cvToSend', cv ); 
            //clear custom error message
            emailInput.setCustomValidity('');
            emailInput.reportValidity() ; 
        }else{
            cv.Email__c = null ;
            component.set( 'v.cvToSend', cv ); 
            emailInput.setCustomValidity('Please, fix your Email!');
            emailInput.reportValidity() ;        
        }
        helper.validateCV( component );
    },
    firstNameValidate : function (component, event, helper) {
        var NAME_REGEX = /^[A-Z]{1}[a-z]{1,12}$/ ;
        var nameInput = event.getSource();
        var nameValue = nameInput.get('v.value');        
        var firstUp =  nameValue.charAt(0).toUpperCase() + nameValue.slice(1) ;
        nameInput.set( 'v.value', firstUp);
        if(NAME_REGEX.test(firstUp)){
            var cv = component.get('v.cvToSend', true);
            cv.Name = nameInput.checkValidity() ? firstUp : null;
            component.set('v.cvToSend', cv ); 
            nameInput.setCustomValidity('');
            nameInput.reportValidity() ;  
            component.set('v.firstName', firstUp) ;
        }else{
            nameInput.setCustomValidity('Please, fix your First Name!');
            nameInput.reportValidity() ;  
            component.set('v.firstName', null) ;
        }
        helper.validateCV( component );
    },
    lastNameValidate : function (component, event, helper) {
        var NAME_REGEX = /^[A-Z]{1}[a-z]{1,12}$/ ;
        var nameInput = event.getSource();
        var nameValue = nameInput.get('v.value');        
        var firstUp =  nameValue.charAt(0).toUpperCase() + nameValue.slice(1) ;
        nameInput.set( 'v.value', firstUp);
        if( NAME_REGEX.test(firstUp) ){
            var cv = component.get('v.cvToSend', true);
            cv.Name = nameInput.checkValidity() ? firstUp : null;
            component.set('v.cvToSend', cv );  
            nameInput.setCustomValidity('');
            nameInput.reportValidity() ; 
            component.set('v.lastName', firstUp);
        }else{
            nameInput.setCustomValidity('Please, fix your First Name!') ;
            nameInput.reportValidity() ; 
            component.set('v.lastName', null);
        }
        helper.validateCV( component );
    },
    ageValidation  : function (component, event, helper) {
        var numberInput = event.getSource();
        var pasrsedValue = parseInt( numberInput.get('v.value') );       
        numberInput.set('v.value', isNaN(pasrsedValue) ? '' : (pasrsedValue +'') );   
        var cv = component.get('v.cvToSend', true);
        cv.Age__c = numberInput.checkValidity() ? (pasrsedValue +'') : null;
        component.set('v.cvToSend', cv ); 
        helper.validateCV( component );
    },
    salaryValidation : function (component, event, helper) {
        var numberInput = event.getSource();
        var pasrsedValue = parseInt( numberInput.get('v.value') );
        numberInput.set('v.value', isNaN(pasrsedValue) ? '' : pasrsedValue );
        var cv = component.get('v.cvToSend');
        cv.Salary__c = numberInput.checkValidity() ? pasrsedValue : null;
        component.set('v.cvToSend', cv );        
        helper.validateCV( component );       
    },
    phoneValidation: function (component, event, helper) {
        var phoneInput = event.getSource();
        var pasrsedValue = parseInt( phoneInput.get('v.value') );
        phoneInput.set('v.value', isNaN(pasrsedValue) ? '' : (pasrsedValue +'') );
        var cv = component.get('v.cvToSend');
        cv.Phone__c = phoneInput.checkValidity() ? (pasrsedValue +'') : null;
        component.set('v.cvToSend', cv );               
        helper.validateCV( component );       
    }, 
    
    //standrd Lightning inputFile onchange listener
    handleUploadFinished: function (component, event, helper) {   
        
        var files = event.getParam("files");
        if (files.length>1) {
            return alert("You can upload only one image");
        }
   
        helper.validateUploadedfile(component, event, files[0]);
    },
    onDragOver: function(component, event) {
        
        //console.log('onDragOver'); 
        //console.log(event.getSource()); 
       // $A.util.addClass(event.getSource() , 'on_drag');
        event.preventDefault();
    },
    onDragLeave: function(component, event) {
         console.log('onDragLeave'); 
        
         $A.util.removeClass( component.find('draggableDiv') , 'on_drag');
       
    },
    onDragEnter: function(component, event) {
         console.log('onDragLeave'); 
         $A.util.addClass( component.find('draggableDiv') , 'on_drag');
       
    },
    onDrop: function(component, event, helper) {
		event.stopPropagation();
        event.preventDefault();
        event.dataTransfer.dropEffect = 'copy';
        var  files = event.dataTransfer.files;
        if (files.length>1) {
            return alert("You can upload only one image");
        }
        helper.validateUploadedfile(component, event, files[0]);
        
	}
    
})