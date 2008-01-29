import mx.utils.Delegate;

import com.mixmedia.motion.MotionTween;
import com.mixmedia.view.ButtonClip;

/**
 * @author Colin
 */
class Menu extends MovieClip {
	private var items:ButtonClip;
	public static var STATUS_SHOW:String = "show";
	public static var STATUS_HIDE:String = "hide";

	private var iid:Number;
	private var showMotion:MotionTween;
	private var hideMotion:MotionTween;
	
	public function Menu() {
		showMotion = new MotionTween(this,{a:100});
		hideMotion = new MotionTween(this,{a:0});
	}
	
	public function show():Void{
		showMotion.startTween();
	}
	
	public function hide():Void{
		clearHide();
		setInterval(Delegate.create(this, hideImp));
	}
	
	private function hideImp():Void{
		hideMotion.startTween();
	}
	
	private function clearHide():Void{
		clearInterval(iid);
	}
}
