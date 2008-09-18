
/**
 * @author colin
 */

class TestLocalConnectionClientMain {
	private var base:MovieClip;
	private var lc : LocalConnectionEvt;

	public function TestLocalConnectionClientMain(mc:MovieClip){
		base = mc;
		lc = new LocalConnectionEvt();
		lc.connect('mxmLCClient');
		lc.addMethod('run', Fix.ref(this,run));
		lc.addMethod('run2',Fix.ref(this,run2));
	}

	private function run(arg:String):Void{
		base['out'].text= 'client:'+arg;
	}
	
	private function run2(arg:String):Void{
		base['out'].text= 'client2:'+arg;
	}
}