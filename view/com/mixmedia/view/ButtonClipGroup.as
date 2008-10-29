
/**
 * @author colin
 * to group buttons, when one mouse over, all element rollover
 */
import com.mixmedia.mx.events.Event;
import com.mixmedia.view.events.ButtonClipEvent;

class com.mixmedia.view.ButtonClipGroup implements IButtonElement{
	static private var ins:ButtonClipGroup;
	static public function instance():ButtonClipGroup{
		if(ins==null)ins = new ButtonClipGroup();
		return ins;
	}
	private var buttonGroups:Array;
	private var dictButtonToGroupId:Array;
	
	private function ButtonClipGroup(){
		buttonGroups=[];
		dictButtonToGroupId = [];
	}
	
	public function addButton(groupId:String,btn:IButtonClip):Boolean{
		if(buttonGroups[groupId]==null)buttonGroups[groupId] = [];

		for(var i:Number=0;i<buttonGroups[groupId].length;i++){
			if(buttonGroups[groupId][i]===btn)return false;//the button exist.
		}
		buttonGroups[groupId].push(IButtonClip(btn));
		dictButtonToGroupId.push({btn:btn,id:groupId});
		btn.addElement(this);		
		return true;
	}
	
	private function getGroupIdByButton(btn:IButtonClip):String{
		for(var i:Number=0;i<dictButtonToGroupId.length;i++){
			if(dictButtonToGroupId[i].btn === btn)return dictButtonToGroupId[i].id;
		}
	}

	private function dispatch(e:ButtonClipEvent,type:String):Void{
		var groupId:String = getGroupIdByButton(IButtonClip(e.currentTarget));
		var btnsInSameGroup:Array = buttonGroups[groupId];
		var elements:Array;

		for(var i:Number=0;i<btnsInSameGroup.length;i++){
			elements = btnsInSameGroup[i].getElements();
			for(var j:Number=0;j<elements.length;j++){
				if(elements[j]===this)continue;
				IButtonElement(elements[j])[type](e);
			}
		}
	}

	public function buttonOver(e : ButtonClipEvent) : Void {
		dispatch(e,'buttonOver');
	}

	public function buttonOut(e : ButtonClipEvent) : Void {
		dispatch(e,'buttonOut');
	}
	
	public function buttonDown(e : ButtonClipEvent) : Void {
		dispatch(e,'buttonDown');
	}
	
	public function buttonReset(e : ButtonClipEvent) : Void {
		dispatch(e,'buttonReset');
	}
}
