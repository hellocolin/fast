import com.mixmedia.mx.events.Event;
import com.mixmedia.navigation.Navigation;

/**
 * @author Colin
 */
class com.mixmedia.navigation.NavigationEvent extends Event {
	public var navKey:String;
	public var targetContainer:String;
	public var isSuppress:Boolean;
	
	public function NavigationEvent(currentTarget : Object, type : String, target:Navigation, navKey:String,targetContainer:String,isSuppress:Boolean){
		super(currentTarget,type,target);

		this.isSuppress = isSuppress;
		this.navKey = navKey;
		this.targetContainer = targetContainer;
	}
}
