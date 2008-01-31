import mx.utils.Delegate;

import com.mixmedia.mx.AbstractMovieClipEventDispatcher;
import com.mixmedia.mx.NetStreamEvt;
import com.mixmedia.mx.events.ErrorEvent;
import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.net.ILoader;
import com.mixmedia.net.LoadFLV;
import com.mixmedia.net.Loader;
import com.mixmedia.view.events.VideoPlayerEvent;

/**
 * @author Colin
 */
class com.mixmedia.view.net.VideoPlayer extends AbstractMovieClipEventDispatcher implements IEventDispatcher,ILoader{	
	private var isMetaReady : Boolean=false;
	private var startTime:Number=0;
	private var speedSlope:Number;

	private var vid:Video;
	private var loader:Loader;
	private var ns:NetStreamEvt;

	private var isPlay : Boolean = false;
	private var flvURL : String;

	public var safePlayToEnd : Boolean = false;
	public var errorCode : String;
	public var clickDisable : Boolean = true;
	
	public var autoPlay:Boolean = false;

	public function VideoPlayer(){
		loader = new Loader(new LoadFLV(vid,false,1,true,0),1);
		loader.addEventListener(LoaderEvent.READY, Delegate.create(this,onFLVLoad));
		loader.addEventListener(LoaderEvent.PROGRESS,Delegate.create(this,onProgress));
		loader.addEventListener(ErrorEvent.ERROR,Delegate.create(this,onError));
	}
	
	public function load(path:String):Void{
		startTime = getTimer();
		isMetaReady=false;
		flvURL = path;
		loader.load(path);
		safePlayToEnd = false;
	}

	private function onFLVLoad(e:LoaderEvent):Void{
		ns = NetStreamEvt(e.target);
		ns.onStatus = Delegate.create(this,onVideoStatus);
		dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.READY,this));
		clickDisable = false;
	}
	
	private function onProgress():Void{
		/*
		var downloadElapsedTime:Number = getTimer()-startTime;
		var downloadBitrate:Number = (ns.bytesLoaded/downloadElapsedTime);
		var flvBitrate:Number = ns.bytesTotal/(this.getDuration()*1000);
		var downloadExpectTime:Number = Math.ceil(ns.bytesTotal/downloadBitrate);
		var earliestStartTime:Number = (this.getDuration()*1000)-downloadExpectTime;
		*/
		if(safePlayToEnd==false){
			if(getSecondBeforeSafePlay()<=0)onEarliestStartTime();
		}
		if(!isNaN(getDuration())&&isMetaReady!=true){
			isMetaReady = true;
			dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.METADATA,this));
		}
		dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.PROGRESS,this));
	}

	private function onEarliestStartTime():Void{
		safePlayToEnd = true;
		if(autoPlay==true)this.play();
		dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.EARLIESTSTARTTIME,this));
	}

	public function getSecondBeforeSafePlay():Number{
		if(this.getBytesTotal()<=0||this.getBytesLoaded()<=0||getDuration()<=0)return 1000;

		var elapseSecond:Number = (getTimer()-startTime)/1000;
		var bps:Number = this.getBytesLoaded()/elapseSecond;
		var timeRequireToLoad:Number = this.getBytesTotal()/bps;
		var timeSafePlay:Number = timeRequireToLoad-getDuration()-elapseSecond;
		if(isNaN(timeSafePlay))timeSafePlay=0;
		return timeSafePlay;
	}

	public function play():Void{
		if(isPlaying==true)return;

		if(ns.bytesLoaded==0){
			dispatchEvent(new ErrorEvent(currentTarget,ErrorEvent.ERROR,this,'VideoPlayer play before data loaded'));
			return;
		}
		ns.pause(false);
		isPlay = true;
		dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.PLAY));
	}

	public function stop(sendEvent:Boolean):Void{
		if(isPlaying==false)return;
		
		ns.pause(true);
		isPlay = false;
		if(sendEvent==false)return;
		dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.STOP));
	}

	public function seek(time:Number):Void{
		var seekMax:Number =getDuration()-1; 
		if(time>seekMax)time = seekMax;
		ns.seek(time);
	}

	public function gotoAndPlay(time:Number):Void{
		ns.seek(time);
		play();
	}

	public function gotoAndStop(time:Number):Void{
		ns.seek(time);
		stop();
	}
	
	private function onEnterFrame():Void{
		if(isPlay){
			dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.PLAYING,this));
		}
	}
	
	private function onPress():Void{
		dispatchEvent(new MouseEvent(currentTarget,MouseEvent.MOUSE_DOWN,this));
	}

/*	private function onMouseDown(){
		if(clickDisable==true)return;

		if(_xmouse>0&&_xmouse<100&&_ymouse>0&&_ymouse<100){
			dispatchEvent(new EventButton(this,EventButton.EVENTPRESS));
		}
	}*/
	
	public function getBytesTotal():Number{
		return ns.bytesTotal;
	}
	
	public function getBytesLoaded():Number{
		return ns.bytesLoaded;
	}

	public function getDuration() : Number {
		var i:Number=0;
		for(i=0;i<ns.metaDataArray.length;i++){
			if(ns.metaDataArray[i].name=='duration'){
				return Number(ns.metaDataArray[i].value);
			}
		};
		return -1;
	}
	
	public function get _currentframe():Number{
		return ns.time;
	}

	public function get isPlaying():Boolean{
		return isPlay;
	}

	public function set _url(url:String):Void{
		//do nothing
	}

	public function get _url():String{
		return flvURL;
	}

	private function onError(e:ErrorEvent):Void{
		errorCode = e.text;
		dispatchEvent(new ErrorEvent(currentTarget,ErrorEvent.ERROR, this, e.text));
	}

	private function onVideoStatus() : Void {
		/*
		'NetStream.Buffer.Empty';
		// Data is not being received quickly enough to fill the buffer. Data flow will be interrupted until the buffer refills, at which time a NetStream.Buffer.Full message will be sent and the stream will begin playing again.
		'NetStream.Buffer.Full';
		//The buffer is full and the stream will begin playing.
		'NetStream.Buffer.Flush';
		// Data has finished streaming, and the remaining buffer will be emptied.
		'NetStream.Play.Start';
		// Playback has started.
		'NetStream.Play.Stop';
		// Playback has stopped.
		'NetStream.Play.StreamNotFound';
		// The FLV passed to the play() method can't be found.
		'NetStream.Seek.InvalidTime';
		// For video downloaded with progressive download, the user has tried to seek or play past the end of the video data that has downloaded thus far, or past the end of the video once the entire file has downloaded. The message.details property contains a time code that indicates the last valid position to which the user can seek.
		'NetStream.Seek.Notify';
		//' The seek operation is complete.*/
		if(safePlayToEnd==false){
			if(getSecondBeforeSafePlay()<=0)onEarliestStartTime();
		}
	}

	private var isOver:Boolean = false;
	private function onMouseMove():Void{
		if(_xmouse>0&&_xmouse<100&&_ymouse>0&&_ymouse<100&&isOver==false){
			isOver = true;
			dispatchEvent(new MouseEvent(currentTarget,MouseEvent.MOUSE_OVER,this));
		}
		
		if(!(_xmouse>0&&_xmouse<100&&_ymouse>0&&_ymouse<100)&&isOver==true){
			isOver = false;
			dispatchEvent(new MouseEvent(currentTarget,MouseEvent.MOUSE_OUT,this));
		}
	}
	
	public function getTargetContainer() : Object {
		return vid;
	}
}