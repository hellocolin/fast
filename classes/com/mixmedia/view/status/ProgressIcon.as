import com.mixmedia.utils.MovieClipTools;
/**
   @author Colin Leung
    * responsible to display the status.
*/

class com.mixmedia.view.status.ProgressIcon extends MovieClip{
	//declare var
	private var mcLoadBar:MovieClip;
	private var txtStatus:TextField;
	private var mcBG : MovieClip;
	private var target : Object;//object

	public function ProgressIcon(){
		MovieClipTools.notResize(this);
		MovieClipTools.makeClickDisable(mcBG);
//		_alpha = 0;
	}

	public function setMonitorTarget(target:Object):Void{
		this.target = target;
	}

	private function onEnterFrame():Void{
		var bytes_loaded:Number = target['getBytesLoaded']();
		var bytes_total:Number = target['getBytesTotal']();
		var getPercent:Number = (bytes_loaded/bytes_total)*100;
		//if bytes total is 0,
		//1 request error
		//2 cannot get the byte total
		if(bytes_total==0||bytes_total==undefined){
			txtStatus.text = "Loading Data";
		}else{
			mcLoadBar._width = getPercent/100*50;
			txtStatus.text = "Loading: "+Math.round(getPercent)+"%";		
		}
	}
}