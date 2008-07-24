import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.navigation.NavStackRequest;
import com.mixmedia.navigation.NavigationEvent;

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

	private var navKey : String="";
	public var history:Array;

	private function Navigation(){
		reset();
	}

	public function changeSection(navKey:String,targetContainer:String,isSuppress:Boolean,eventDispatcher:Object):Void{
		isSuppress = (isSuppress==null)?false:isSuppress;
		eventDispatcher = (eventDispatcher==null)?this:eventDispatcher;

		this.navKey = navKey;
		history.push(navKey);

		dispatchEvent(new NavigationEvent(currentTarget,NavigationEvent.CHANGE,this,navKey,targetContainer,isSuppress,eventDispatcher));
	}
	
	public function back():Void{
		history.pop();
		changeSection(String(history.pop()));
	}
	
	public function getCurrentNavKey() : String {
		return (navStackRequests==null)?navKey:NavStackRequest(navStackRequests[navStackRequests.length-1]).navKey;
	}
	
	public function reset():Void{
		clearNavStackRequests();
		history = [];
		navKey = "";
	}

	private var navStackRequests:Array;	
	public function clearNavStackRequests() : Void {
		navStackRequests = null;
	}
	
	public function changeSections(navStackRequests:Array):Void{
		this.navStackRequests = navStackRequests;
		nextSection();
	}
	
	public function getNavStackRequests():Array{
		return navStackRequests;
	}
	
	public function nextSection() : Void {
		if(navStackRequests.length<=0){
			navStackRequests=null;
			return;
		}
		var req:NavStackRequest = NavStackRequest(navStackRequests.shift());
		changeSection(req.navKey,req.targetContainer,req.isSuppress);
	}
}