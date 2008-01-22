import com.mixmedia.mx.events.Event;

/**
 * @author Colin
 */
class com.mixmedia.view.events.VideoPlayerEvent extends Event{
	public static var METADATA:String="onMetaData";
	public static var EARLIESTSTARTTIME:String = "onEarliestStartTime";
	public static var PLAYING:String = "onPlaying";

	public function VideoPlayerEvent(currentTarget : Object, type : String,target:Object){
		super(currentTarget,type,target);
	}
}
