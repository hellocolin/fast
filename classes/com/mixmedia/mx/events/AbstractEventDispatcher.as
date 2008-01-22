﻿import mx.events.EventDispatcher;

import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IEventDispatcher;

/**
 * @author colin
 */
class com.mixmedia.mx.events.AbstractEventDispatcher implements IEventDispatcher{
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
	public function removeEventListener(event:String, handler:Function):Void{}
}