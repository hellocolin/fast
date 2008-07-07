import mx.utils.Delegate;

import com.asual.swfaddress.SWFAddress;
import com.asual.swfaddress.SWFAddressEvent;
import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;

/** * @author colin */class com.mixmedia.navigation.DeepLinking extends AbstractEventDispatcher {
	static private var ins:DeepLinking;
	static public function instance():DeepLinking{
		if(ins==null)ins = new DeepLinking();
		return ins;
	}
	private function DeepLinking() {		SWFAddress.addEventListener(SWFAddressEvent.CHANGE, Delegate.create(this,onBaseChange));	}
	
	private function onBaseChange():Void{
		dispatchEvent(new Event(currentTarget, Event.CHANGE,SWFAddress));
	}

	public static function back():Void {
		SWFAddress.back();
    }

    public static function forward():Void {
    	SWFAddress.forward();
    }
    
    public static function go(delta:Number):Void {
		SWFAddress.go(delta);
    }

    public static function href(url:String, target:String):Void {
    	SWFAddress.href(url,target);
    }

    public static function popup(url:String, name:String, options:String, handler:String):Void {
    	SWFAddress.popup(url, name, options, handler);
	}	
}