/** * @author colin */

interface IList extends IScrollable{	public function setData(data:Array):Void;	public function getItemIndex(item:Object):Number;	public function setValue(value:Number):Void;}