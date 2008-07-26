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
		var selectedElements = currentDoc.library.getSelectedItems();

		if(selectedElements.length>0){
			for(var i=0;i<selectedElements.length;i++){
				if(selectedElements[i].itemType=='movie clip'){
					selectedElements[i].linkageExportForAS = true;
					selectedElements[i].linkageExportInFirstFrame = true;
					var names = selectedElements[i].name.split("/");

					selectedElements[i].linkageIdentifier = names.pop().toLowerCase();
				}
			}
		}else{
			alert('Please select item(s) in Library.')
		}
	}else{
		alert('Please open a document before using the setClipsID Command.')
	}
}

init();