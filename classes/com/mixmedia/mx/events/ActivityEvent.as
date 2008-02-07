import com.mixmedia.mx.events.Event;

/**
 * @author Colin
 */
class com.mixmedia.mx.events.ActivityEvent extends Event {
	public static var ACTIVITY : String = "activity";
	public var activating:Boolean;

	public function ActivityEvent(currentTarget : Object, type : String, target : Object,activating:Boolean) {
		super(currentTarget, type, target);
		this.activating = (activating==null)?false:activating;
	}
}
