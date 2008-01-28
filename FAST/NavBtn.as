import com.mixmedia.mx.view.NavButton;
import com.mixmedia.utils.MovieClipTools;

/**
 * @author Colin
 */
class NavBtn extends MovieClip{
	private var hitarea:Button;

	public function NavBtn(){
		var para:Array = _name.split("$");
		new NavButton(MovieClipTools.findButton(this),para[1],para[2]);
	}
}
