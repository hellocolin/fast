import com.mixmedia.mx.events.Event;

/**
 * @author Colin
 */
class com.mixmedia.mx.events.MouseEvent extends Event {
	public static var MOUSE_WHEEL : String='mouseWheel';
	public static var MOUSE_MOVE : String='mouseMove';
	public static var ROLL_OUT : String='rollOut';
	public static var MOUSE_OVER : String='mouseOver';
	public static var CLICK : String='click';
	public static var MOUSE_OUT : String='mouseOut';
	public static var MOUSE_UP : String='mouseUp';
	public static var DOUBLE_CLICK : String='doubleClick';
	public static var MOUSE_DOWN : String='mouseDown';
	public static var ROLL_OVER : String='rollOver';

	public function MouseEvent(currentTarget : Object, type : String,target:Object){
		super(currentTarget,type,target);
	}
}
