
/**
 * @author colin
 */
class TimerView extends MovieClip {
	private var txt : TextField;
	
	public function setTime(ms:Number):Void{
		txt.text = Math.round(ms/1000).toString();
	}
	public function move():Void{
		this.nextFrame();
	}
}
