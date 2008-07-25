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
		var library = currentDoc.library;
		var classes = [];
		var className;
		for(var i=0;i<library.items.length;i++){
			className = library.items[i].linkageClassName;
			if(className==undefined)continue;
			if(className=="")continue;
			classes.push(className);
		}
		classes.sort();
		for(i=0;i<classes.length;i++){
			if(classes[i]==classes[i-1])continue;
			fl.trace(classes[i]);
		}
	}else{
		alert('Please open a document before using the listUseClassInLibrary Command.')
	}
}

init();