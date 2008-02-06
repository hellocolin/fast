import mx.utils.Delegate;

import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IOErrorEvent;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.ILoader;
import com.mixmedia.utils.BindMovieClip;
import com.mixmedia.utils.Queue;

/**
 * @author colin
 * provide the following service
 * 1. loading Queue
 * 2. error icon
 * 3. preload icon
 * 
 * in default, error icon and preloader icon attach to _root
 */
class com.mixmedia.net.Loader extends AbstractEventDispatcher implements ILoader{
	private var base : ILoader;

	private var delLoad : Function;
	private var request : String;
	private var preloaderParent : MovieClip; 
	private var preloaderID : String;

	private var errorIconParent : MovieClip;
	private var errorIconID : String;
	
	private var queue:Queue;

	public function Loader(base:ILoader,queueThreadId:Number){
		currentTarget = this;

		preloaderParent = _root;
		errorIconParent = preloaderParent;

		queue = Queue.instance(queueThreadId);

		delLoad = Delegate.create(this,doLoad);
		this.base = base;
		base.setCurrentTarget(this);
		base.addEventListener(LoaderEvent.COMPLETE,Delegate.create(this,forwardEvent));
		base.addEventListener(LoaderEvent.OPEN,Delegate.create(this,forwardEvent));
		base.addEventListener(LoaderEvent.PROGRESS,Delegate.create(this,forwardEvent));
		base.addEventListener(LoaderEvent.READY,Delegate.create(this,forwardEvent));
		base.addEventListener(IOErrorEvent.IO_ERROR, Delegate.create(this,forwardEvent));

		base.addEventListener(IOErrorEvent.IO_ERROR,Delegate.create(this,onError));
		base.addEventListener(Event.COMPLETE,Delegate.create(this,onLoadComplete));
	}

	public function load(request:String):Void{
		this.request = request;
		queue.addRequest(delLoad);
	}

	public function getTargetContainer():Object{
		return base.getTargetContainer();
	}

	private function doLoad():Void{
		makePreloader();
		base.load(request);
	}

	private function forwardEvent(evt:Event):Void{
		dispatchEvent(evt);
	}

	private function makePreloader():Void{
		BindMovieClip.make(BindMovieClip.PROGRESS, preloaderParent, preloaderID, {target:getTargetContainer()});
	}

	private function killPreloader():Void{
		BindMovieClip.remove(BindMovieClip.PROGRESS, preloaderParent);
	}
	
	public function setPreloader(preloaderParent:MovieClip,symbolIdentifier:String):Void{
		this.preloaderParent = preloaderParent;
		this.preloaderID = (symbolIdentifier==null)?preloaderID:symbolIdentifier;
	}
	
	public function setErrorIcon(errorIconParent:MovieClip,symbolIdentifier:String):Void{
		this.errorIconParent = errorIconParent;
		this.errorIconID = (symbolIdentifier==null)?errorIconID:symbolIdentifier;
	}

	private function onLoadComplete() : Void {
		queue.next();
		killPreloader();
	}

	private function onError():Void{
		queue.next();
		BindMovieClip.make(BindMovieClip.ERROR,errorIconParent,errorIconID);
		killPreloader();
	}
	
	public function unload() : Void {
		base.unload();
	}
}