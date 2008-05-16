import com.mixmedia.mx.events.IFASTEventDispatcher;import com.mixmedia.mx.view.IButtonClip;import com.mixmedia.mx.view.IButtonElement;import com.mixmedia.mx.view.NavButton;import com.mixmedia.utils.MovieClipTools;/**
 * @author Colin
 */
class NavBtn extends MovieClip implements IButtonClip,IFASTEventDispatcher{
	private var hitarea:Button;
	private var base:NavButton;

	public function NavBtn(){
		var para:Array = _name.split("$");
		base = new NavButton(MovieClipTools.findButton(this),para[1],para[2]);
		base.setCurrentTarget(this);
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

	public function addElement(element : IButtonElement) : Void {
		base.addElement(element);
	}

	public function select() : Void {
		base.select();
	}	public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {		base.addEventListener(eventType, Fix.ref(whichObject,callFunction));	}	public function setMouseOverDelay(num : Number) : Void {		base.setMouseOverDelay(num);	}
	
	public function clearMouseOut() : Void {		base.clearMouseOut();	}
	
	public function setMouseOutTimeout(value : Number) : Void {		base.setMouseOutTimeout(value);	}
}
