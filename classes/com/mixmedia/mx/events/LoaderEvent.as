import com.mixmedia.mx.events.Event;
import com.mixmedia.net.ILoader;

/**
 * @author Colin
 */
class com.mixmedia.mx.events.LoaderEvent extends Event{
	public var targetContainer:Object;

	public function LoaderEvent(currentTarget : Object, type:String,target:ILoader,targetContainer:Object){
		super(currentTarget,type,target);
		this.targetContainer=targetContainer;
	}
}