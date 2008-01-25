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

function run(){//return string
	declareVar();
	var symbolItem = selectedElements[0].libraryItem;
	return symbolItem.linkageClassName;
}