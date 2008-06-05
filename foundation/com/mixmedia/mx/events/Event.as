/**
 * @author colin
 */
class com.mixmedia.mx.events.Event {
	public var target:Object;//untype
	public var currentTarget:Object;
	public var type:String;

	public static var PROGRESS:String = "onProgress";
	public static var START:String = "onStart";
	public static var LOG:String = "onLog";

	public static var READY : String = "onReady";
	public static var STOP : String = "onStop";

	public static var TWEENSTART:String = "onTweenStart";
	public static var TWEENING:String = "onTween";
	public static var TWEENEND :String ="onTweenEnd";

	public static var PLAY : String = "onPlay";

	public static var MIN : String = "onMin";
	public static var MAX : String = "onMax";

	public static var ENTER_FRAME : String="enterFrame";
	public static var ID3 : String="id3";
	public static var SOUND_COMPLETE : String="soundComplete";
	public static var INIT : String = "init";
	public static var RENDER : String="render";
	public static var TAB_ENABLED_CHANGE : String="tabEnabledChange";
	public static var ADDED_TO_STAGE : String="addedToStage";
	public static var TAB_CHILDREN_CHANGE : String="tabChildrenChange";
	public static var RESIZE : String="resize";
	public static var CHANGE : String="change";
	public static var COMPLETE : String="complete";

	public static var REMOVED : String="removed";
	public static var CONNECT : String="connect";
	public static var SCROLL : String="scroll";
	public static var OPEN : String="open";
	public static var CLOSE : String="close";
	public static var MOUSE_LEAVE : String="mouseLeave";
	public static var ADDED : String="added";
	public static var TAB_INDEX_CHANGE : String="tabIndexChange";
	public static var REMOVED_FROM_STAGE : String="removedFromStage";
	public static var ACTIVATE : String="activate";
	public static var DEACTIVATE : String="deactivate";
	public static var CANCEL : String="cancel";
	public static var SELECT : String="select";
	public static var UNLOAD : String="unload";

	public function Event(currentTarget:Object,type:String,target:Object){
		this.target = (target==null)?currentTarget:target;
		this.currentTarget = currentTarget;
		this.type = type;
	}
	
	public function clone() : Event{
		return null;
	};

	public function toString() : String{
		return "Event Object";
	};
}