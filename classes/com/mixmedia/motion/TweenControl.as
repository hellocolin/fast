import com.mixmedia.motion.MotionTweenIterator;
/**
 * @author Colin Leung
 */
class com.mixmedia.motion.TweenControl {
	public var motionMCID:Number;
	public var tweenColor:Color;
	public var delayInterval_array:Array;
	public var isTweening:Boolean=false;

	public function TweenControl(mc:MovieClip){//proxy of movieclip
		var iterator:MotionTweenIterator = MotionTweenIterator.instance();
		motionMCID = iterator.getMotionMCID();
		tweenColor = new Color(mc);
		delayInterval_array = new Array();
	}
}