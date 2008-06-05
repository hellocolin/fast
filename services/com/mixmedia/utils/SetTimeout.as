
/**
 * @author colin
 */
import mx.utils.Delegate;

class com.mixmedia.utils.SetTimeout {
	private var iid:Number;
	private var fnt:Function;

	public function SetTimeout(fnt:Function,time:Number){
		this.fnt = fnt;
		iid = setInterval(Delegate.create(this,exec),time);
	}
	public function clear():Void{
		clearInterval(iid);
	}
	
	private function exec():Void{
		clearInterval(iid);
		fnt();
		fnt = null;
	}
}
