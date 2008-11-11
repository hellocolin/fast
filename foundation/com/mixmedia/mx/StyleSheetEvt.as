import mx.events.EventDispatcher;
import mx.utils.Delegate;

import com.mixmedia.mx.events.ErrorEvent;
import com.mixmedia.mx.events.Event;

import TextField.StyleSheet;

/**
 * @author colin
 */
class com.mixmedia.mx.StyleSheetEvt extends StyleSheet implements IEventDispatcher,IFASTEventDispatcher {
	private var currentTarget : Object;
	private var base : StyleSheet;

	public function StyleSheetEvt(){
		EventDispatcher.initialize(this);
		base = new StyleSheet();
		base.onLoad = Delegate.create(this,onLoad);
	}
	
	public function getStyle(name : String) : Object{
		return base.getStyle(name);
	};
	public function setStyle(name : String,style : Object) : Void{
		base.setStyle(name, style);
	}
	public function clear() : Void{
		base.clear();
	}
	public function getStyleNames() : Array{
		return base.getStyleNames();
	}
	public function transform(style : Object) : TextFormat{
		return base.transform(style);
	}
	public function parseCSS(cssText : String) : Boolean{
		return base.parseCSS(cssText);
	}

	public function load(url : String) : Boolean{
		return base.load(url);
	}
	private function onLoad(success : Boolean) : Void{
		if(success==true){
			dispatchEvent(new Event(currentTarget, Event.COMPLETE, base));
		}else{
			dispatchEvent(new ErrorEvent(currentTarget,ErrorEvent.ERROR,this,'stylesheet file not loaded'));
		}
	}

	private function dispatchEvent(evt:Event):Void {};
	public function addEventListener(event : String, handler:Function) : Void {}
	public function removeEventListener(event : String, handler:Function) : Void {}
	public function setCurrentTarget(currentTarget : Object) : Void {
		this.currentTarget = currentTarget;
	}
	public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {
		addEventListener(eventType,Delegate.create(whichObject,callFunction));
	}
	
	public function getBase() : Object {
		return base;
	}
}
