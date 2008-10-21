import com.mixmedia.utils.MovieClipTools;
import com.mixmedia.view.ButtonEvt;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author Colin
 */
class ButtonClip extends MovieClip implements IButtonClip ,IFASTEventDispatcher{
	private var hitArea:Button;
	private var base:ButtonEvt;
	private var count:Number;
	private var _enabled : Boolean = true;
	public var repeatPerFrame:Number = 0;
	
	public function ButtonClip() {
		if(this[hitArea]==null)hitArea = MovieClipTools.findButton(this);
		base = new ButtonEvt(hitArea);
		base.setCurrentTarget(this);
		base.when(ButtonClipEvent.MOUSE_DOWN,this,down);
		base.when(ButtonClipEvent.MOUSE_UP,this,up);
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
	}

	public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {
		base.addEventListener(eventType,Fix.ref(whichObject,callFunction));
	}
	
	public function setMouseOverDelay(num : Number) : Void {
		base.setMouseOverDelay(num);
	}
	
	public function setMouseOutDelay(num : Number) : Void {
		base.setMouseOutDelay(num);
	}
	
	public function clearMouseOver() : Void {
		base.clearMouseOver();
	}
	
	public function clearMouseOut() : Void {
		base.clearMouseOut();
	}

	private var baseIsDown:Boolean = false;
	private function down():Void{
		baseIsDown = true;
		count=repeatPerFrame;
	}
	
	private function up():Void{
		baseIsDown = false;
	}

	public function set enabled(value:Boolean):Void{
		_visible = value;
		_enabled = value;
	}
	
	public function get enabled():Boolean{
		return _enabled;
	}

	public function onEnterFrame():Void{
		if(baseIsDown == false)return;
		if(repeatPerFrame<=0)return;
		if(count==0){
			hitArea.onRelease();
			if(_enabled==true)hitArea.onPress();
		}
		count--;
	}
}