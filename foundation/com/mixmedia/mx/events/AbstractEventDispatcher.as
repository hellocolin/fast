﻿import mx.events.EventDispatcher;import mx.utils.Delegate;import com.mixmedia.mx.events.Event;/**
 * @author colin
 */
class com.mixmedia.mx.events.AbstractEventDispatcher implements IEventDispatcher,IFASTEventDispatcher{
	private var currentTarget:Object;

	public function AbstractEventDispatcher(){
		EventDispatcher.initialize(this);
		currentTarget = this;
	}

	public function setCurrentTarget(currentTarget : Object) : Void {
		this.currentTarget = currentTarget;
	}

	public function addEventListener(event:String, handler:Function):Void{}
	private function dispatchEvent(eventObj:Event):Void{}
	public function removeEventListener(event:String, handler:Function) : Void {	}		public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {		removeEventListener(eventType,Delegate.create(whichObject,callFunction));		addEventListener(eventType,Delegate.create(whichObject,callFunction));	}
}