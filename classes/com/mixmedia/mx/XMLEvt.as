import mx.events.EventDispatcher;
import mx.utils.Delegate;

import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.events.IOErrorEvent;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.ILoader;

/**
 * @author Colin
 * 
 */

 class com.mixmedia.mx.XMLEvt extends XML implements IEventDispatcher,ILoader{
	private var iid:Number;
	private var isOpen:Boolean = false;
	private var isComplete:Boolean = false;
	private var currentTarget : ILoader;

	public function XMLEvt(){
		EventDispatcher.initialize(this);
		ignoreWhite = true;

		currentTarget = this;
	};
	
	public function load(url:String):Void{
		super.load(url);
		clearInterval(iid);
		iid = setInterval(Delegate.create(this,checkStatus),250);
	}

	private function checkStatus():Void{
		var targetObj:Object = this;
		if(this.getBytesTotal()>0 && isOpen!=true){
			dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.OPEN,this,targetObj));
			isOpen = true;
		}

		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.PROGRESS,this, targetObj));
	}

	private function onLoad(success:Boolean):Void{
		super.onLoad(success);
		if(success==true){
			dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.READY, this, this));			
		}else{
			dispatchEvent(new IOErrorEvent(currentTarget,IOErrorEvent.IO_ERROR,this,String(this.status)));
		};
	}

	private function onData(src:String):Void{
		super.onData(src);
		clearInterval(iid);
		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.COMPLETE, this,src));
	}

	public function getTarget() : Object {
		return this;
	}

	public function addEventListener(event:String, handler:Function):Void{}
	private function dispatchEvent(eventObj:Event):Void{}
	public function removeEventListener(event:String, handler:Function) : Void {}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		this.currentTarget = ILoader(currentTarget);
	}
}