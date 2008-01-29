import mx.utils.Delegate;

import com.mixmedia.motion.MotionTween;

/**
 * @author Colin
 */
class Menu extends MovieClip {
	private var navBtns:Array=[];
	public static var STATUS_SHOW:String = "show";
	public static var STATUS_HIDE:String = "hide";

	private var iid:Number;
	private var showMotion:MotionTween;
	private var hideMotion:MotionTween;
	
	public function Menu(){
		trace('hi');
		showMotion = new MotionTween(this,{a:100});
		hideMotion = new MotionTween(this,{a:0});
		
		for(var n in this){
			if(this[n] instanceof NavBtn){
				navBtns.push(this[n]);
			}
		}
	}
	
	public function show():Void{
		showMotion.startTween();
	}
	
	public function hide():Void{
		clearHide();
		setInterval(Delegate.create(this, hideImp),500);
	}
	
	private function hideImp():Void{
		hideMotion.startTween();
	}
	
	private function clearHide():Void{
		clearInterval(iid);
	}
}
