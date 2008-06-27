
/**
 * @author colin
 */
import mx.utils.Delegate;

class BoxerComputerControl{
	private var base:Boxer;
	private var iid:Number;

	public function BoxerComputerControl(base:Boxer){
		this.base = base;
		base.setCurrentTarget(this);
		iid= setInterval(Delegate.create(this,think),500);
		think();
	}

	private function think():Void{
		var pos:Array = [Boxer.TOP,Boxer.MID,Boxer.BOTTOM];
		base.guard(pos[random(3)]);
	}

	public function setBoxer(boxer : Boxer) : Void {
		base = boxer;
	}
}
