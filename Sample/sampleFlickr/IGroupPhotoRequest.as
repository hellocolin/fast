
/**
 * @author colin
 */
import com.mixmedia.mx.events.IEventDispatcher;

interface IGroupPhotoRequest extends IEventDispatcher{
	public function loadPhotos(action:String) : Void;
	public function getResultPhotos() : Array;
}
