//mixmedia jsfl
//author: Colin Colvia
//flash editor -- fl:Flash
//current Stage -- fl.getDocumentDOM():Document
fl.outputPanel.clear();
var currentDoc = fl.getDocumentDOM();
var library = currentDoc.library
var selectedElements = currentDoc.selection

function init(){
	if(selectedElements.length==1){
		if(selectedElements[0].instanceType=='symbol'){
			fl.trace(selectedElements[0].libraryItem.linkageClassName)
		}
	}else{
		alert('you only can select 1 item on Stage');
	}
}

init();