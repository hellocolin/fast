import com.mixmedia.utils.MovieClipTools;import com.mixmedia.utils.StringUtils;import com.mixmedia.utils.SystemUtils;import com.mixmedia.view.NavButton;
/** * @author Colin */
class NavBtn extends MovieClip implements IButtonClip,IFASTEventDispatcher{
	public static var FILEPREFIX:String = 'FILEPREFIX';	private var hitarea:Button;
	private var base:NavButton;

	public function NavBtn(){		var n:String = _name;		n = StringUtils.replace(_name, FILEPREFIX, SystemUtils.getMovieFileName(this, false));
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

	public function addElement(element : IButtonElement) : Void {
		base.addElement(element);
	}

	public function select() : Void {
		base.select();
	}	public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {		base.addEventListener(eventType, Fix.ref(whichObject,callFunction));	}	public function setMouseOverDelay(num : Number) : Void {		base.setMouseOverDelay(num);	}		public function setMouseOutDelay(num : Number) : Void {		base.setMouseOutDelay(num);	}		public function clearMouseOver() : Void {		base.clearMouseOver();	}		public function clearMouseOut() : Void {		base.clearMouseOut();	}
}
