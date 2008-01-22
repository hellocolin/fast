import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IEventDispatcher;

/**
 * @author Colin
 */
class com.mixmedia.js.ExternalBrowserBlurFocus extends AbstractEventDispatcher implements IEventDispatcher {
	public function ExternalBrowserBlurFocus(){
		//Object.watch need inline function.?????
		var ins:ExternalBrowserBlurFocus = this;
		var watcher:Function=function(prop:String, oldVal:Object, newVal:Object):Object{
			oldVal=null;
			if(prop=="onBlur")ins.blur();
			if(prop=="onFocus")ins.focus();
			return newVal;
		};

		_root.watch("onBlur",watcher);
		_root.watch("onFocus",watcher);
	}

	public function blur():Void{
		dispatchEvent(new Event(currentTarget, Event.CHANGE,this));
	}

	public function focus():Void{
		dispatchEvent(new Event(currentTarget,Event.CHANGE,this));
	}
}