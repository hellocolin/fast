
/**
 * @author colin
 */
import com.mixmedia.mx.LocalConnectionEvt;

class PushDownWAMMain {
	private static var MODE_ROADBLOCK:String = "roadblock";
	private static var MODE_CRAZYAD:String   = "crazyAd";

	private var base:MovieClip;
	private var mode:String = MODE_ROADBLOCK;
	private var iid:Number;
	
	private var lc:LocalConnectionEvt;
	
	public function PushDownWAMMain(mc:MovieClip){
		base = mc;
		lc = new LocalConnectionEvt();
		lc.connect('sonyT500');
		lc.addMethod('start', Fix.ref(this,startPlay));

		clearInterval(iid);
		iid = setInterval(Fix.ref(this,start),3000);
	}

	private function start():Void{
		clearInterval(iid);
		lc.send('sonyT500', 'start');
	}
	
	private function startPlay():Void{
		clearInterval(iid);
		base.gotoAndPlay('start');	
	}
	
	private function wait():Void{
		base.gotoAndPlay('wait');
	}

	private function end():Void{
		mode = MODE_CRAZYAD;
	}

	public function clickTAG():Void{
		getURL(_root['clickTAG']);
	}
	
	public function clickStart():Void{
		start();
	}
}
