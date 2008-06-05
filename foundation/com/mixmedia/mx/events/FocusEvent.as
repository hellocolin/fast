import com.mixmedia.mx.events.Event;

/**
 * @author Colin
 */
class com.mixmedia.mx.events.FocusEvent extends Event {
	public var shiftKey:Boolean;
	public var relatedObject:Object;
	public var keyCode:Number;

	public static var MOUSE_FOCUS_CHANGE : String="mouseFocusChange";
	public static var FOCUS_OUT : String="focusOut";
	public static var KEY_FOCUS_CHANGE : String="keyFocusChange";
	public static var FOCUS_IN : String="focusIn";
		
	public function FocusEvent(currentTarget : Object, type : String, target : Object,relatedObject:Object, shiftKey : Boolean, keyCode : Number) {
		super(currentTarget, type, target);

		this.relatedObject = relatedObject;
		this.shiftKey = (shiftKey==null)?false:shiftKey;
		this.keyCode  = (keyCode==null) ?0:keyCode;
	}
}
