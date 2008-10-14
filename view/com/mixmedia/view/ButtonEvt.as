import mx.utils.Delegate;

import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author Colin
 */
class com.mixmedia.view.ButtonEvt extends AbstractEventDispatcher implements IButtonClip{
	private var _isHighlight:Boolean = false;
	private var hitArea: Button;
	private var overDelay : Number=0;
	private var outDelay:Number=0;
	private var overIID:Number;
	private var outIID:Number;

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
	
	private function clearIID():Void{
		clearInterval(overIID);
		clearInterval(outIID);
	}

	private function out():Void{
		clearIID();
		if(outDelay==0){
			doOut();
		}else{
			outIID = setInterval(Delegate.create(this,doOut),outDelay);
		}
	}
	
	private function doOut():Void{
		clearIID();
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.MOUSE_OUT  ,hitArea, isHighlight));
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.ROLL_OUT   ,hitArea, isHighlight));
	}

	private function over():Void{
		clearIID();
		if(overDelay==0){
			doOver();
		}else{
			overIID = setInterval(Delegate.create(this,doOver),overDelay);
		}
	}

	private function doOver():Void{
		clearIID();
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.MOUSE_OVER ,hitArea, isHighlight));
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.ROLL_OVER  ,hitArea, isHighlight));	
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
	}	
	public function getBase():Button{
		return hitArea;
	}
		public function select() : Void {
		isHighlight = true;
		reset();
		dispatchEvent(new ButtonClipEvent(currentTarget, ButtonClipEvent.SELECT, hitArea,isHighlight));
	}

	public function setMouseOverDelay(num : Number) : Void {
		overDelay = num;
	}
	
	public function setMouseOutDelay(num : Number) : Void {
		outDelay = num;
	}

	public function clearMouseOver() : Void {
		clearInterval(overIID);
	}

	public function clearMouseOut() : Void {
		clearInterval(outIID);
	}
}