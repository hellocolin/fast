import mx.utils.Delegate;

import com.mixmedia.motion.MotionTween;
import com.mixmedia.mx.events.MouseEvent;

/**
 * @author Colin
 */
class Menu extends MovieClip {
	private var navKey:String;

	private var iid:Number;
	private var showMotion:MotionTween;
	private var hideMotion:MotionTween;
	
	public function Menu(){
		_alpha = 0;
		_visible = false;

		showMotion = new MotionTween(this,{a:100});
		hideMotion = new MotionTween(this,{a:0});

		var para:Array = _name.split("$");
		this.navKey = para[1];
	}
	
	public function onLoad():Void{
		for(var n in this){
			if(this[n] instanceof NavBtn){
				NavBtn(this[n]).addEventListener(MouseEvent.MOUSE_OVER, Delegate.create(this,show));
				NavBtn(this[n]).addEventListener(MouseEvent.MOUSE_OUT, Delegate.create(this,hide));
			}
		}
	}
	
	public function show():Void{
		clearHide();
		showMotion.startTween();
	}
	
	public function hide():Void{
		clearHide();
		iid = setInterval(Delegate.create(this, hideImp),500);
	}
	
	private function hideImp():Void{
		clearHide();
		hideMotion.startTween();
	}
	
	private function clearHide():Void{
		clearInterval(iid);
	}
}
