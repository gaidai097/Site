({
    validateUploadedfile : function(component, event, file) {
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
                    var removeLink = "<span class=\"removeFile\" title=\"Remove\" href=\"#\" ><span>&#10006;</span></span>";
                    
                    var content = "<span id=\"imageName\"><strong>" + imageName + "</strong> -<span> "+ fileSize +"<span>&nbsp; &nbsp; "+ removeLink + "<img alt='Your image' class='preview_img' src='"+tmppath+"'></img></span>"
                    document.getElementById("preview").innerHTML += content;
                    component.set('v.cvPhoto', tmppath);
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
                    });
                }
                reader.readAsDataURL(file);                
                $A.util.removeClass( component.find('draggableDiv') , 'on_drag');
                
                
            }else{ 
                alert('Inappropriate type. Choose only image file!'); 
            }                
        }       
    }
})