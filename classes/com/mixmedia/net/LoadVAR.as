import mx.utils.Delegate;

import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.events.IOErrorEvent;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.ILoader;

/**
 * @author Colin
 */
class com.mixmedia.net.LoadVAR extends AbstractEventDispatcher implements IEventDispatcher,ILoader {
	private var iid:Number;
	private var currentTarget: Object;
	private var isOpen : Boolean;
	private var data:String;
	
	private var base:LoadVars;

	public function LoadVAR() {
		base = new LoadVars();
		base.onData = Delegate.create(this, onData);
		base.onLoad = Delegate.create(this, onLoad);
		base.toString = Delegate.create(this, toString);
	}
	
	public function load(requestURL : String) : Void{
		clearInterval(iid);
		iid = setInterval(Delegate.create(this,checkStatus),250);
		base.load(requestURL);
	}

	private function checkStatus():Void{
		var targetObj:Object = this;
		if(base.getBytesTotal()>0 && isOpen!=true){
			dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.OPEN,base,targetObj));
			isOpen = true;
		}
		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.PROGRESS,base,targetObj));
	}

	private function onLoad(success:Boolean):Void{
		if(success==true){
			dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.READY, base, this));			
		}else{
			dispatchEvent(new IOErrorEvent(currentTarget,IOErrorEvent.IO_ERROR,base,"LoadVarsEvt Error"));
		};
	}

	private function onData(src:String):Void{
		this.data = src;
		clearInterval(iid);
		dispatchEvent(new LoaderEvent(currentTarget,LoaderEvent.COMPLETE, base,this));
	}

	public function getTargetContainer() : Object {
		return this;
	}

	public function addRequestHeader(header : Object, headerValue : String) : Void{
		base.addRequestHeader(header, headerValue);
	};

	public function send(url : String,target : String,method : String) : Boolean{
		return base.send(url, target, method);
	};
	
	public function sendAndLoad(url : String,target:Object,method : String) : Boolean{
		if(target instanceof LoadVAR)target = LoadVAR(target).getBase();
		return base.sendAndLoad(url, target, method);
	};
	
	public function getBase():LoadVars{
		return base;
	}

	public function getBytesLoaded() : Number{
		return base.getBytesLoaded();
	};

	public function getBytesTotal() : Number{
		return base.getBytesTotal();
	};

	public function decode(queryString : String) : Void{
		base.decode(queryString);
		data = base.toString();
	};

	public function toString() : String{
		return data;
	};
	
	public function set contentType(str:String):Void{
		base.contentType = str;
	}
	
	public function get contentType():String{
		return base.contentType;
	}
	
	public function get loaded():Boolean{
		return base.loaded;
	}
	
	public function unload() : Void {}
}
