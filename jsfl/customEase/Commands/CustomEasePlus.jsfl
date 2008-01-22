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
	commandAssetPath = filePath+"CustomEasePlus/"
	xmluiPath =  commandAssetPath+"XUI.xml";
	if(isDocOpen()){
		currentDoc = fl.getDocumentDOM();
		library = currentDoc.library;	
		items = library.getSelectedItems();
		selectedElements = currentDoc.selection;
		fl.outputPanel.clear();
		timeline = currentDoc.getTimeline()
		selectedFrames = timeline.getSelectedFrames();
		selectedLayers = timeline.getSelectedLayers();
		selectFrameLayers = selectedFrames.length/3;
		trace = fl.trace;
	}else{
	}
}

function getCurve(){//array of curves
	declareVar();

	var returnCurve=new Array();
	for(var i=0;i<selectFrameLayers;i++){
		var layerIndex = selectedFrames[(i*3)];
		var frameIndex = selectedFrames[(i*3)+1];
		var theFrame = timeline.layers[layerIndex].frames[frameIndex];
		var curveType = ["all", "position", "rotation", "scale", "color", "filters"];
		if(theFrame.hasCustomEase ==true){
			//loop for all curve type;
			for(var k=0;k<curveType.length;k++){
				var curveObj = theFrame.getCustomEase(curveType[k]);
				returnCurve[k]='';
				//loop for curve's all point
				for(var j=0;j<curveObj.length;j++){
					returnCurve[k]+= "{x:"+curveObj[j].x+",y:"+curveObj[j].y+"},"
				};
			}	
		}else{
			return "noCurveDefined";

		}
	}
	//loop for all curve type;
	for(var k=0;k<curveType.length;k++){
		//remove "," in the curve
		returnCurve[k] = returnCurve[k].substr(0,returnCurve[k].length-1)
	}
	return returnCurve;	
}

function saveCurve(curveName){
	declareVar()
	var curArray = getCurve();
	if(curArray!='noCurveDefined'){
		var textToWrite ="function returnCurve(curArray){\ncurArray[0]=["+curArray[0]+"];\ncurArray[1]=["+curArray[1]+"];\ncurArray[2]=["+curArray[2]+"];\ncurArray[3]=["+curArray[3]+"];\ncurArray[4]=["+curArray[4]+"];\ncurArray[5]=["+curArray[5]+"];\n}";
		FLfile.write(commandAssetPath+"data/"+curveName, textToWrite)
	}else{
		trace('you selected a frame without Custom Easing')
	}
}


function applyCurve(curveFile){
	declareVar();
	curveFile = commandAssetPath+"data/"+curveFile;
	var curArray = new Array();
	var curveType = ["all", "position", "rotation", "scale", "color", "filters"];
	timeline.createMotionTween();
	//loop to get selected frames' first frame
	//calculate selected Frames in layers
	var selectFrameLayers = selectedFrames.length/3;

	for(var i=0;i<selectFrameLayers;i++){//LOOP FOR LAYER
		fl.runScript(curveFile,'returnCurve',curArray);
		var layerIndex = selectedFrames[(i*3)];
		var frameIndex = selectedFrames[(i*3)+1];
		var theFrame = timeline.layers[layerIndex].frames[frameIndex];
		theFrame.hasCustomEase = true;
		for(var k=0;k<curveType.length;k++){
			if(k!=4){// error in setCustomEase in color, skip color
				theFrame.setCustomEase(curveType[k],curArray[k]);		
			}
		}
	}
}

function deleteCurve(curveName){
	declareVar();
	var curveFile = commandAssetPath+"data/"+curveName;
	FLfile.remove(curveFile);
	alert(curveName+' removed!')
}

function listCurve(){
	declareVar();
	var list = FLfile.listFolder(commandAssetPath+"data");
	if (list) {
		return list;
	}
}