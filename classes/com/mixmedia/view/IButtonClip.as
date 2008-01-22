import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.view.IButtonElement;

/**
 * @author Colin
 */
interface com.mixmedia.view.IButtonClip extends IEventDispatcher{
	function addElement(element:IButtonElement):Void;
}
