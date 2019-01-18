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
        console.log(files[0].name + ' ' + files[0].size);
        
        
        
        var file = files[0];             
        if(file.size > 128*1024){
            inputFile.value = "";
            alert('File is too big',' Choose only image less then 128Kb !');
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
   				var imageName = file.name;
                if(file.name.length >20){
                    imageName = file.name.substring(0, 20) + "...";
                };                
                var reader = new FileReader();                
                reader.onload = function (e) {
                    var tmppath =  e.target.result;
                    var div = "<div ><strong>" + imageName + "</strong> -<span> "+ fileSize +"<span></div>";
                    var content = document.createTextNode(div);
                    document.getElementById("preview").innerHTML += div + "<img src=\""+tmppath+ "\"></img>";
                    component.set('v.cvPhoto', tmppath);
                }
                reader.readAsDataURL(file);
                
                $A.util.removeClass( component.find('draggableDiv') , 'on_drag');
                
                
            }else{ 
                alert('Inappropriate type. Choose only image file!'); 
            }                
        }       
        
        
        
        
        
	}
    
})