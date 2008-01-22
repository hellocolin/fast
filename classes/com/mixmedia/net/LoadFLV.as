import com.mixmedia.mx.NetStreamEvt;
import com.mixmedia.net.ILoader;

/**
 * @author Colin
 */
class com.mixmedia.net.LoadFLV implements ILoader {
	private var vid : Video;
	private var vid_nc : NetConnection;
	private var vid_ns : NetStreamEvt;
	private var buffer :Number=0;
	private var autoPlay:Boolean;

	public function LoadFLV(vid:Video,autoPlay:Boolean,deblocking:Number,smooth:Boolean,buffer:Number){
		this.vid = vid;
		this.vid.deblocking = (deblocking==null)?2:deblocking;
		this.vid.smoothing = (smooth==null)?true:smooth;
		this.autoPlay = (autoPlay==null)?true:autoPlay;
		this.buffer = (buffer==null)?0:buffer;
		
		vid_nc = new NetConnection();
		vid_nc.connect(null);
		vid_ns = new NetStreamEvt(vid_nc);
		vid_ns.setCurrentTarget(this);
		vid_ns.setBufferTime(buffer);
		vid.attachVideo(vid_ns);
	}

	public function load(requestURL:String):Void{
		vid_nc.close();
		vid_ns.close();
		vid_ns.load(requestURL);
		if(autoPlay==false)vid_ns.pause(true);
	}

	public function getTarget() : Object {
		return vid;
	}

	public function addEventListener(event : String, handler:Function) : Void {
		vid_ns.addEventListener(event,handler);
	}

	public function removeEventListener(event : String, handler:Function) : Void {
		vid_ns.removeEventListener(event, handler);
	}
	
	public function setCurrentTarget(currentTarget:Object):Void{
		vid_ns.setCurrentTarget(currentTarget);
	}
}