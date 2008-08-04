import mx.utils.Delegate;import com.mixmedia.mx.DisplayObject;import com.mixmedia.mx.events.Event;import com.mixmedia.mx.events.FocusEvent;import com.mixmedia.mx.events.TextEvent;import TextField.StyleSheet;/**
 * @author Colin
 */
class com.mixmedia.mx.TextFieldEvt extends DisplayObject implements IEventDispatcher, IFASTEventDispatcher{
	private var base:TextField;
	public function TextFieldEvt(base:TextField) {
		this.base = base;
		base.addListener(this);
		base.onSetFocus = Delegate.create(this,onSetFocus);
		base.onKillFocus= Delegate.create(this,onKillFocus);
	}

	public function get _target() 		: String{return base._target;}
	public function get _quality() 		: String{return base._quality;}
	public function get _soundbuftime()	: Number{return base._soundbuftime;}
	public function get _url() 			: String{return base._url;}
	public function get _parent() 		: MovieClip{return base._parent;}
	public function get autoSize() 		: Object{return base.autoSize;}
	public function get background() 	: Boolean{return base.background;}
	public function get backgroundColor(): Number{return base.backgroundColor;}
	public function get border() 		: Boolean{return base.border;}
	public function get borderColor() 	: Number{return base.borderColor;}
	public function get bottomScroll() 	: Number{return base.bottomScroll;}
	public function get condenseWhite()	: Boolean{return base.condenseWhite;}
	public function get embedFonts() 	: Boolean{return base.embedFonts;}
	public function get hscroll() 		: Number{return base.hscroll;}
	public function get html() 			: Boolean{return base.html;}
	public function get htmlText() 		: String{return base.htmlText;}
	public function get length() 		: Number{return base.length;}
	public function get maxChars() 		: Number{return base.maxChars;}
	public function get maxhscroll() 	: Number{return base.maxhscroll;}
	public function get maxscroll() 	: Number{return base.maxscroll;}
	public function get multiline() 	: Boolean{return base.multiline;}
	public function get password() 		: Boolean{return base.password;}
	public function get restrict() 		: String{return base.restrict;}
	public function get scroll() 		: Number{return base.scroll;}
	public function get selectable() 	: Boolean{return base.selectable;}
	public function get tabEnabled() 	: Boolean{return base.tabEnabled;}
	public function get tabIndex() 		: Number{return base.tabIndex;}
	public function get text() 			: String{return base.text;}
	public function get textColor() 	: Number{return base.textColor;}
	public function get textHeight() 	: Number{return base.textHeight;}
	public function get textWidth() 	: Number{return base.textWidth;}
	public function get type() 			: String{return base.type;}
	public function get variable() 		: String{return base.variable;}
	public function get wordWrap() 		: Boolean{return base.wordWrap;}
	public function get mouseWheelEnabled() : Boolean{return base.mouseWheelEnabled;}
	public function get styleSheet() 	: StyleSheet{return base.styleSheet;}

