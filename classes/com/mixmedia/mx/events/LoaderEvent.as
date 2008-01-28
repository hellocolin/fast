import com.mixmedia.mx.events.Event;

/**
 * @author Colin
 */
class com.mixmedia.mx.events.LoaderEvent extends Event{
	public var targetContainer:Object;

	public function LoaderEvent(currentTarget : Object, type:String,target:Object,targetContainer:Object){
		super(currentTarget,type,target);
		this.targetContainer=targetContainer;
	}
}