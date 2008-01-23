import mx.utils.Delegate;

import com.mixmedia.mx.view.ButtonClip;
import com.mixmedia.mx.view.IButtonClip;
import com.mixmedia.mx.view.IButtonElement;
import com.mixmedia.navigation.Navigation;
import com.mixmedia.navigation.events.NavigationEvent;
import com.mixmedia.view.events.ButtonClipEvent;

/**
 * @author Colin
 * decorator of ButtonClip
 */
class com.mixmedia.view.navigation.NavButton implements IButtonClip{
	private static var navBtnReference:Array = new Array();
	private var base:IButtonClip;
	private var currentTarget : IButtonClip;

	public var isHighlight:Boolean;
	public var navKey:String;
	public var targetContainer:String;

	public function NavButton(hitarea:Button,navKey:String,targetContainer:String){
		base = new ButtonClip(hitarea);
		base.setCurrentTarget(this);
		base.addEventListener(ButtonClipEvent.CLICK, Delegate.create(this,click));

		this.navKey = navKey;
		this.targetContainer = targetContainer;
		Navigation.instance().addEventListener(NavigationEvent.CHANGE,Delegate.create(this,highlightButton));
		register();
	}

	private function register():Void{
		if(navBtnReference[navKey]==null)navBtnReference[navKey] = new Array();
		navBtnReference[navKey].push(this);
	}

	private function click(e:ButtonClipEvent):Void{
		var nav:Navigation = Navigation.instance();
		nav.changeSection(navKey, targetContainer, false, e.target);
	}

	public function highlightButton(e:NavigationEvent):Void{
		var callerNavID:String = e.navKey;
		var i:Number,j:Number,name:String,matchName:String;
		//reset all navbtn status
		for(name in navBtnReference){
			for(i=0;i<navBtnReference[name].length;i++){
				navBtnReference[name][i].isHighlight = false;
			}
		}

		//find which button need to be highlight
		//callerNavID = 1_2_4
		//matchName = 1 , matchName=1_2, matchName = 1_2_4
		for(i=0;i<callerNavID.split("_").length;i++){
			matchName = callerNavID.split("_",i+1).join("_");
			if(navBtnReference[matchName]!=null){
				for(j=0;j<navBtnReference[matchName].length;j++){
					NavButton(navBtnReference[matchName][j]).isHighlight = true;
				}
			}
		}

		for(name in navBtnReference){
			for(i=0;i<navBtnReference[name].length;i++){
				navBtnReference[name][i].reset();
			}
		}
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
}
