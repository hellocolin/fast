import com.mixmedia.mx.events.ActivityEvent;

/**
 * @author Colin
 */
class com.mixmedia.mx.events.FullScreenEvent extends ActivityEvent {
	public static var FULL_SCREEN : String = "fullScreen";

	public var fullScreen : Boolean;
	public function FullScreenEvent(currentTarget : Object, type : String, target : Object,fullScreen:Boolean) {
		super(currentTarget, type, target);
		this.fullScreen = (fullScreen==null)?false:fullScreen;
	}
}
