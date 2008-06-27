
/**
 * @author colin
 */
import com.mixmedia.mx.events.Event;

class MCBoxer extends MovieClip {
	public function onBoxerEvent(e:BoxerEvent):Void{
		this.gotoAndPlay(e.type+"_"+e.position);
	}
}
