﻿import mx.events.EventDispatcher;
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
	public function removeEventListener(event:String, handler:Function) : Void {
}