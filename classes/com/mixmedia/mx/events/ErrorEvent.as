import com.mixmedia.mx.events.TextEvent;

/**
 * @author Colin
 */
class com.mixmedia.mx.events.ErrorEvent extends TextEvent {
	public static var ERROR:String = "error";
	
	public function ErrorEvent(currentTarget : Object, type : String, target : Object, text : String) {
		super(currentTarget,type,target,text);
	}
}
