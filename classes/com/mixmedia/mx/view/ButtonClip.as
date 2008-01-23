import mx.utils.Delegate;

import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.view.IButtonClip;
import com.mixmedia.mx.view.IButtonElement;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author Colin
 */
class com.mixmedia.mx.view.ButtonClip extends AbstractEventDispatcher implements IButtonClip{
	public var isHighlight:Boolean = false;
	private var hitArea:Button;

	public function ButtonClip(hitarea:Button){
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
		this.addEventListener(ButtonClipEvent.MOUSE_DOWN, Delegate.create(element,element.buttonDown));
		this.addEventListener(ButtonClipEvent.RESET     , Delegate.create(element,element.buttonReset));
	}

	private function out():Void{
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.MOUSE_OUT  ,this, isHighlight));
	}

	private function over():Void{
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.MOUSE_OVER ,this, isHighlight));
	}
	
	private function reset():Void{
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.RESET      ,this, isHighlight));
	}
	
	private function click():Void{
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.CLICK      ,this, isHighlight));
	}

	private function down():Void{
		dispatchEvent(new ButtonClipEvent(currentTarget,ButtonClipEvent.MOUSE_DOWN ,this, isHighlight));
	}
}