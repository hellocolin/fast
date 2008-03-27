import mx.utils.Delegate;

import com.mixmedia.mx.MovieClipLoaderEvt;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.ILoader;

/**
 * @author colin
 * responsible to create a proxy movieclip
 */
class com.mixmedia.net.LoadSWF implements ILoader {
	private var mcImageLoader:MovieClip;
	private var mcl:MovieClipLoaderEvt;

	private var autoStart:Boolean = true;

	public function LoadSWF(target:MovieClip,autoStart:Boolean){
		if(target==undefined)trace('com.mixmedia.net.LoadSWF require target movieclip');

		this.autoStart = (autoStart==null)?true:autoStart;
		mcImageLoader = target.createEmptyMovieClip("mcImageLoader",10);
		mcl = new MovieClipLoaderEvt();
		mcl.setCurrentTarget(this);
		mcl.addEventListener(LoaderEvent.READY, Delegate.create(this,onReady));
		mcl.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,onComplete));
	}
	
	public function load(requestURL:String):Void {
		mcImageLoader.unloadMovie();
		isComplete = false;
		mcl.loadClip(requestURL,mcImageLoader);
	}

	private var isComplete:Boolean = false;
	private function onComplete():Void{
		isComplete=true;
		if(autoStart)mcImageLoader.play();
	}

	private function onReady():Void{
		if(isComplete==true)return;
		mcImageLoader.stop();
	}

	public function getTargetContainer() : Object {
		return mcImageLoader;
	}

	public function addEventListener(event : String, handler:Function) : Void {
		mcl.addEventListener(event,handler);
	}

	public function removeEventListener(event : String, handler:Function) : Void {
		mcl.removeEventListener(event, handler);
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		mcl.setCurrentTarget(currentTarget);
	}
	
	public function unload() : Void {
		mcImageLoader.unloadMovie();
	}
}