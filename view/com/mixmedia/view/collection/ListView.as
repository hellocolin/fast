﻿

import com.mixmedia.collection.IList;
import com.mixmedia.collection.List;
import com.mixmedia.collection.events.ListEvent;
import com.mixmedia.view.IInput;
import com.mixmedia.view.collection.IListCell;
import com.mixmedia.view.collection.IListCellRenderArrangement;

class com.mixmedia.view.collection.ListView implements IInput, IEventDispatcher, IList {
	private var items : Array;
	public function ListView(renderArrangement:IListCellRenderArrangement,list:List) {
	
	public function setValue(value : Number) : Void {