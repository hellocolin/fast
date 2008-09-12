
/**
 * @author colin
 */
import com.mixmedia.mx.LocalConnectionEvt;

class PushDownPAMMain {
	private var base:MovieClip;
	
	private var lc:LocalConnectionEvt;

	public function PushDownPAMMain(mc:MovieClip){
		base = mc;
		lc = new LocalConnectionEvt();
		lc.connect("sonyT500");
		lc.addMethod("start",Fix.ref(this,start));
	}

	private function start():Void{
		base.gotoAndPlay('start');
		lc.close();
	}
	
	public function end():Void{
		//TODO:close PAM
	}
}
