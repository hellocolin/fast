/** * @author colin */import com.mixmedia.view.collection.IListCell;
import com.mixmedia.collection.List;import com.mixmedia.mx.AbstractMovieClipEventDispatcher;class Cell extends AbstractMovieClipEventDispatcher implements IListCell {	public static var IDENTIFIER:String = "Cell";	private var list:List;	private var model:Number;	private var index:Number;	public function setList(list : List) : Void {		this.list = list;	}	public function setModel(model : Object) : Void {		this.model = Number(model);		this['txt'].text = this.model;	}	public function setIndex(value : Number) : Void {		this.index = value;	}	public function getRowHeight() : Number {		return 30;	}	public function getColWidth() : Number {		return 30;	}}