import com.mixmedia.motion.MotionTween;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author colin
 */
class NavTab extends MovieClip implements IButtonElement {
	private var motion : MotionTween;
	private var id:String;
	
	public function NavTab(){
		motion = new MotionTween(this);
		id = _name.split("$")[1];
	}
	
	private function onLoad():Void{
		NavBtn(_parent['nBtn$'+id]).addElement(this);
	}

	public function buttonOver(e : ButtonClipEvent) : Void {
	}
	
	public function buttonOut(e : ButtonClipEvent) : Void {
	}
	
	public function buttonDown(e : ButtonClipEvent) : Void {
	}
	
	public function buttonReset(e : ButtonClipEvent) : Void {
		motion.startTween({y:e.highlight?0:28});
	}
}