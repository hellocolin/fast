import mx.utils.Delegate;

import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author colin
 */
class RadioButton extends ButtonClip{
	private static var groups:Array = new Array();

	private var buttonGroupName:String;
	public function RadioButton(){
		var para:Array = _name.split("$");
		buttonGroupName = String(_parent)+para[0];
		
		if(groups[buttonGroupName]==null)groups[buttonGroupName] = new Array();
		groups[buttonGroupName][Number(para[1])] = this;

		base.addEventListener(ButtonClipEvent.CLICK, Delegate.create(this,select));
	}

	public function addEventListener(event : String, handler : Function) : Void {
		base.removeEventListener(ButtonClipEvent.CLICK, Delegate.create(this,select));
		base.addEventListener(event, handler);
		base.addEventListener(ButtonClipEvent.CLICK, Delegate.create(this,select));
	}

	public function select() : Void {
		for(var i:Number=0;i<groups[buttonGroupName].length;i++){
			RadioButton(groups[buttonGroupName][i]).base.isHighlight = false;
		}
		base.isHighlight = true;
	}
}
