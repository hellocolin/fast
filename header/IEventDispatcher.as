/**
 * @author Colin
 */
interface IEventDispatcher {
	public function addEventListener(event:String, handler:Function):Void;
	public function removeEventListener(event:String, handler:Function):Void;
	public function setCurrentTarget(currentTarget:Object):Void;
}