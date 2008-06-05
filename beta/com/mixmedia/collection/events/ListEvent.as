import com.mixmedia.mx.events.Event;

/**
 * @author colin
 */
class com.mixmedia.collection.events.ListEvent extends Event {
	public static var CHANGE: String = "change";
	public static var UPDATE: String = "update";
	public static var CHANGEPAGE:String = "changePage";

	public var value:Number;
	public var item:Object;
	
	public function ListEvent(currentTarget : Object, type : String, target : Object, value:Number,item:Object) {
		super(currentTarget, type, target);
		this.value = value;
		this.item  = item;
	}
}
