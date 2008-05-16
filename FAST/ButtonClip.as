import com.mixmedia.mx.events.IFASTEventDispatcher;import com.mixmedia.mx.view.ButtonEvt;import com.mixmedia.mx.view.IButtonClip;import com.mixmedia.mx.view.IButtonElement;import com.mixmedia.utils.MovieClipTools;/**
 * @author Colin
 */
class ButtonClip extends MovieClip implements IButtonClip ,IFASTEventDispatcher{
	private var hitArea:Button;
	private var base:ButtonEvt;
	
	public function ButtonClip() {
		if(this[hitArea]==null)hitArea = MovieClipTools.findButton(this);
		base = new ButtonEvt(hitArea);
		base.setCurrentTarget(this);
	}

	public function addElement(element : IButtonElement) : Void {
		base.addElement(element);
	}

	public function addEventListener(event : String, handler : Function) : Void {
		base.addEventListener(event, handler);
	}

	public function removeEventListener(event : String, handler : Function) : Void {
		base.removeEventListener(event, handler);
	}

	public function setCurrentTarget(currentTarget : Object) : Void {
		base.setCurrentTarget(currentTarget);
	}

	public function select() : Void {
		base.select();
	}	public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {		base.addEventListener(eventType,Fix.ref(whichObject,callFunction));	}
	
	public function setMouseOverDelay(num : Number) : Void {		base.setMouseOverDelay(num);	}
	
	public function setMouseOutDelay(num : Number) : Void {		base.setMouseOverDelay(num);	}
	
	public function clearMouseOver() : Void {		base.clearMouseOver();	}
	
	public function clearMouseOut() : Void {		base.clearMouseOut();	}
}