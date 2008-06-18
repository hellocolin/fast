import mx.utils.Delegate;

import com.mixmedia.mx.AbstractMovieClipEventDispatcher;
import com.mixmedia.mx.NetStreamEvt;
import com.mixmedia.mx.events.ErrorEvent;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.net.LoadFLV;
import com.mixmedia.net.LoadSWF;
import com.mixmedia.utils.MovieClipTools;
import com.mixmedia.view.events.VideoPlayerEvent;
import com.mixmedia.view.net.Loader;

/**
 * @author Colin
 */
class com.mixmedia.view.net.VideoPlayer extends AbstractMovieClipEventDispatcher implements IEventDispatcher,ILoader{	
	private var isMetaReady : Boolean=false;
	private var startTime:Number=0;
	private var speedSlope:Number;

	private var vid:Video;
	private var base:Loader;
	private var ns:NetStreamEvt;

	private var isPlay : Boolean = false;
	private var flvURL : String;

	public var safePlayToEnd : Boolean = false;
	public var errorCode : String;
	public var clickDisable : Boolean = true;

	public var loop:Boolean = false;	
	public var autoPlay:Boolean = true;
	private var _autoScale:Boolean = true;

	private var defaultWidth:Number;
	private var defaultHeight:Number;
	private var flvWidth : Number;
	private var flvHeight : Number;

	private var mcPreloadImage:MovieClip;
	private var preloadImageLoader:Loader;

	public function VideoPlayer(){
		if(vid==null)trace('the video object in movieclip should name as "vid"');
		base = new Loader(new LoadFLV(vid,false,1,true,0),1);
		base.addEventListener(LoaderEvent.READY, Delegate.create(this,onFLVLoad));
		base.addEventListener(LoaderEvent.PROGRESS,Delegate.create(this,onProgress));
		base.addEventListener(ErrorEvent.ERROR,Delegate.create(this,onError));
		base.addEventListener(LoaderEvent.OPEN, Delegate.create(this,onStreamOpen));
		base.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this, onLoadComplete));
		defaultWidth =vid._width;
		defaultHeight=vid._height;
	}
	
	private function onUnload():Void{
		unload();
	}
	
	public function setPreloadImage(url:String):Void{
		mcPreloadImage = this.createEmptyMovieClip("mcPreloadImage",1);
		preloadImageLoader = new Loader(new LoadSWF(mcPreloadImage));
		preloadImageLoader.addEventListener(LoaderEvent.READY, Delegate.create(this, onPreloadImageLoaded));
		preloadImageLoader.load(url);
	}

	private function onPreloadImageLoaded():Void{
		MovieClipTools.alignCenter(mcPreloadImage,this);
	}

	private function onStreamOpen(e:LoaderEvent):Void{
		ns = NetStreamEvt(e.target);
		var metaDataArray:Array = ns.metaDataArray;
		for(var i:Number = 0;i<metaDataArray.length;i++){
			if(metaDataArray[i].name=="width")flvWidth=metaDataArray[i].value;
			if(metaDataArray[i].name=="height")flvHeight=metaDataArray[i].value;
		}
		scale();
	}

	public function load(path:String):Void{
		startTime = getTimer();
		isMetaReady=false;
		flvURL = path;
		base.load(path);
		safePlayToEnd = false;
		isPlay = false;
	}

	private function onFLVLoad(e:LoaderEvent):Void{
		ns = NetStreamEvt(e.target);
		ns.onStatus = Delegate.create(this,onVideoStatus);
		dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.READY,this));
		if(autoPlay==true)play();
		clickDisable = false;
	}

	private function onLoadComplete() : Void {
		dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.COMPLETE,this));
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
		if(isPlay==true)return;
		if(mcPreloadImage._visible == true){
			mcPreloadImage._visible = false;
		}
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
		removeReplayInterval();

		ns.pause(true);
		isPlay = false;
		if(sendEvent==false)return;
		dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.STOP));
		
		if(loop==true)gotoAndPlay(0);
	}

	public function seek(time:Number):Void{
		var seekMax:Number =getDuration()-1; 
		if(time>seekMax)time = seekMax;
		ns.seek(time);
	}

	public function gotoAndPlay(time:Number):Void{
		isPlay = false;
		if(time==0){
			removeReplayInterval();
		}
		ns.seek(time);
		play();
	}

	public function gotoAndStop(time:Number):Void{
		ns.seek(time);
		stop();
	}
	
	private var prevFrameTime:Number=0;
	private var iid:Number;
	
	private function onEnterFrame():Void{
		if(isPlay){
			dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.PLAYING,this));

			if(_currentframe==prevFrameTime){
				if(iid==null)iid = setInterval(Delegate.create(this, playEnd),1000);
			}else{
				removeReplayInterval();
			}

			prevFrameTime = ns.time;

			if(_currentframe>=getDuration()){
				playEnd();
			}
		}
	}
	
	private function playEnd():Void{
		removeReplayInterval();
		stop();
		dispatchEvent(new VideoPlayerEvent(currentTarget,VideoPlayerEvent.PLAYEND, this));	
	}
	
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

	private function removeReplayInterval():Void{
		clearInterval(iid);
		iid=null;
	}

	public function get autoScale():Boolean{
		return _autoScale;
	}

	public function set autoScale(value:Boolean):Void{
		_autoScale = value;
		scale();
	}

	private function scale():Void{
		vid._width = (_autoScale)?defaultWidth:flvWidth;
		vid._height = (_autoScale)?defaultHeight:flvHeight;
		vid._x = (_autoScale)?0 : (defaultWidth -flvWidth )/ 2;
		vid._y = (_autoScale)?0 : (defaultHeight-flvHeight)/ 2;	
	}

	public function unload() : Void {
		base.unload();
	}
}
