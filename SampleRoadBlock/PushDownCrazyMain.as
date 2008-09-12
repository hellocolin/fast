
/**
 * @author colin
 */


class PushDownCrazyMain {
	private var base:MovieClip;
	public function PushDownCrazyMain(mc:MovieClip){
		base = mc;

	}

	private function start():Void{
		base.gotoAndPlay('start');
	}
	
	private function wait():Void{
		base.gotoAndPlay('wait');
	}

	private function end():Void{
		
	}
	
	public function userEndCrazyAd():Void{
		closeAd();
	};

	public function closeAd():Void{
		//TODO: close crazy
	};
}
