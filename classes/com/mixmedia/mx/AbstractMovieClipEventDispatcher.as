import mx.events.EventDispatcher;import mx.utils.Delegate;import com.mixmedia.mx.events.Event;import com.mixmedia.mx.events.IEventDispatcher;import com.mixmedia.mx.events.IFASTEventDispatcher;/**
 * @author colin
 */
class com.mixmedia.mx.AbstractMovieClipEventDispatcher extends MovieClip implements IEventDispatcher,IFASTEventDispatcher{
	private var currentTarget:Object;
	
	public function AbstractMovieClipEventDispatcher(){
		EventDispatcher.initialize(this);
		currentTarget = this;
	}

	public function setCurrentTarget(currentTarget : Object) : Void {
		this.currentTarget = currentTarget;
	}

	public function addEventListener(event:String, handler:Function):Void{}
	private function dispatchEvent(eventObj:Event):Void{}
	public function removeEventListener(event:String, handler:Function) : Void {	}		public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {		addEventListener(eventType,Delegate.create(whichObject,callFunction));	}
}