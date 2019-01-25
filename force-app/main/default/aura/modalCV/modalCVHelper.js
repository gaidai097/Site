({  
    runAlert: function(msg, severity){ 
        var event = $A.get("e.c:runAlert");
        event.setParams({ "msg": msg ,"severity": severity });        
        event.fire();
    },
    makeRequest: function( component, event){
		console.log('saveCV ');
        
        var selectedIDs = [];
        var selectedJobs = component.get('v.selectedJobs');
        var cvPhoto = component.get('v.cvPhoto');
        var cvToSend = component.get('v.cvToSend'); 
        var cvPhotoName = component.get('v.cvPhotoName');
        console.log('saveCV 1');
        for(var i = 0; i < selectedJobs.length; i++){
            console.log( selectedJobs[i].Id );
            selectedIDs.push(selectedJobs[i].Id);
        }   
        console.log('saveCV 1+' + selectedIDs.length );
        console.log(selectedIDs );
        console.log('saveCV 1+' + cvToSend );
        console.log('cvPhoto+  ==' + cvPhoto.length );
      
        var action = component.get("c.saveCV");  
        console.log('saveCV 2');      
        console.log('saveCV 3');
        // Create the action
       
        action.setParams({                                   
            "selectedIDs": selectedIDs,
            "cv":          cvToSend,
            "cvPhoto":     cvPhoto, 
            "cvPhotoName": cvPhotoName           
        }); 
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('Done');
                this.runAlert('CV successfully saved!' , 'success');
            }else if (state === "ERROR") {
                var errors = response.getError();
                console.log(response);
                console.log(errors);
                if(errors){
                    if (errors[0] && errors[0].message) {
                        this.runAlert('Error message: ' + errors[0].message , 'error');
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                }else{
                     this.runAlert('Unknown error' , 'error');
                    console.log("Unknown error");
                }
            }else if (state === "INCOMPLETE") {
                console.log('Action state === "INCOMPLETE"');
                this.runAlert('Action state === "INCOMPLETE"' , 'error');
            }
            var modal = component.find( 'cvModalWindow' );
            var mask = component.find( 'cvModalMask' );
            $A.util.removeClass( modal, 'slds-fade-in-open' );
            $A.util.removeClass( mask, 'slds-backdrop_open' );
        });        
        $A.enqueueAction(action);
        
    },
    validateCV: function(component){
        var firstName = component.get('v.firstName');
        var lastName = component.get('v.lastName');
        var sendCVBtn = component.find('sendCVBtn');
        var valid = true;
        if( firstName == null || lastName == null ){            
            sendCVBtn.set( 'v.disabled', true);
            return false;
        } 
        console.log('*0*');
        var cv = component.get( 'v.cvToSend');
        cv.Name = firstName + ' ' + lastName ;
        console.log(cv.Name);
        component.set( 'v.cvToSend', cv);
         console.log('*1*');
        this.printFields( component);
        cv = component.get( 'v.cvToSend');
         console.log('*2*');
        if( cv.Age__c == null    ||
            cv.Salary__c == null ||
            cv.Email__c == null  ||
            cv.Phone__c == null  ||
            cv.Status__c == null ||
            component.get('v.cvPhoto') == null
          ){ valid = false; }
         console.log('*3*');
        if( !valid ){ 
             console.log('*4-0*');
            sendCVBtn.set( 'v.disabled', true);
        }else{
            var cv = component.get( 'v.cvToSend');
            sendCVBtn.set( 'v.disabled', false);
             console.log('*4-1*');
        }
         console.log('*5*');
    },
    disableCVBtn: function(component){
        var cv = component.get( 'v.cvToSend');
        sendCVBtn.set( 'v.disabled', true);
    }
    ,
    printFields: function(component){
        var cvOutput = component.get('v.cvToSend');
        console.log( '********BEGIN*********');
        console.log( cvOutput.Age__c );
        console.log( cvOutput.Salary__c);
        console.log( cvOutput.Phone__c);
        console.log( cvOutput.Name);
        console.log( cvOutput.Status__c);
        console.log( cvOutput.Email__c);
        console.log( cvOutput.Additional_info__c);
        console.log( '********END*********');
    },
    validateUploadedfile : function(component, event, file) {
        var inputFile= component.find('inputFile');
        if(file.size > 128*1024){
            inputFile.set('v.value', null);
            inputFile.setCustomValidity('File is too big. Choose only image less then 128Kb !') ;
            inputFile.reportValidity() ;
        }else{
            var marker = false;            
            var types = ["image/gif","image/jpeg","image/jpg","image/png","image/bmp"];                
            for(var j = 0; j< types.length; j++){
                if(types[j] == file.type){
                    marker = true;
                    break; 
                };
            };
            if(marker){                 
                var fileSize = file.size;
                if (file.size > 1024 * 1024) {
                    fileSize = (Math.round(file.size*100 / (1024 * 1024)) /100).toString() + ' MB';
                }else {
                    fileSize = (Math.round(file.size / 1024) ).toString() + ' KB';
                }; 
                inputFile.setCustomValidity('') ;
                inputFile.reportValidity() ;
                var helpObj = this;
                var imageName = file.name;
                if(file.name.length >20){
                    imageName = file.name.substring(0, 20) + "...";
                };    
                component.set('v.cvPhotoName', imageName); 
                var reader = new FileReader();                
                reader.onload = function (e) {
                    console.log(e.target.result);
                    var tmppath =  e.target.result;
                    var removeLink = "<span class=\"removeFile\" title=\"Remove\" href=\"#\" ><span>&#10006;</span></span>";
                    
                    var content = "<span id=\"imageName\"><strong>" + imageName + "</strong> -<span> "+ fileSize +"<span>&nbsp; &nbsp; "+ removeLink + "<img alt='Your image' class='preview_img' src='"+tmppath+"'></img></span>"
                    document.getElementById("preview").innerHTML += content;
                    component.set('v.cvPhoto', tmppath);
                    helpObj.validateCV( component );
                    document.getElementsByClassName("dragPicture")[0].classList.toggle('toggle'); 
                    $A.util.addClass( component.find('inputFile'), 'toggle');
                    document.getElementById("imageName").addEventListener("mouseout", function( event ) { 
                        document.getElementsByClassName("preview_img")[0].style.display = 'none';
                    });
                    document.getElementById("imageName").addEventListener("mouseover", function( event ) { 
                        document.getElementsByClassName("preview_img")[0].style.display = 'block'; 
                    });
                    document.getElementsByClassName("removeFile")[0].addEventListener("click", function( event ) { 
                        $A.util.removeClass( component.find('inputFile'), 'toggle');
                        document.getElementsByClassName("dragPicture")[0].classList.toggle('toggle');                        
                        document.getElementById("imageName").remove();
                        component.set('v.cvPhoto', null);
                        component.set('v.cvPhotoName', null);                        
                        component.find('sendCVBtn').set( 'v.disabled', true);
                    });
                }
                reader.readAsDataURL(file);                
                $A.util.removeClass( component.find('draggableDiv') , 'on_drag');                
                
            }else{ 
                inputFile.set('v.value', null);
                inputFile.setCustomValidity('Inappropriate type. Choose only image file!') ;
                inputFile.reportValidity() ;
            }                
        }       
    }
})