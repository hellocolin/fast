//mixmedia jsfl
//author: Colin Colvia
//flash editor -- fl:Flash
//current Stage -- fl.getDocumentDOM():Document
fl.outputPanel.clear();
var currentDoc = fl.getDocumentDOM();
var library = currentDoc.library
var selectedElements = currentDoc.selection
var timeline = currentDoc.getTimeline();
var layers = currentDoc.getTimeline().layers;

function verify(){
	if(selectedElements.length!=1){
		alert('you only can select 1 item on Stage');
		return;
	}

	if(selectedElements[0].name == ""){
		alert('please name your instance');
		return;
	}

	var type = selectedElements[0].instanceType;
	if(!(type=='symbol'||type=='compiled clip')){
		alert('the instance is not symbol.')
		return;
	}
	
	exec();
}

function exec () {
	//find "script" layer,
	//if found, add script to such layer
	//otherwise, add a script layer on top
	for(i=0;i<layers.length;i++){
		if(layers[i].name=='script'){
			addScript(i)
			return;
		}
	}
	addScript(timeline.addNewLayer('script'));
}

function addScript (layerIndex) {
//	fl.trace(timeline.currentFrame);
//	layers[layerIndex].frames[timeline.currentFrame].actionScript="//hi"
	fl.trace(layers[layerIndex].frames[0].actionScript)
}
verify();