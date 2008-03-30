import com.mixmedia.mx.events.Event;

/**
 * @author colin
 */
class com.mixmedia.flickr.events.PhotoEvent extends Event {
	public static var IMAGE_URL_LOADED:String = 'imageURLLoaded';

	public function PhotoEvent(currentTarget : Object, type : String, target : Object) {
		super(currentTarget, type, target);
	}
}
