import mx.transitions.easing.Regular;import com.mixmedia.motion.MotionTween;import com.mixmedia.mx.view.IButtonElement;import com.mixmedia.view.events.ButtonClipEvent;/** * @author colin */class FixPositionToolTips extends MovieClip implements IButtonElement {	private var fadeout:MotionTween;	private var fadein:MotionTween;		public function FixPositionToolTips() {	}	private function onLoad():Void{		fadeout = new MotionTween(this,{a:0});		fadein = new MotionTween(this,{a:100,dur:5,tweenMethod:Regular.easeOut});		}		public function buttonOver(e : ButtonClipEvent) : Void {		fadein.startTween();	}		public function buttonOut(e : ButtonClipEvent) : Void {		fadeout.startTween();	}		public function buttonDown(e : ButtonClipEvent) : Void {	}		public function buttonReset(e : ButtonClipEvent) : Void {	}}