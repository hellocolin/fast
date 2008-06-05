
/**
 * @author colin
 */
class com.mixmedia.navigation.NavStackRequest {
	//generate by scaffold
	private var _navKey:String;
	private var _targetContainer:String;
	private var _isSuppress:Boolean;

	public function NavStackRequest(navKey:String,targetContainer:String,isSuppress:Boolean){
		_navKey=navKey;
		_targetContainer=targetContainer;
		_isSuppress=isSuppress;
	}
	public function set navKey(navKey:String):Void{
		_navKey=navKey;
	}
	public function get navKey():String{
		return _navKey;
	}
	public function set targetContainer(targetContainer:String):Void{
		_targetContainer=targetContainer;
	}
	public function get targetContainer():String{
		return _targetContainer;
	}
	public function set isSuppress(isSuppress:Boolean):Void{
		_isSuppress=isSuppress;
	}
	public function get isSuppress():Boolean{
		return _isSuppress;
	}
//end scaffold
}