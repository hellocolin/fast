import mx.utils.Delegate;

import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author colin
 */
class ScrollBar extends MovieClip{
	private var target : IScrollable;
	private var btnUp:ButtonClip;
	private var btnDown:ButtonClip;

	private function onLoad():Void{
		btnUp.repeatPerFrame = 3;
		btnDown.repeatPerFrame = 3;
		btnUp.addEventListener(ButtonClipEvent.MOUSE_DOWN, Delegate.create(this,up));
		btnDown.addEventListener(ButtonClipEvent.MOUSE_DOWN, Delegate.create(this,down));
	}

	public function setTarget(target:IScrollable) : Void {
		this.target = target;
		verifyButtonState();
	}

	private function up():Void{
		target.setIndex(target.getIndex()-1);
		verifyButtonState();
	}

	private function down():Void{
		target.setIndex(target.getIndex()+1);
		verifyButtonState();
	}
	
	private function verifyButtonState():Void{
		btnUp.enabled = (target.getIndex()<=0)?false:true;
		btnDown.enabled = (target.getIndex()>=target.getMax())?false:true;	
	}
}
