import com.mixmedia.motion.MotionTween;
import com.mixmedia.view.events.ButtonClipEvent;
/**
 * @author colin
 */
class ButtonIcon implements IButtonElement {
	private var motion : MotionTween;
	private var overHProp : Object;	private var overProp : Object;	private var normalHProp : Object;	private var normalProp : Object;
	public function ButtonIcon(base:MovieClip,button:IButtonClip,overHProp:Object,overProp:Object,normalHProp:Object,normalProp:Object){		this.overHProp   = overHProp==null  ?{}:overHProp;
		this.overProp    = overProp==null   ?{}:overProp;
		this.normalHProp = normalHProp==null?{}:normalHProp;
		this.normalProp  = normalProp==null ?{}:normalProp;
		motion = new MotionTween(base);
		button.addElement(this);
	}

	public function buttonOver(e : ButtonClipEvent) : Void {		motion.startTween(e.highlight?overHProp:overProp);
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