import mx.utils.Delegate;

import com.mixmedia.motion.TweenControl;
/**
 * @author Colin Leung
 */
class com.mixmedia.motion.MotionTweenIterator {
	private static var ins:MotionTweenIterator;
	private var mc:MovieClip;
	private var totalMTMC:Number=0;//total count of movieclip attached with motiontween
	private var totalMT:Number=0;//total count of motiontween
	
	public var tweenArray:Array;
	public var tweenControl:Array;
	
	private function MotionTweenIterator(){
		tweenArray = new Array();//:{MotionTween};
		tweenControl = new Array(); //:[String]; string is target_mc path name;
		makeIterator();
	}
	
	public static function instance():MotionTweenIterator{
		if(ins == null)ins = new MotionTweenIterator();
		if(ins.mc.onEnterFrame == undefined)ins.makeIterator();
		return ins;
	}
	
	private function makeIterator():Void{
		mc = _root.createEmptyMovieClip('tweenmc',50000);
		mc.onEnterFrame = Delegate.create(this,onEnterFrame);
	}

	private function onEnterFrame() : Void {
		for(var i:Number=0;i<tweenArray.length;i++){
			tweenArray[i].tweenCode();
		}
	}

	public function getMotionMCID():Number{
		return totalMTMC++;
	};

	public function getMotionID():Number{
		return totalMT++;
	};
	
	public function getTweenControl(m:MovieClip):TweenControl{
		var mcPath:String = String(m);
		if(tweenControl[mcPath]== null)tweenControl[mcPath] = new TweenControl(m);
		return tweenControl[mcPath];
	}
}