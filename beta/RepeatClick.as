import mx.utils.Delegate;

import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author Colin
 */
class RepeatClick implements IButtonClip, IEventDispatcher{
	private var _interval:Number;
	private var base : IButtonClip;
	private var baseIsDown:Boolean = false;
	private var hitArea:Button;
	private var iid:Number;

	public function RepeatClick(base:IButtonClip) {
		this.base = base;
		base.setCurrentTarget(this);
		base.addEventListener(ButtonClipEvent.MOUSE_DOWN,Delegate.create(this,down));
		base.addEventListener(ButtonClipEvent.MOUSE_UP,Delegate.create(this,up));
		interval = 100;
	}

	public function set interval(interval:Number):Void{
		clearInterval(iid);
		_interval = interval;
		iid = setInterval(Delegate.create(this,loop),_interval);
	}

	private function loop():Void{
		if(baseIsDown == false)return;
		hitArea.onRelease();
		hitArea.onPress();
	}

	private function down(e:ButtonClipEvent):Void{
		hitArea = Button(e.target);
		baseIsDown = true;
	}
	
	private function up():Void{
		baseIsDown = false;
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
	
	public function setMouseOverDelay(num : Number) : Void {
		base.setMouseOverDelay(num);
	}		public function setMouseOutDelay(num : Number) : Void {
		base.setMouseOverDelay(num);
	}
	
	public function clearMouseOver() : Void {
		base.clearMouseOver();
	}
	
	public function clearMouseOut() : Void {
		base.clearMouseOut();
	}
}
