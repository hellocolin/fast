import com.mixmedia.utils.MovieClipTools;
import com.mixmedia.view.status.IStatusIcon;

/**
 * @author colin
 */
class com.mixmedia.view.status.ErrorIcon extends MovieClip implements IStatusIcon{
	//declare var
	private var message:String;
	private var title:String;

	public function ErrorIcon(){
		MovieClipTools.notResize(this);
	}
	
	public function kill() : Void {
		this.removeMovieClip();
	}
}