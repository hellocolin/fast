﻿
/**
 * @author colin
 */
import com.gamemeal.GameEvent;import com.gamemeal.flipBW.FlipBlackWhiteCell;import com.mixmedia.mx.events.AbstractEventDispatcher;
class com.gamemeal.flipBW.FlipBlackWhite extends AbstractEventDispatcher{
	private var cells:Array;
	private var col:Number = 4;
	private var row:Number = 4;
	public function start():Void{
		cells = new Array();
		for(var x:Number=0; x<col ;x++){
			cells[x] = new Array();
			for(var y:Number=0;y<row;y++){
				cells[x][y] = new FlipBlackWhiteCell(true);
			}
		}
		
		for(var i:Number=0;i<10;i++){
			var swapx:Number = random(col);
			var swapy:Number = random(row);
			setCell(swapx,swapy);
		}
	}

	public function setCell(x:Number,y:Number):Void{
		FlipBlackWhiteCell(cells[x-1][y]).swap();
		FlipBlackWhiteCell(cells[x+1][y]).swap();
		FlipBlackWhiteCell(cells[x][y-1]).swap();
		FlipBlackWhiteCell(cells[x][y+1]).swap();
		FlipBlackWhiteCell(cells[x][y]).swap();
		if(checkIsAllWhite())dispatchEvent(new GameEvent(this,GameEvent.WIN));
	}

	private function checkIsAllWhite():Boolean{
		for(var x:Number=0; x<col ;x++){
			for(var y:Number=0;y<row;y++){
				if(FlipBlackWhiteCell(cells[x][y]).state==false)return false;
			}
		}
		return true;
	}
}
