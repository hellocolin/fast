import mx.events.EventDispatcher;

import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.events.IOErrorEvent;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.ILoader;

/**
 * @author Colin
 */
class com.mixmedia.mx.LoadVarsEvt extends LoadVars implements IEventDispatcher,ILoader {
	private var iid:Number;
	private var currentTarget:Object;
	
	public function LoadVarsEvt() {
		super();
		EventDispatcher.initialize(this);
		currentTarget = this;
	}
	
	public function load(requestURL : String) : Void{
		super.load(requestURL);
	}

	private function onLoad(success:Boolean):Void{
		super.onLoad(success);
		if(success==true){
			dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.READY, this, this));			
		}else{
			dispatchEvent(new IOErrorEvent(currentTarget,IOErrorEvent.IO_ERROR,this,String("LoadVarsEvt Error")));
		};
	}

	private function onData(src:String):Void{
		super.onData(src);
		clearInterval(iid);
		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.COMPLETE, this,src));
	}

	public function getTargetContainer() : Object {
		return this;
	}

	public function addEventListener(event:String, handler:Function):Void{}
	private function dispatchEvent(eventObj:Event):Void{}
	public function removeEventListener(event:String, handler:Function) : Void {}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		this.currentTarget = ILoader(currentTarget);
	}
}
