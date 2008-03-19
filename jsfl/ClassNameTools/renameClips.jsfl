//mixmedia jsfl
//author: Colin Colvia
//flash editor -- fl:Flash
//current Stage -- fl.getDocumentDOM():Document
//version 1.0.1 fix bug: 1.When no document is opened then on clicking Commands-renameClips, giving TypeError at line6 of file "renameClips" that currentDoc has no properties.
//				fix bug: name component and compiled clip instances.

function isDocOpen(){
	if(fl.getDocumentDOM()==null){
		return false;
	}else{
		return true;
	}
}

function init(){
	if(isDocOpen()==true){;
		fl.outputPanel.clear();
		var currentDoc = fl.getDocumentDOM();
		var library = currentDoc.library
		var selectedElements = currentDoc.selection;
		var isSelectInstance;
		if(selectedElements.length>0){
			for(var i=0;i<selectedElements.length;i++){
				if(selectedElements[i].elementType=='instance'){
					var names = selectedElements[i].libraryItem.name.split("/");
					selectedElements[i].name = names.pop();
					isSelectInstance = true;
				}
			}
			if(isSelectInstance!=true){
				alert('Please select instance(s) on Stage.')
			}
		}else{
			alert('Please select item(s) on Stage.')
		}
	}else{
		alert('Please open a document before using the renameClips Command.')
	}
}

init();