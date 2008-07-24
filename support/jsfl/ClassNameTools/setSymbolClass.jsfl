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
				addInstanceNameIfEmpty();
				setPackagePath();
			}
		}else{
			alert('only accept 1 symbol instance on stage')
		}
	}else{
		alert('Please open a document before using the this Command.')
	}
}

function setPackagePath(){
	if(fl.packagePaths == undefined)return;
	var FASTPathsV1 = ';../classes;../FAST;./classes;./FAST';
	var FASTPathsV2 = ';../foundation;../services;../view;../FAST;./foundation;./services;./view;./FAST';
	var FASTPathsV3 = '../src;../ui;../controller;../foundation;../services;../view;../FAST;./src;./ui;./controller;./foundation;./services;./view;./FAST';

	if(fl.packagePaths.indexOf(FASTPathsV1)!=-1){
		var oldPath = fl.packagePaths.split(FASTPathsV1).join("");
		fl.packagePaths = oldPath;
		fl.trace('FAST V1 package path removed');
	}

	if(fl.packagePaths.indexOf(FASTPathsV2)!=-1){
		var oldPath = fl.packagePaths.split(FASTPathsV2).join("");
		fl.packagePaths = oldPath;
		fl.trace('FAST V2 package path removed');
	}
	
	if(fl.packagePaths.indexOf(FASTPathsV3)==-1){
		fl.packagePaths = FASTPathsV3+fl.packagePaths;
		fl.trace('FAST V3 package path added');
	}
}

function addInstanceNameIfEmpty(){
	if(selectedElements[0].name==''){
		selectedElements[0].name=selectedElements[0].libraryItem.name.split('/').pop();
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