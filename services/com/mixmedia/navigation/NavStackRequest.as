
/**
 * @author colin
 */
class com.mixmedia.navigation.NavStackRequest {
	public var navKey:String;
	public var targetContainer:String;
	public var isSuppress:Boolean;

	public function NavStackRequest(navKey:String,targetContainer:String,isSuppress:Boolean){
		this.navKey=navKey;
		this.targetContainer=targetContainer;
		this.isSuppress=isSuppress;
	}

	public function toString():String{
		return '[object NavStackRequest]:'+[navKey,targetContainer,isSuppress];
	}
}