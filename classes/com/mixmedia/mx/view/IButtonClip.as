import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.view.IButtonElement;

/**
 * @author Colin
 */
interface com.mixmedia.mx.view.IButtonClip extends IEventDispatcher{
	function addElement(element:IButtonElement):Void;
	function select():Void;
	function setMouseOverDelay(num:Number):Void;
	function setMouseOutDelay(num:Number):Void;
}
