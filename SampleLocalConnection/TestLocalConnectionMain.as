
/**
 * @author colin
 */

class TestLocalConnectionMain {
	private var base:MovieClip;
	private var lc : LocalConnectionEvt;

	public function TestLocalConnectionMain(mc:MovieClip){
		base = mc;
		lc = new LocalConnectionEvt();
		lc.addEventListener(LocalConnectionEvt.EVENT_STATUS,Fix.ref(this,testOnStatus));
		lc.addEventListener(LocalConnectionEvt.EVENT_ERROR ,Fix.ref(this,testOnError));
	}

	public function run():Void{
		lc.send("mxmLCClient","run",getTimer());
	}

	public function run2():Void{
		lc.send("mxmLCClient","run2",getTimer());
	}
	
	private function testOnStatus():Void{
		base['out'].text = 'onStatus';
	}

	private function testOnError():Void{
		base['out'].text = "onError";
	}
}
