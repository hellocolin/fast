import com.mixmedia.motion.MotionTween;
import com.mixmedia.mx.view.IButtonElement;
import com.mixmedia.utils.Conversion;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author colin
 */
class Label extends MovieClip implements IButtonElement {
	private static var overHColor:Object  = Conversion.hexToColor(0xFFFFFF, 100);
	private static var overColor:Object   = Conversion.hexToColor(0xFFFFFF, 100);
	private static var normalHColor:Object= Conversion.hexToColor(0xFFFFFF, 100);
	private static var normalColor:Object = Conversion.hexToColor(-1);
	private var motion : MotionTween;
	
	public function Label(){
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