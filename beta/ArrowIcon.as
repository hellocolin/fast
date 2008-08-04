
/**
 * @author colin
 */
import mx.transitions.easing.Regular;

import com.mixmedia.utils.Conversion;
import com.mixmedia.view.events.ButtonClipEvent;

class ArrowIcon extends MovieClip implements IButtonElement {
	private var motion:Motion;
	
	public function ArrowIcon(){
		ButtonClip(_parent).addElement(this);
		motion = new Motion(this,{tweenMethod:Regular.easeOut});
	}
	
	public function buttonOver(e : ButtonClipEvent) : Void {
		motion.startTween({c:Conversion.hexToColor(0x000000,100)});
	}
	
	public function buttonOut(e : ButtonClipEvent) : Void {
		motion.startTween({c:Conversion.hexToColor(-1)});
	}
	
	public function buttonDown(e : ButtonClipEvent) : Void {
	}
	
	public function buttonReset(e : ButtonClipEvent) : Void {
		buttonOut(e);
	}
}
