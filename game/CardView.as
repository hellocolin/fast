
/**
 * @author colin
 */
class CardView extends ButtonClip {
	private var mcOpen : MovieClip;
	private var isOpen:Boolean = false;
	
	public function reset():Void{
		if(isOpen)close();
	}
	
	public function open():Void{
		isOpen = true;
		gotoAndPlay('open');
	}

	public function close():Void{
		isOpen = false;
		gotoAndPlay('close');
	}
	
	public function setId(id : Number) : Void {
		mcOpen.gotoAndStop(id);
	}
}
