import mx.utils.Delegate;

import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.view.IButtonClip;
import com.mixmedia.mx.view.IButtonElement;
import com.mixmedia.view.events.ButtonClipEvent;
import com.mixmedia.mx.events.MouseEvent;

/**
 * @author Colin
 */
class com.mixmedia.mx.view.ButtonEvt extends AbstractEventDispatcher implements IButtonClip{
	private var _isHighlight:Boolean = false;
	private var hitArea: Button;
	private var delay : Number=0;
	private var iid:Number;

	public function ButtonEvt(hitarea:Button){
		this.hitArea = hitarea;

		hitarea.onRollOver = Delegate.create(this,over);
		hitarea.onRollOut = Delegate.create(this,out);
		hitarea.onRelease = Delegate.create(this,click);
		hitarea.onPress = Delegate.create(this, down);
		hitarea.onDragOver = hitarea.onRollOver;
		hitarea.onDragOut = hitarea.onRollOut;
		hitarea.onReleaseOutside = hitarea.onRelease;
	}
	
	public function addElement(element:IButtonElement):Void{
		this.addEventListener(ButtonClipEvent.MOUSE_OVER , Delegate.create(element,element.buttonOver));
		this.addEventListener(ButtonClipEvent.MOUSE_OUT  , Delegate.create(element,element.buttonOut));
		this.addEventListener(ButtonClipEvent.MOUSE_DOWN , Delegate.create(element,element.buttonDown));
		this.addEventListener(ButtonClipEvent.RESET      , Delegate.create(element,element.buttonReset));
	}

	private function out():Void{
		clearInterval(iid);
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.MOUSE_OUT  ,hitArea, isHighlight));
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.ROLL_OUT, hitArea, isHighlight));
	}

	private function over():Void{
		clearInterval(iid);
		if(delay==0){
			doOver();
		}else{
			iid = setInterval(Fix.ref(this,doOver),delay);
		}
	}

	private function doOver():Void{
		clearInterval(iid);
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.MOUSE_OVER ,hitArea, isHighlight));
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.ROLL_OVER, hitArea, isHighlight));	
	}
	
	private function reset():Void{
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.RESET		,hitArea, isHighlight));
	}
	
	private function click():Void{
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.MOUSE_UP	,hitArea, isHighlight));
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.CLICK		,hitArea, isHighlight));
	}

	private function down():Void{
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.MOUSE_DOWN ,hitArea, isHighlight));
	}
	
	public function get isHighlight():Boolean{
		return _isHighlight;
	}
	
	public function set isHighlight(value:Boolean):Void{
		_isHighlight = value;
		reset();
	}		public function select() : Void {
		isHighlight = true;
	}
	
	public function setMouseOverDelay(num : Number) : Void {
		delay = num;
	}
}