	public function set _target 		(s: String)	: Void{base._target= s;}
	public function set _quality 		(s: String)	: Void{base._quality=s;}
	public function set _soundbuftime 	(n: Number)	: Void{base._soundbuftime= n;}
	public function set _url 			(s: String)	: Void{base._url=s;}
	public function set _parent 		(m: MovieClip): Void{base._parent= m;}
	public function set autoSize 		(o: Object)	: Void{base.autoSize= o;}
	public function set background 		(b: Boolean): Void{base.background= b;}
	public function set backgroundColor	(n: Number)	: Void{base.backgroundColor= n;}
	public function set border 			(b: Boolean): Void{base.border= b;}
	public function set borderColor 	(n: Number)	: Void{base.borderColor= n;}
	public function set bottomScroll 	(n: Number)	: Void{base.bottomScroll= n;}
	public function set condenseWhite 	(b: Boolean): Void{base.condenseWhite= b;}
	public function set embedFonts 		(b: Boolean): Void{base.embedFonts= b;}
	public function set hscroll 		(n: Number)	: Void{base.hscroll= n;}
	public function set html 			(b: Boolean): Void{base.html= b;}
	public function set htmlText 		(s: String)	: Void{
		base.htmlText = s;
		onChanged();
	}
	public function set xhtmlText		(s: String) : Void{
		base.htmlText = (s.indexOf("&lt;")<0)?s:s.split("&lt;").join("<").split("&gt;").join(">").split("&apos;").join("'").split("&quot;").join('"');
		onChanged();//&apos;
	}
	public function set length 			(n: Number)	: Void{base.length= n;}
	public function set maxChars 		(n: Number)	: Void{base.maxChars= n;}
	public function set maxhscroll		(n: Number)	: Void{base.maxhscroll= n;}
	public function set maxscroll 		(n: Number)	: Void{base.maxscroll= n;}
	public function set multiline 		(b: Boolean): Void{base.multiline= b;}
	public function set password 		(b: Boolean): Void{base.password= b;}
	public function set restrict 		(s: String)	: Void{base.restrict=s;}
	public function set scroll 			(n: Number)	: Void{base.scroll= n;}
	public function set selectable 		(b: Boolean): Void{base.selectable= b;}
	public function set tabEnabled 		(b: Boolean): Void{base.tabEnabled= b;}
	public function set tabIndex 		(n: Number)	: Void{base.tabIndex= n;}
	public function set text 			(s: String)	: Void{
		base.text=s;
		onChanged();
	}
	public function set textColor 		(n: Number)	: Void{base.textColor= n;}
	public function set textHeight 		(n: Number)	: Void{base.textHeight= n;}
	public function set textWidth 		(n: Number)	: Void{base.textWidth= n;}
	public function set type 			(s: String)	: Void{base.type=s;}
	public function set variable 		(s: String)	: Void{base.variable=s;}
	public function set wordWrap 		(b: Boolean): Void{base.wordWrap = b;}
	public function set mouseWheelEnabled(b: Boolean): Void{base.mouseWheelEnabled = b;}
	public function set styleSheet 		(s: StyleSheet): Void{base.styleSheet =s;}

	// Flash 8
	public function get antiAliasType() : String{return base.antiAliasType;}
	public function get gridFitType() : String{return base.gridFitType;}
	public function get sharpness() : Number{return base.sharpness;}
	public function get thickness() : Number{return base.thickness;}

	public function set antiAliasType(s : String):Void{base.antiAliasType=s;}
	public function set gridFitType(s : String):Void{base.gridFitType=s;}
	public function set sharpness(n : Number):Void{base.sharpness=n;}
	public function set thickness(n : Number):Void{base.thickness=n;}

	public function replaceText(beginIndex : Number,endIndex : Number,newText : String) : Void{
		base.replaceText(beginIndex, endIndex, newText);
	}

	public function replaceSel(newText : String) : Void{
		base.replaceSel(newText);	
	}

	public function getTextFormat(beginIndex : Number,endIndex : Number) : TextFormat{
		return base.getTextFormat(beginIndex, endIndex);
	}

	public function setTextFormat() : Void{
		base.setTextFormat();
	}
	
	public function removeTextField() : Void{
		base.removeTextField();
	}

	public function getNewTextFormat() : TextFormat{
		return base.getNewTextFormat();
	}
	
	public function setNewTextFormat(tf : TextFormat) : Void{
		base.setNewTextFormat(tf);
	}
	
	public function getDepth() : Number{
		return base.getDepth();
	}

	public static function getFontList() : Array{
		return TextField.getFontList();
	}

	private function onChanged() : Void{
		dispatchEvent(new TextEvent(currentTarget,TextEvent.CHANGE,this,""));
	}

	private function onKillFocus(newFocus : Object) : Void{
		dispatchEvent(new FocusEvent(currentTarget,FocusEvent.FOCUS_OUT, this, newFocus));
	}

	private function onScroller() : Void{
		dispatchEvent(new TextEvent(currentTarget,TextEvent.SCROLL, this, ""));
	}

	private function onSetFocus(oldFocus : Object) : Void{
		dispatchEvent(new FocusEvent(currentTarget,FocusEvent.FOCUS_IN, this, oldFocus));
	}
	
	public function toTextField() : TextField {		return base;
	}
}
