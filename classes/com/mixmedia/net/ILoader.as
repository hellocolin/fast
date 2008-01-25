import com.mixmedia.mx.events.IEventDispatcher;

/**
 * @author colin
 */
interface com.mixmedia.net.ILoader extends IEventDispatcher{
	function getTargetContainer():Object;
	function load(requestURL:String):Void;
}