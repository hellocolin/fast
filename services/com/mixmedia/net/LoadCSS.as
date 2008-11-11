
/**
 * @author colin
 */
import mx.utils.Delegate;

import com.mixmedia.mx.StyleSheetEvt;

class com.mixmedia.net.LoadCSS implements ILoader, IFASTEventDispatcher {
	private var base:StyleSheetEvt;
	
	public function LoadCSS(){
		base = new StyleSheetEvt();
		base.setCurrentTarget(this);
	}

	public function getTargetContainer() : Object {
		return base.getBase();
	}

	public function addEventListener(event : String, handler:Function) : Void {
		base.addEventListener(event,handler);
	}

	public function removeEventListener(event : String, handler:Function) : Void {
		base.removeEventListener(event, handler);
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		base.setCurrentTarget(currentTarget);
	}
	
	public function unload() : Void {
		base.clear();
	}

	public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {
		this.addEventListener(eventType, Delegate.create(whichObject,callFunction));
	}
	
	public function load(requestURL : String) : Void {
		base.load(requestURL);
	}
}
