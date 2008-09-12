
/**
 * @author colin
 */
import com.mixmedia.mx.LocalConnectionEvt;

class PushDownPAMSmall {
	private var base:MovieClip;
	private var lc:LocalConnectionEvt;

	public function PushDownPAMSmall(mc:MovieClip){
		base = mc;
		lc = new LocalConnectionEvt();
		lc.addMethod("start",Fix.ref(this,start));
		lc.connect("sonyT500");

//	    var rb:RoadBlock = new RoadBlock("PAM2", "WAM2");
//	    rb.addEventListener(RoadBlock.SYNC_EVENT_NAME, Fix.ref(this,start));
	}

	private function start():Void{
		base.gotoAndPlay('start');
		lc.close();
	}
	private function wait():Void{
		base.gotoAndPlay('wait');
	}
	private function end():Void{
		base.stop();
		lc.connect("sonyT500");		
	}
}
