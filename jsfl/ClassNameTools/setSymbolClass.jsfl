//mixmedia jsfl
//author: Colin Colvia
//flash editor -- fl:Flash
//current Stage -- fl.getDocumentDOM():Document

var filePath,xmluiPath,xui,currentDoc,library,items

function isDocOpen(){
	return (fl.getDocumentDOM()==null)?false:true;
}

function declareVar(){
	filePath = fl.configURI+ "Commands/"
	//filePath = "file:///"
	xmluiPath =  filePath+"setSymbolClass/setSymbolClass.xml";
	currentDoc = fl.getDocumentDOM();
	library = currentDoc.library;	
	items = library.getSelectedItems();
	selectedElements = currentDoc.selection;
	fl.outputPanel.clear();
}

function isSymbol(obj){
	return (obj.libraryItem == null)?false:true;
}

function init(){
	if(isDocOpen()==true){
		declareVar();
		if(selectedElements.length>0&&isSymbol(selectedElements[0])){// something slected

			if(selectedElements[0].libraryItem.linkageClassName!=""){
				xui = currentDoc.xmlPanel(xmluiPath);
				
			}else{
				alert('this instance already assigned class name.')
				xui = currentDoc.xmlPanel(xmluiPath);
			}
			if(xui.dismiss == 'accept'){
				renameItemsClass();
				if(selectedElements[0].name==''){
					selectedElements[0].name=selectedElements[0].libraryItem.name.split('/').pop();
				}
			}
		}else{
			alert('only accept 1 symbol instance on stage')
		}
	}else{
		alert('Please open a document before using the this Command.')
	}
}

function renameItemsClass(){
	var symbolItem = selectedElements[0].libraryItem;
	symbolItem.linkageExportForAS = true;
	symbolItem.linkageExportInFirstFrame = true;
	symbolItem.linkageIdentifier = String(symbolItem.name).split('/').pop();
	symbolItem.linkageClassName = xui.asclass
}

init();