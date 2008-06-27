
/**
 * @author colin
 */
import com.mixmedia.mx.events.Event;

class BoxerEvent extends Event{
	public static var ATTACK:String    = "attack";
	public static var GUARD:String     = "guard";
	public static var HIT:String       = "hit";
	public static var MISSED:String    = "missed";

	public var position:String;
	
	public function BoxerEvent(currentTarget:Object,type:String,target:Object,position:String){
		super(currentTarget,type,target);
		this.position = position;
	}
}
