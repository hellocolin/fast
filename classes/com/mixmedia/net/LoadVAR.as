import com.mixmedia.net.ILoader;

/**
 * @author Colin
 */
class com.mixmedia.net.LoadVAR implements ILoader {
	private var currentTarget : ILoader;
	
	public function LoadVAR(){
		trace('LoadVAR is not implement yet. please use LoadXML instead.');
		this.currentTarget = this;
	}

	public function getTarget() : Object {
		return this;
	}

	public function load(requestURL : String) : Void {
	}

	public function addEventListener(event : String, handler:Function) : Void {
	}

	public function removeEventListener(event : String, handler:Function) : Void {
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		this.currentTarget = ILoader(currentTarget);
	}
}