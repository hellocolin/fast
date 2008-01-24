import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.navigation.events.NavigationEvent;

/**
 * @author colin
 */
 //: Singleton
 //: dispatch event

class com.mixmedia.navigation.Navigation extends AbstractEventDispatcher{
	static private var ins:Navigation;
	static public function instance():Navigation{
		if(ins==null)ins = new Navigation();
		return ins;
	}

	private var navKey : String;
	public var history:Array;

	private function Navigation(){
		history = new Array();
	}

	public function changeSection(navKey:String,targetContainer:String,isSuppress:Boolean,eventDispatcher:Object):Void{
		isSuppress = (isSuppress==null)?false:isSuppress;
		eventDispatcher = (eventDispatcher==null)?this:eventDispatcher;

		this.navKey = navKey;
		history.push(navKey);
		
		dispatchEvent(new NavigationEvent(currentTarget,NavigationEvent.CHANGE,this,navKey,targetContainer,isSuppress,eventDispatcher));
	}

	public function back():Void{
		changeSection(String(history.pop()));
	}
	
	public function getCurrentNavKey() : String {
		return navKey;
	}
}