import mx.utils.Delegate;

import com.mixmedia.motion.MotionTween;
import com.mixmedia.mx.events.Event;
import com.mixmedia.utils.MovieClipTools;
import com.mixmedia.view.status.IStatusIcon;

/**
@author Colin Leung
    * responsible to display the status.
*/

class com.mixmedia.view.status.ProgressIcon extends MovieClip implements IStatusIcon{
	//declare var
	private var mcLoadBar:MovieClip;
	private var txtStatus:TextField;
	private var mcBG : MovieClip;
	private var target : Object;//object
	private var motion:MotionTween;

	public function ProgressIcon(){
		MovieClipTools.notResize(this);
		MovieClipTools.makeClickDisable(mcBG);
		motion = new MotionTween(this,{dur:10,a:100});
		_alpha = 0;
		_x = Math.floor(_x);
		_y = Math.floor(_y);
		motion.startTween();
	}

	public function setMonitorTarget(target:Object):Void{
		this.target = target;
	}

	private function onEnterFrame():Void{
		var bytes_loaded:Number = target['getBytesLoaded']();
		var bytes_total:Number = target['getBytesTotal']();
		var getPercent:Number = (bytes_loaded/bytes_total)*100;
		if(getPercent>100)getPercent = 100;
		//if bytes total is 0,
		//1 request error
		//2 cannot get the byte total
		if(bytes_total==0||bytes_total==undefined){
			txtStatus.text = "Loading Data";
		}else{
			mcLoadBar._width = getPercent;
			txtStatus.text = "Loading: "+Math.round(getPercent)+"%";		
		}
	}
	
	public function kill() : Void {
		motion.addEventListener(Event.TWEENEND,Delegate.create(this,remove));
		motion.startTween({a:0});
	}

	private function remove(e:Event) : Void {
		MotionTween(e.currentTarget).removeEventListener(Event.TWEENEND,arguments.caller);
		this.removeMovieClip();
	}
}