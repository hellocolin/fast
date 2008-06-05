import com.mixmedia.motion.MotionTween;import com.mixmedia.utils.Conversion;import com.mixmedia.view.events.ButtonClipEvent;
/**
 * @author colin
 */
class Label extends MovieClip implements IButtonElement {
	private var overHColor:Object;
	private var overColor:Object;
	private var normalHColor:Object;
	private var normalColor:Object;
	private var motion : MotionTween;
	
	public function Label(){
		overHColor = Conversion.hexToColor(0xFFFFFF, 100);
		overColor  = Conversion.hexToColor(0xFFFFFF, 100);
		normalHColor = Conversion.hexToColor(0xFFFFFF, 100);
		normalColor = Conversion.hexToColor(-1);
		motion = new MotionTween(this);
		NavBtn(_parent).addElement(this);
	}

	public function buttonOver(e : ButtonClipEvent) : Void {
		motion.startTween({c:e.highlight?overHColor:overColor});
	}
	
	public function buttonOut(e : ButtonClipEvent) : Void {
		motion.startTween({c:e.highlight?normalHColor:normalColor});
	}
	
	public function buttonDown(e : ButtonClipEvent) : Void {
	}
	
	public function buttonReset(e : ButtonClipEvent) : Void {
		buttonOut(e);
	}
}