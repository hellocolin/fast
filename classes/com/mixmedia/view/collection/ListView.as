﻿/** * @author colin */import mx.utils.Delegate;

import com.mixmedia.collection.IList;
import com.mixmedia.collection.List;
import com.mixmedia.collection.events.ListEvent;
import com.mixmedia.view.IInput;
import com.mixmedia.view.collection.IListCell;
import com.mixmedia.view.collection.IListCellRenderArrangement;

class com.mixmedia.view.collection.ListView implements IInput, IEventDispatcher, IList {	private var base : List;	private var imp : IListCellRenderArrangement;	private var cells : Array;
	private var items : Array;
	public function ListView(renderArrangement:IListCellRenderArrangement,list:List) {		base = (list==null)?new List():list;		imp = renderArrangement;		base.setCurrentTarget(this);		base.addEventListener(ListEvent.CHANGEPAGE, Delegate.create(this,onPageChange));		base.addEventListener(ListEvent.UPDATE, Delegate.create(this,onListUpdate));	}		private function onListUpdate(e:ListEvent) : Void {		items = e['item'];		cells = imp.render(items);		setCellList();		base.itemsCountPerPage = cells.length;	}	private function onPageChange() : Void {		var sliceData:Array = items.slice(base.getIndex()*base.itemsCountPerPage);		imp.update(sliceData);		setCellList();	}	private function setCellList():Void{		for(var i:Number=0;i<cells.length;i++){			IListCell(cells[i]).setList(base);		}	}	public function setData(data:Array):Void{		base.setData(data);	}	public function getValue() : Object {		return base.getValue();	}		public function addEventListener(event : String, handler : Function) : Void {		base.addEventListener(event, handler);	}		public function removeEventListener(event : String, handler : Function) : Void {		base.removeEventListener(event, handler);	}		public function setCurrentTarget(currentTarget : Object) : Void {		base.setCurrentTarget(currentTarget);	}		public function setIndex(value : Number) : Void {		base.setIndex(value);	}		public function getIndex() : Number {		return base.getIndex();	}		public function getMax() : Number {		return base.getMax();	}		public function getItemIndex(item : Object) : Number {		return base.getItemIndex(item);	}
	
	public function setValue(value : Number) : Void {		base.setValue(value);	}	public function getSelectedCell():IListCell{		for(var i:Number=0;i<cells.length;i++){			var model:Object = IListCell(cells[i]).getModel();			if(base.getItemIndex(model)==base.getValue())return cells[i];		}		return null;	}}