import mx.utils.Delegate;

import com.mixmedia.mx.view.ButtonEvt;
import com.mixmedia.mx.view.IButtonClip;
import com.mixmedia.mx.view.IButtonElement;
import com.mixmedia.navigation.Navigation;
import com.mixmedia.navigation.events.NavigationEvent;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author Colin
 * decorator of ButtonClip
 */
class com.mixmedia.mx.view.NavButton implements IButtonClip{
	private var base:ButtonEvt;
	private var currentTarget : IButtonClip;
	private var nav:Navigation;

	public var navKey:String;
	public var targetContainer: String;

	public function NavButton(hitarea:Button,navKey:String,targetContainer:String){
		base = new ButtonEvt(hitarea);
		base.setCurrentTarget(this);
		base.addEventListener(ButtonClipEvent.CLICK, Delegate.create(this,click));

		this.navKey = navKey;
		this.targetContainer = targetContainer;

		nav = Navigation.instance();
		nav.addEventListener(NavigationEvent.CHANGE,Delegate.create(this,highlightButton));
	}

	private function click(e:ButtonClipEvent):Void{
		var nav:Navigation = Navigation.instance();
		nav.changeSection(navKey, targetContainer, false, e.target);
	}

	public function highlightButton(e:NavigationEvent):Void{
		//if me in tree, highlight, else, dim
		var id:String = e.navKey;//1, 1_2_3, 5, 3;
		for(var i:Number=0;i<id.split("_").length;i++){
			if(this.navKey==id.split("_",i+1).join("_")){
				base.isHighlight = true;
				return;
			}
		}
		base.isHighlight = false;

	}
	
	public function addElement(element : IButtonElement) : Void {
		base.addElement(element);
	}
	
	public function addEventListener(event : String, handler : Function) : Void {
		base.addEventListener(event, handler);
	}
	
	public function removeEventListener(event : String, handler : Function) : Void {
		base.removeEventListener(event, handler);
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		base.setCurrentTarget(currentTarget);
	}
	
	public function get isHighlight():Boolean{
		return base.isHighlight;
	}
	
	public function select() : Void {
		base.select();
	}
	
	public function setMouseOverDelay(num : Number) : Void {
		base.setMouseOverDelay(num);
	}
	
	public function setMouseOutDelay(num : Number) : Void {
		base.setMouseOutDelay(num);
	}
}
