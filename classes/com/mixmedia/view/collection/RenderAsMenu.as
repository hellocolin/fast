
/**
 * @author colin
 */
import com.mixmedia.view.collection.IListCell;
import com.mixmedia.view.collection.IListCellRenderArrangement;

class com.mixmedia.view.collection.RenderAsMenu implements IListCellRenderArrangement {
	private var cellIdentifier:String = "PhotoSetListCell";
	private var cells : Array;
	private var target : MovieClip;

	public function RenderAsMenu(cellIdentifier:String,target:MovieClip){
		this.cellIdentifier = cellIdentifier;
		this.target = target;

		cells = new Array();
	}
	
	public function render(data : Array) : Array {
		clear();
		for(var i:Number=0;i<data.length;i++){
			var cell:IListCell = IListCell(target.attachMovie(cellIdentifier, 'item'+i, i));
			MovieClip(cell)._y = cell.getRowHeight()*i;
			cell.setModel(data[i]);
			cell.setIndex(i);
			cells.push(cell);
		}
		return cells;
	}
	
	public function clear():Void{
		for(var i:Number=0;i<cells.length;i++){
			MovieClip(cells[i]).removeMovieClip();
		}
		cells = new Array();
	}
	
	public function update(data:Array):Array{
		return render(data);
	}
}
