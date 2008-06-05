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
	
	fl.outputPanel.clear();
	var currentDoc = fl.getDocumentDOM();
	var library = currentDoc.library
	var selectedElements = currentDoc.selection;
	var isSelectInstance;
	if(selectedElements.length>1 ){alert('cannot duplicate multiple instances');return;}
	if(selectedElements.length==0){alert('please select 1 item on Stage');return;}

	for(var i=0;i<selectedElements.length;i++){
		if(selectedElements[i].elementType=='instance'){
			var oldItem   = selectedElements[i].libraryItem;
			var itemName  = oldItem.name;
			var itemClass = oldItem.linkageClassName;
			var itemNames = itemName.split("$");
			var num = Number(itemNames.pop());

			if(isNaN(num) ==true){
				alert('library item format should be xxxx$1, xxxx$2');
				return;
			}

			library.selectNone();
			library.duplicateItem(itemName);
			var newItems = library.getSelectedItems();
			
			//check new name exists
			var flag=true;
			while(flag){
				num = num+1;
				flag = library.itemExists(itemNames.join("$")+"$"+num);
			}
			
			var newName = itemNames.join("$")+"$"+num;
			newItems[0].name = newName.split("/").pop();
			isSelectInstance = true;

			if(itemClass!='' && oldItem.linkageExportForAS==true){
				newItems[0].linkageExportForAS = true;
				newItems[0].linkageExportInFirstFrame = true;
				newItems[0].linkageIdentifier = String(newItems[0].name).split('/').pop();
				newItems[0].linkageClassName = itemClass;
			}

			selectedElements[i].libraryItem = newItems[0];
			selectedElements[i].name = newItems[0].name.split("/").pop();
		}
	}
}

init();