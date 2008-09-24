﻿
/**
 * @author colin
 */
import mx.utils.Delegate;

import com.mixmedia.mx.events.Event;
import com.mixmedia.navigation.DeepLinking;
import com.mixmedia.navigation.NavStackRequest;
import com.mixmedia.navigation.Navigation;

/**
 * @author colin
 */
class Main {
	private var btns:Array;
	private var menus : Array;
	private var base : MovieClip;
	private var iid:Number;

	public function Main(base:MovieClip){
		this.base = base;
		
		DeepLinking.instance().when(Event.CHANGE,this,resolveDeepLink);

		iid= setInterval(Delegate.create(this,selectSectionToLoad),10);
	}
	
	private function selectSectionToLoad():Void{
		clearInterval(iid);
		resolveDeepLink();
	}
	
	private function resolveDeepLink() : Void {
		if(DeepLinking.instance().getValue()==Navigation.instance().getCurrentNavKey())return;
		
		var nid:String = DeepLinking.instance().getValue().split('.')[0];
		if(nid.split("_")[0]=='1'&&nid.split("_").length>2) {
			var steps:Array = [];
			var rid:Array = nid.split("_");
			rid = rid.slice(0, 2);

			steps.push(new NavStackRequest(rid.join("_"),'',true));
			steps.push(new NavStackRequest(nid,'sub',true));

			Navigation.instance().changeSections(steps);
			return;
		}
		if(nid==""||nid=="/"){
			Navigation.instance().changeSection('0', null,true);
			return;
		}
		Navigation.instance().changeSection(nid, null,true);
	}
}