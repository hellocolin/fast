import com.mixmedia.mx.events.IEventDispatcher;
import com.mixmedia.mx.view.NavButton;
import com.mixmedia.utils.MovieClipTools;

/**
 * @author Colin
 */
class NavBtn extends MovieClip implements IEventDispatcher{
	private var hitarea:Button;
	private var base:NavButton;

	public function NavBtn(){
		var para:Array = _name.split("$");
		base = new NavButton(MovieClipTools.findButton(this),para[1],para[2]);
		base.setCurrentTarget(this);
	}
	
	public function addEventListener(event : String, handler : Function) : Void {
		base.addEventListener(event, handler);
	}
	
	public function removeEventListener(event : String, handler : Function) : Void {
		base.removeEventListener(event, handler);
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		base.setCurrentTarget(currentTarget);
	}
}
