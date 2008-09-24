import mx.utils.Delegate;

import com.asual.swfaddress.SWFAddress;
import com.asual.swfaddress.SWFAddressEvent;
import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;
import com.mixmedia.navigation.Navigation;
import com.mixmedia.navigation.NavigationEvent;

/** * @author colin
 * 
 * combine function of SWFAddress and com.mixmedia.navigation
 * more information on SWFAddress:
 * http://www.asual.com/swfaddress/
 * 
 * 
 * To use this class, 
 * 1. copy swfaddress.html and swfaddress.js to the script folder
 * 2. link the script to index.html
 * for more information, please check http://demo.mixmedia.com/swfAddress/adobe/
 * 
 */class com.mixmedia.navigation.DeepLinking extends AbstractEventDispatcher {
	static private var ins:DeepLinking;
	private var iid : Number;

	static public function instance():DeepLinking{
		if(ins==null)ins = new DeepLinking();
		return ins;
	}

	private var isNavChange:Boolean = false;

	private function DeepLinking() {
		Navigation.instance().addEventListener(NavigationEvent.CHANGE, Delegate.create(this,setSWFAddressValue));
		SWFAddress.addEventListener(SWFAddressEvent.CHANGE,            Delegate.create(this,onBaseChange));
	}
	
	private function setSWFAddressValue(e:NavigationEvent):Void{
		if(e.isSuppress==true)return;
		isNavChange = true;

		//string of target container representation
		var str:String = (e.targetContainer==""||e.targetContainer==null)?"" : "." + e.targetContainer;
		SWFAddress.setValue(e.navKey+str);
	}

	private function onBaseChange():Void{
		clearInterval(iid);
		iid = setInterval(Delegate.create(this, delayDispatchBaseChange),5);
	}
	
	private function delayDispatchBaseChange():Void{
		clearInterval(iid);
		if(isNavChange == true){
			isNavChange = false;
			return;
		}
		dispatchEvent(new Event(currentTarget, Event.CHANGE, SWFAddress));
	}

	public function getBaseURL():String{
		return SWFAddress.getBaseURL();
	}

	public function back():Void {
		SWFAddress.back();
    }

    public function forward():Void {
    	SWFAddress.forward();
    }
    
    public function go(delta:Number):Void {
		SWFAddress.go(delta);
    }

    public function href(url:String, target:String):Void {
    	SWFAddress.href(url,target);
    }

    public function popup(url:String, name:String, options:String, handler:String):Void {
    	SWFAddress.popup(url, name, options, handler);
	}

	public function getValue() : String {
		return SWFAddress.getValue();
	}
}
