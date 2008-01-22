import com.mixmedia.mx.XMLEvt;
import com.mixmedia.net.ILoader;
/**
 * @author colin
 */
class com.mixmedia.net.LoadXML implements ILoader {
	private var xmlContent : XMLEvt;
	private var request : String;

	public function LoadXML(){
		xmlContent = new XMLEvt();
		xmlContent.setCurrentTarget(this);
	}
	
	public function load(requestURL : String):Void{
		this.request = requestURL;
		xmlContent.load(request);
	}

	public function getTarget() : Object {
		return xmlContent;
	}

	public function addEventListener(event : String, handler:Function) : Void {
		xmlContent.addEventListener(event,handler);
	}

	public function removeEventListener(event : String, handler:Function) : Void {
		xmlContent.removeEventListener(event, handler);
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		xmlContent.setCurrentTarget(currentTarget);
	}
}