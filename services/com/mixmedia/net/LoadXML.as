import mx.utils.Delegate;

import com.mixmedia.mx.XMLEvt;

/**
 * @author colin
 */
class com.mixmedia.net.LoadXML implements ILoader, IFASTEventDispatcher {
	private var xmlContent : XMLEvt;
	private var request : String;

	public function LoadXML(){
		xmlContent = new XMLEvt();
		xmlContent.setCurrentTarget(this);
	}
	
	public function load(requestURL : String):Void{
		this.request = requestURL;
		xmlContent.load(request);
	}

	public function getTargetContainer() : Object {
		return xmlContent;
	}

	public function addEventListener(event : String, handler:Function) : Void {
		xmlContent.addEventListener(event,handler);
	}

	public function removeEventListener(event : String, handler:Function) : Void {
		xmlContent.removeEventListener(event, handler);
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		xmlContent.setCurrentTarget(currentTarget);
	}
	
	public function unload() : Void {}

	public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {
		this.addEventListener(eventType, Delegate.create(whichObject,callFunction));
	}
}