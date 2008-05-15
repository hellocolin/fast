import mx.events.EventDispatcher;import mx.utils.Delegate;import com.mixmedia.mx.events.Event;import com.mixmedia.mx.events.IEventDispatcher;import com.mixmedia.mx.events.IFASTEventDispatcher;import com.mixmedia.mx.events.IOErrorEvent;import com.mixmedia.mx.events.LoaderEvent;import com.mixmedia.net.ILoader;/**
 * @author colin
 */
class com.mixmedia.mx.MovieClipLoaderEvt extends MovieClipLoader implements IEventDispatcher,IFASTEventDispatcher{
	private var target : Object;
	private var currentTarget : Object;
	private var isInit:Boolean = false;

	public function MovieClipLoaderEvt(){
		super();
		this.addListener(this);
		EventDispatcher.initialize(this);
		currentTarget = this;
	};

	public function loadClip(url:String, target:Object):Boolean{
		this.target = target;
		isInit = false;
		return super.loadClip(url,target);
	}

	public function getTargetContainer() : Object {
		return target;
	}

	public function load(requestURL : String) : Void {
		loadClip(requestURL,this.target);
	}

	private function onLoadComplete(target_mc:MovieClip):Void{
		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.COMPLETE, this, target_mc));
	}
	
	private function onLoadProgress(target_mc:MovieClip):Void{
		if(isInit==false && target_mc._currentframe>0){
			dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.READY, this, target_mc));
			isInit=true;
		}
		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.PROGRESS, this, target_mc));
	}

	private function onLoadInit(target_mc:MovieClip):Void{
		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.READY   , this, target_mc));
	}
	
	private function onLoadStart(target_mc:MovieClip):Void{
		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.OPEN    , this, target_mc));
	}

	private function onLoadError(target_mc:MovieClip,errorCode:String):Void{
		target_mc = null;
		dispatchEvent(new IOErrorEvent(currentTarget,IOErrorEvent.IO_ERROR, this,errorCode));
	}

	private function dispatchEvent(evt:Event):Void {};
	public function addEventListener(event : String, handler:Function) : Void {}
	public function removeEventListener(event : String, handler:Function) : Void {
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		this.currentTarget = ILoader(currentTarget);
	}		public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {		addEventListener(eventType,Delegate.create(whichObject,callFunction));	}
}