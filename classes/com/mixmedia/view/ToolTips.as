import com.mixmedia.utils.MovieClipTools;
/**
 * @author colin
 */
class com.mixmedia.view.ToolTips extends MovieClip {
	//declare var
	private var message:String;
	private var title:String;

	public function ToolTips(){
		MovieClipTools.notResize(this);
	}
}