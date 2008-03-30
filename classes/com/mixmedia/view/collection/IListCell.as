import com.mixmedia.collection.List;
import com.mixmedia.mx.events.IEventDispatcher;

/**
 * @author colin
 */
interface com.mixmedia.view.collection.IListCell extends IEventDispatcher{
	public function setList(list:List):Void;
	public function setModel(model:Object):Void;
	public function getRowHeight():Number;
	public function getColWidth():Number;	
}
