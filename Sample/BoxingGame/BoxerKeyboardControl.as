
/**
 * @author colin
 */
import flash.ui.Keyboard;

import mx.utils.Delegate;

import com.mixmedia.mx.KeyEvt;
import com.mixmedia.mx.events.KeyboardEvent;

class BoxerKeyboardControl{
	private var k:KeyEvt;
	private var base:Boxer;

	public function BoxerKeyboardControl(base:Boxer){
		this.base = base;
		base.setCurrentTarget(this);
		k = new KeyEvt();
		k.addEventListener(KeyboardEvent.KEY_DOWN, Delegate.create(this,down));
	}
	
	private function down(e:KeyboardEvent):Void{
		if(e.keyCode==Keyboard.UP)   (e.shiftKey)?base.guard(Boxer.TOP)    : base.shot(Boxer.TOP);
		if(e.keyCode==Keyboard.LEFT) (e.shiftKey)?base.guard(Boxer.MID)    : base.shot(Boxer.MID);
		if(e.keyCode==Keyboard.DOWN) (e.shiftKey)?base.guard(Boxer.BOTTOM) : base.shot(Boxer.BOTTOM);
	}
	
	public function setBoxer(boxer : Boxer) : Void {
		base = boxer;
	}
}
