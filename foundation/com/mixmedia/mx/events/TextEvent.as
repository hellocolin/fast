import com.mixmedia.mx.events.Event;

/**
 * @author Colin
 */
class com.mixmedia.mx.events.TextEvent extends Event {
	public static var LINK:String = "link";
	public static var TEXT_INPUT:String = "textInput";
	public var text:String="";
	
	public function TextEvent(currentTarget : Object, type : String,target:Object,text:String) {
		super(currentTarget,type,target);
		this.text = text;
	}
}
