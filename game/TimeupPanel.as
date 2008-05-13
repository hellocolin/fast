import com.mixmedia.motion.MotionTween;
import com.mixmedia.mx.AbstractMovieClipEventDispatcher;
import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.utils.MovieClipTools;

/**
 * @author colin
 */
class TimeupPanel extends AbstractMovieClipEventDispatcher implements IEventDispatcher{
	private var bg:MovieClip;
	private var motion:Motion;
	private var btnStart:ButtonClip;

	private function onLoad():Void{
		MovieClipTools.makeClickDisable(bg);
		motion = new Motion(this,{dur:10});
		_alpha=0;
		
		btnStart.when(MouseEvent.CLICK, this, click);
	}
	
	public function show():Void{
		motion.startTween({a:100});
	}
	
	public function hide():Void{
		motion.response = true;
		motion.startTween({a:0});
	}
	
	private function click():Void{
		dispatchEvent(new MouseEvent(this,MouseEvent.CLICK));
	}
}
