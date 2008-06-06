import mx.utils.Delegate;import com.mixmedia.motion.MotionTweenIterator;
/**
 * @author Colin Leung
 */
class com.mixmedia.motion.TweenControl {	private static var iterator:MotionTweenIterator = MotionTweenIterator.instance();
	public var motionMCID:Number;
	public var tweenColor:Color;
	public var delayInterval_array:Array;
	public var isTweening:Boolean=false;
	private var tracker:MovieClip;	private var ref:String;

	public function TweenControl(mc:MovieClip){//proxy of movieclip
		tracker = mc.createEmptyMovieClip('_mxmMotionTweenTracker', 60000);
		tracker.onUnload = Delegate.create(this,clipUnloaded);		ref = String(mc);
		motionMCID = iterator.getMotionMCID();
		tweenColor = new Color(mc);
		delayInterval_array = new Array();
	}		private function clipUnloaded():Void{		iterator.tweenControl[ref];	}
}