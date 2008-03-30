import com.mixmedia.flickr.Photo;
import com.mixmedia.mx.events.Event;

/** * @author colin */class events.EnlargePanelEvent extends Event {
	public static var FORWARD:String = "forward";
	public var photo:Photo;
	public function EnlargePanelEvent(currentTarget : Object, type : String, target : Object, photo:Photo) {		super(currentTarget, type, target);
		this.photo = photo;	}
}