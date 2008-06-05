﻿import mx.utils.Delegate;

 * @author Colin Leung
 */
class com.mixmedia.motion.TweenControl {
	public var motionMCID:Number;
	public var tweenColor:Color;
	public var delayInterval_array:Array;
	public var isTweening:Boolean=false;


	public function TweenControl(mc:MovieClip){//proxy of movieclip
		tracker = mc.createEmptyMovieClip('_mxmMotionTweenTracker', 60000);
		tracker.onUnload = Delegate.create(this,clipUnloaded);
		motionMCID = iterator.getMotionMCID();
		tweenColor = new Color(mc);
		delayInterval_array = new Array();
	}
}