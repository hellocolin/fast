﻿import com.mixmedia.motion.MotionTween;
import com.mixmedia.view.events.ButtonClipEvent;
/**
 * @author colin
 */
class ButtonIcon implements IButtonElement {
	private var motion : MotionTween;
	private var overHProp : Object;

		this.overProp    = overProp==null   ?{}:overProp;
		this.normalHProp = normalHProp==null?{}:normalHProp;
		this.normalProp  = normalProp==null ?{}:normalProp;

		button.addElement(this);
	}

	public function buttonOver(e : ButtonClipEvent) : Void {
	}
	
	public function buttonOut(e : ButtonClipEvent) : Void {
		motion.startTween(e.highlight?normalHProp:normalProp);
	}
	
	public function buttonDown(e : ButtonClipEvent) : Void {
	}
	
	public function buttonReset(e : ButtonClipEvent) : Void {
		buttonOut(e);
	}
}