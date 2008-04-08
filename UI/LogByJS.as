import mx.utils.Delegate;

import com.mixmedia.mx.events.Event;
import com.mixmedia.navigation.Navigation;
import com.mixmedia.navigation.events.NavigationEvent;
import com.mixmedia.net.LoadVAR;

/**
 * @author Colin
 */
class LogByJS {
	private var lv:LoadVAR;
	private var url:String;

	public function LogByJS(){
		Navigation.instance().addEventListener(NavigationEvent.CHANGE, Delegate.create(this,log));
	}

	private function log(e:NavigationEvent):Void{
		if(e.isSuppress==true)return;
		getURL('javascript:log(' + e.navKey + ');');
	}
}
