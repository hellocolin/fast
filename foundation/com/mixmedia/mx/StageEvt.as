
/**
 * @author colin
 */
import mx.events.EventDispatcher;
import mx.utils.Delegate;

import com.mixmedia.mx.events.Event;

class com.mixmedia.mx.StageEvt implements IEventDispatcher, IFASTEventDispatcher {
	static private var ins:StageEvt;
	static public function instance():StageEvt{
		if(ins==null)ins = new StageEvt();
		return ins;
	}

	private var base:Stage;
	private var currentTarget : Object;

	private function StageEvt(){
		Stage.addListener(this);
		EventDispatcher.initialize(this);
		currentTarget = this;
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

	private function onResize():Void{
		dispatchEvent(new Event(currentTarget, Event.RESIZE, this));
	}
}
