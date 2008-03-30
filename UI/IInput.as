import com.mixmedia.mx.events.IEventDispatcher;

/**
 * @author colin
 */
interface IInput extends IEventDispatcher{
	public function getValue():Object;
}
