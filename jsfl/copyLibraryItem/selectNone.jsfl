//mixmedia jsfl
//author: Colin Colvia
//flash editor -- fl:Flash
//current Stage -- fl.getDocumentDOM():Document

function isDocOpen(){
	if(fl.getDocumentDOM()==null){
		return false;
	}else{
		return true;
	}
}

function init(){
	if(isDocOpen()!=true){
		alert('Please open a document before using the renameClips Command.');
		return;
	}

	fl.getDocumentDOM().selectNone();
}

init();