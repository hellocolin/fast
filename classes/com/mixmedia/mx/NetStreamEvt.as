import mx.events.EventDispatcher;
import mx.utils.Delegate;

import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.events.IOErrorEvent;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.ILoader;

/**
 * @author Colin
 */
class com.mixmedia.mx.NetStreamEvt extends NetStream implements IEventDispatcher{
	public var metaDataArray:Array;
	public var cuePointArray : Array;
	private var currentTarget : Object;
	
	private var nc:NetConnection;

	public function NetStreamEvt(connection:NetConnection){
		super(connection);
		//super.onCuePoint = Delegate.create(this,onCuePoint);
		EventDispatcher.initialize(this);
		nc = connection;
		currentTarget = this;
		metaDataArray = new Array();
		cuePointArray = new Array();
	};

//	public function attachAudio(theMicrophone:Microphone):Void{};
//	public function attachVideo(theCamera:Camera,snapshotMilliseconds:Number):Void{};
//	public function close():Void{};
//	public function pause(flag:Boolean):Void{};
//	public function play(name:Object, start:Number, len:Number, reset:Object):Void{};
//	public function publish(name:Object, type:String):Void{};
//	public function receiveAudio(flag:Boolean):Void{};
//	public function receiveVideo(flag:Object):Void{};
//	public function seek(offset:Number):Void{};
//	public function send(handlerName:String):Void{};
//	public function setBufferTime(bufferTime:Number){};
//	public function onResult(streamId:Number){};

	private var isOpen : Boolean=false;
	private var isComplete : Boolean=false;
	private var isReady : Boolean=false;
	private var iid:Number;

	private function checkStatus():Void{
		if(this.bytesTotal>0 && isOpen!=true){
			dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.OPEN,this,this));
			dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.READY,this,this));
			isOpen = true;
		}
		
		if(this.bytesLoaded>=this.bytesTotal && isComplete!=true && isOpen==true){
			dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.COMPLETE,this,this));
			isComplete = true;
			clearInterval(iid);
		}
		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.PROGRESS,this,this));
	}

	public function onStatus(infoObject:Object):Void{
		if(infoObject['code']=="NetStream.Play.StreamNotFound"){
			dispatchEvent(new IOErrorEvent(currentTarget,IOErrorEvent.IO_ERROR, this,"NetStream.Play.StreamNotFound"));
		}
	};

	private function onCuePoint(obj:Object):Void{
		cuePointArray[obj['time']] = {name:obj['name'],type:obj['type'],parameters:obj['parameters'],time:time};
	}
	
	private function onMetaData(obj:Object):Void{
		for(var name in obj){
			metaDataArray.push({name:name,value:obj[name]});	
		}
		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.OPEN,this,this));
	}

	public function getTargetContainer() : Object {
		return this;//prefer the video.. but no way to get it
	}

	public function load(requestURL : String) : Void {
		this.play(requestURL);
		isOpen = false;
		isComplete=false;
		isReady = false;
		clearInterval(iid);
		iid = setInterval(Delegate.create(this,checkStatus),250);
	}
	
	private function dispatchEvent(evt:Event):Void {};
	public function addEventListener(event : String, handler:Function) : Void {}
	public function removeEventListener(event : String, handler:Function) : Void {}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		this.currentTarget = ILoader(currentTarget);
	}
}