
/**
 * @author colin
 */
class Table {
	private var width:Number;
	private var rowCount:Number;
	private var colCount:Number = 0;
	private var i:Number;
	private var j:Number;
	private var k:Number;

	private var tableWidth:Number;
	private var rowsHeight:Array;
	private var colsWidth:Array;
	public function Table(){
		rowsHeight = [];
		colsWidth  = [];
	}
	
	public function setHTML(xhtml:XML):Void{
		var xTable:XMLNode= xhtml.firstChild;
		tableWidth = Number(xTable.attributes['width']);
		
		var arrayTRs:Array = [];
		var td:XMLNode;
		var cellWidth:Number;
		rowCount = xhtml.firstChild.childNodes.length;

		for(i=0;i<rowCount;i++){
			arrayTRs[i] = [];
			
			for(j=0;j<xTable.childNodes[i].childNodes.length;j++){
				td = xTable.childNodes[i].childNodes[j];
				cellWidth = Number(td.attributes['width']);
				if(isNaN(cellWidth))cellWidth=-1;
				if(colsWidth[j]==null)colsWidth[j]=-1;

				colsWidth[j] = Math.max(colsWidth[j],cellWidth);

				arrayTRs[i].push(new TableCell(cellWidth,Number(td.attributes['height']),td.childNodes));
				if(xTable.childNodes[i].childNodes[j].attributes['colspan']!=null){
					for(k=0;k<Number(xTable.childNodes[i].childNodes[j].attributes['colspan']);k++){
						arrayTRs[i].push();
					}
				}
				colCount = Math.max(colCount,arrayTRs[i].length);
			}
		}
		updateColumnsWidth();
	}
	
	private function updateColumnsWidth():Void{
		//find undefined column widths
		var count:Number=0;
		var total:Number = 0;
		for(i=0;i<colsWidth.length;i++){
			if(colsWidth[i]==-1){
				count++;
			}else{
				total+=colsWidth[i];
			}
		}
		//find average width for undefined columns
		var avg:Number = Math.floor((tableWidth-total)/count);
		for(i=0;i<colsWidth.length;i++){
			if(colsWidth[i]==-1)colsWidth[i] = avg;
		}		
	}
}
