import mx.utils.Delegate;

import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.mx.view.ButtonEvt;
import com.mixmedia.mx.view.IButtonClip;
import com.mixmedia.mx.view.IButtonElement;
import com.mixmedia.utils.MovieClipTools;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author Colin
 */
class RepeatButtonClip extends MovieClip implements IButtonClip {
	private var hitArea:Button;
	private var base:ButtonEvt;
	private var count:Number;
	private var _enabled : Boolean = true;
	public var repeatPerFrame:Number = 0;

	public function RepeatButtonClip() {
		if(hitArea==null)hitArea = MovieClipTools.findButton(this);
		base = new ButtonEvt(hitArea);
		base.setCurrentTarget(this);
		base.addEventListener(ButtonClipEvent.MOUSE_DOWN,Delegate.create(this,down));
		base.addEventListener(ButtonClipEvent.MOUSE_UP,Delegate.create(this,up));
	}
	
	public function set enabled(value:Boolean):Void{
		_visible = value;
		_enabled = value;
	}
	
	public function get enabled():Boolean{
		return _enabled;
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

	private var baseIsDown:Boolean = false;
	private function down():Void{
		baseIsDown = true;
		count=repeatPerFrame;
	}
	
	private function up():Void{
		baseIsDown = false;
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
	
	public function select() : Void {
		base.select();
	}
}
