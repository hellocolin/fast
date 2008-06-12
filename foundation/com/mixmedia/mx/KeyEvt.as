
/**
 * @author colin
 */
import flash.ui.Keyboard;

import mx.events.EventDispatcher;
import mx.utils.Delegate;

import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.KeyboardEvent;

class com.mixmedia.mx.KeyEvt extends Key implements IEventDispatcher,IFASTEventDispatcher{
	private var currentTarget : Object;

	private var keyEvt:Object;
	private var pressedKeys:Array;
	private var lastPressArray:Array;
	private var iid:Number;

	public function KeyEvt(){
		pressedKeys = new Array();
		Key.addListener(this);
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

	private function checkKeyUp():Boolean{
		var i:Number;
		if(pressedKeys.length ==0)clearInterval(iid);
		for(i=0;i<pressedKeys.length;i++){
			if(Key.isDown(pressedKeys[i])!=true){
				onKeyUp();
				return true;
			}
		}
		return false;
	}

	private function onKeyDown():Void{
		if(checkKeyUp())return;//fix flash8 on key up bug.
		clearInterval(iid);
		var latestKey:Number = Key.getCode();
		if(latestKey!=pressedKeys[pressedKeys.length-1]){
			pressedKeys.push(latestKey);
			dispatchEvent(new KeyboardEvent(currentTarget, KeyboardEvent.KEY_DOWN,   this,Key.getAscii(),Key.getCode(),null,Key.isDown(Keyboard.CONTROL),null,Key.isDown(Keyboard.SHIFT),pressedKeys));
			dispatchEvent(new KeyboardEvent(currentTarget, KeyboardEvent.CHANGE,   this,Key.getAscii(),Key.getCode(),null,Key.isDown(Keyboard.CONTROL),null,Key.isDown(Keyboard.SHIFT),pressedKeys));
		}
		iid = setInterval(this,'checkKeyUp',250);
	}

	private function onKeyUp():Void{
		var i:Number;
		for(i=0;i<pressedKeys.length;i++){
			if(Key.isDown(pressedKeys[i])!=true){
				pressedKeys.splice(i,1);
				i--;
			}
		}
		dispatchEvent(new KeyboardEvent(currentTarget, KeyboardEvent.KEY_UP, this,Key.getAscii(),Key.getCode(),null,Key.isDown(Keyboard.CONTROL),null,Key.isDown(Keyboard.SHIFT),pressedKeys));
		dispatchEvent(new KeyboardEvent(currentTarget, KeyboardEvent.CHANGE,   this,Key.getAscii(),Key.getCode(),null,Key.isDown(Keyboard.CONTROL),null,Key.isDown(Keyboard.SHIFT),pressedKeys));
	}
}