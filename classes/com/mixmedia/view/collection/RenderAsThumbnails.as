
/**
 * @author colin
 */
import com.mixmedia.view.collection.IListCell;
import com.mixmedia.view.collection.IListCellRenderArrangement;
import com.mixmedia.utils.Queue;
class com.mixmedia.view.collection.RenderAsThumbnails implements IListCellRenderArrangement {
	private var cellIdentifier:String = "ThumbPicSelect";
	private var cells : Array;
	private var row : Number;
	private var col : Number;
	private var target : MovieClip;

	public function RenderAsThumbnails(cellIdentifier:String,target:MovieClip,row:Number,col:Number){
		this.cellIdentifier = cellIdentifier;
		this.target = target;
		this.row = (row==null)?3:row;
		this.col = (col==null)?3:col;
		cells = new Array();
	}

	public function render(data : Array) : Array {
		clear();
		var count:Number = Math.min(row*col,data.length);

		for(var i:Number=0;i<count;i++){
			var cell:IListCell = IListCell(target.attachMovie(cellIdentifier, "item"+i, i));
			MovieClip(cell)._x = (i%col)*cell.getColWidth();
			MovieClip(cell)._y = Math.floor(i/col)*cell.getRowHeight();

			cell.setModel(data[i]);
			cells.push(cell);
		}
		return cells;
	}

	public function clear():Void{
		Queue.instance(75).clear();
		for(var i:Number=0;i<cells.length;i++){
			MovieClip(cells[i]).removeMovieClip();
		}
		cells = new Array();
	}		public function update(data : Array) : Array {
		return render(data);
	}
}
