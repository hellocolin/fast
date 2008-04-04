import com.mixmedia.collection.IScrollable;import com.mixmedia.mx.TextFieldEvt;
/**
 * @author colin
 */
class XHTMLScrollPane implements IScrollable{
	private var txt:TextFieldEvt;
	private var scrollbar:ScrollBar;

	private var max:Number = 0;
	private var index:Number = 0;

	public function XHTMLScrollPane(txt:TextField,scrollbar:ScrollBar){
		this.txt = new TextFieldEvt(txt);
		this.scrollbar = scrollbar;
	}
	
	public function setIndex(value : Number) : Void {
		index = value;
		txt.scroll = index+1;
	}

	public function getIndex() : Number {
		return index;
	}

	public function getMax() : Number {
		return max;
	}
	
	public function setHTML(data:XMLNode):Void{
		txt.xhtmlText = data.toString()+"<p></p><p></p><p></p>";
		max = txt.maxscroll-1;
		setIndex(0);
		scrollbar.setTarget(this);
	}
}
