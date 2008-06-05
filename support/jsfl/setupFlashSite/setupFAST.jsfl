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
var filePath = fl.configURI+ "Commands/";

function verify(){
	return true;
}

function exec () {
	currentDoc.importPublishProfile(filePath+'f7site.xml')
}

if(verify())exec();