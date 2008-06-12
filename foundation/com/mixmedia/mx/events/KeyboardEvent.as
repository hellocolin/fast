import com.mixmedia.mx.events.Event;
/**
 * @author Colin
 */
class com.mixmedia.mx.events.KeyboardEvent extends Event {
	public static var KEY_DOWN:String = "keyDown";
	public static var KEY_UP:String   = "keyUp";

	public var altKey : Boolean;	
	public var charCode : Number;
	public var ctrlKey : Boolean;
	public var keyCode : Number;
	public var keyLocation : Number;
	public var shiftKey : Boolean;

	public var pressedKeys:Array;

	public function KeyboardEvent(currentTarget : Object, type:String,target:Object,
		charCode:Number,
		keyCode:Number,
		keyLocation:Number,
		ctrlKey:Boolean,
		altKey:Boolean,
		shiftKey:Boolean,
		pressedKeys:Array
		){

		super(currentTarget,type,target);
		
		this.charCode    = charCode==null?   0:charCode;
		this.keyCode     = keyCode==null?    0:keyCode;
		this.keyLocation = keyLocation==null?0:keyLocation;
		this.ctrlKey     = ctrlKey==null?    false:ctrlKey;
		this.altKey      = altKey==null?     false:altKey;
		this.shiftKey    = shiftKey==null?   false:shiftKey;
		this.pressedKeys = pressedKeys;
	}
}