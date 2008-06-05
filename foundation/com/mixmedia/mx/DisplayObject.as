import flash.geom.Point;import flash.geom.Rectangle;import com.mixmedia.mx.events.AbstractEventDispatcher;/** * @author colin */class com.mixmedia.mx.DisplayObject extends AbstractEventDispatcher {	private var base:Object;	private var maskMC:MovieClip;	public function get x()			: Number{return base['_x'];}	public function get y()			: Number{return base['_y'];}	public function get mouseX() 		: Number{return base['_xmouse'];}	public function get mouseY() 		: Number{return base['_ymouse'];}	public function get scaleX() 		: Number{return base['_xscale']/100;}	public function get scaleY() 		: Number{return base['_yscale']/100;}	public function get width() 		: Number{return base['_width'];}	public function get height() 		: Number{return base['_height'];}	public function get alpha() 		: Number{return base['_alpha']/100;}	public function get visible() 		: Boolean{return base['_visible'];}	public function get rotation() 	: Number{return base['_rotation'];}	public function get name() 		: String{return base['_name'];}	public function get parent() 		: MovieClip{return base['_parent'];}	public function get mask()			:MovieClip{return maskMC;}	public function get blendMode()		: String{return base['blendMode'];}	public function get cacheAsBitmap() : Boolean{return base['cacheAsBitmap'];}//	public function get _framesloaded()	: Number{return base['_framesloaded'];}//	public function get _droptarget() 	: String{return base['_droptarget'];}//	public function get _currentframe()	: Number{return base['_currentframe'];}//	public function get _totalframes() 	: Number{return base['_totalframes'];}//	public function get _quality() 		: String{return base['_quality'];}//	public function get _focusrect() 	: Boolean{return base['_focusrect'];}//	public function get _soundbuftime()	: Number{return base['_soundbuftime'];}//	public function get _url() 			: String{return base['_url'];}//	public function get autoSize() 		: Object{return base['autoSize'];}//	public function get background() 	: Boolean{return base['background'];}//	public function get backgroundColor(): Number{return base['backgroundColor'];}//	public function get border() 		: Boolean{return base['border'];}//	public function get borderColor() 	: Number{return base['borderColor'];}//	public function get bottomScroll() 	: Number{return base['bottomScroll'];}//	public function get condenseWhite()	: Boolean{return base['condenseWhite'];}//	public function get embedFonts() 	: Boolean{return base['embedFonts'];}//	public function get hscroll() 		: Number{return base['hscroll'];}//	public function get html() 			: Boolean{return base['html'];}//	public function get htmlText() 		: String{return base['htmlText'];}//	public function get length() 		: Number{return base['length'];}//	public function get maxChars() 		: Number{return base['maxChars'];}//	public function get maxhscroll() 	: Number{return base['maxhscroll'];}//	public function get maxscroll() 	: Number{return base['maxscroll'];}//	public function get multiline() 	: Boolean{return base['multiline'];}//	public function get password() 		: Boolean{return base['password'];}//	public function get restrict() 		: String{return base['restrict'];}//	public function get scroll() 		: Number{return base['scroll'];}//	public function get selectable() 	: Boolean{return base['selectable'];}//	public function get tabEnabled() 	: Boolean{return base['tabEnabled'];}//	public function get tabIndex() 		: Number{return base['tabIndex'];}//	public function get text() 			: String{return base['text'];}//	public function get textColor() 	: Number{return base['textColor'];}//	public function get textHeight() 	: Number{return base['textHeight'];}//	public function get textWidth() 	: Number{return base['textWidth'];}//	public function get type() 			: String{return base['type'];}//	public function get variable() 		: String{return base['variable'];}//	public function get wordWrap() 		: Boolean{return base['wordWrap'];}//	public function get mouseWheelEnabled() : Boolean{return base['mouseWheelEnabled'];}//	public function get styleSheet() 	: StyleSheet{return base['styleSheet'];}	public function set x				(n:Number)	: Void{base['_x'] = n;}	public function set y				(n:Number)	: Void{base['_y'] = n;}	public function set mouseX			(n:Number)	: Void{base['_xmouse']= n;}	public function set mouseY			(n:Number)	: Void{base['_ymouse']= n;}	public function set scaleX			(n:Number)	: Void{base['_xscale']= n*100;}	public function set scaleY			(n:Number)	: Void{base['_yscale']= n*100;}	public function set width 			(n:Number)	: Void{base['_width']= n;}	public function set height			(n:Number)	: Void{base['_height']= n;}	public function set alpha 			(n:Number)	: Void{base['_alpha']= n*100;}	public function set visible 		(b: Boolean): Void{base['_visible']= b;}//	public function set _target 		(s: String)	: Void{base['_target']= s;}	public function set rotation		(n : Number): Void{base['_rotation']= n;}	public function set name			(s: String)	: Void{base['_name']=s;}	public function set parent 			(m: MovieClip): Void{base['_parent']= m;}	public function set mask			(m: MovieClip): Void{base['setMask'](m);maskMC=m;}	public function set blendMode		(s: String) :Void{base['blendMode']=s;}	public function set cacheAsBitmap	(b: Boolean):Void{base['cacheAsBitmap']=b;}//	public function set _framesloaded	(n:Number)	: Void{base['_framesloaded']= n;}//	public function set _droptarget 	(s: String)	: Void{base['_droptarget']=s;}//	public function set _currentframe 	(n:Number)	: Void{base['_currentframe']= n;}//	public function set _totalframes 	(n:Number)	: Void{base['_totalframes']= n;}//	public function set _quality 		(s: String)	: Void{base['_quality']=s;}//	public function set _focusrect 		(b: Boolean): Void{base['_focusrect']= b;}//	public function set _soundbuftime 	(n: Number)	: Void{base['_soundbuftime']= n;}//	public function set _url 			(s: String)	: Void{base['_url']=s;}/*	public function set autoSize 		(o: Object)	: Void{base['autoSize']= o;}	public function set background 		(b: Boolean): Void{base['background']= b;}	public function set backgroundColor	(n: Number)	: Void{base['backgroundColor']= n;}	public function set border 			(b: Boolean): Void{base['border']= b;}	public function set borderColor 	(n: Number)	: Void{base['borderColor']= n;}	public function set bottomScroll 	(n: Number)	: Void{base['bottomScroll']= n;}	public function set condenseWhite 	(b: Boolean): Void{base['condenseWhite']= b;}	public function set embedFonts 		(b: Boolean): Void{base['embedFonts']= b;}	public function set hscroll 		(n: Number)	: Void{base['hscroll']= n;}	public function set length 			(n: Number)	: Void{base['length']= n;}	public function set maxChars 		(n: Number)	: Void{base['maxChars']= n;}	public function set maxhscroll		(n: Number)	: Void{base['maxhscroll']= n;}	public function set maxscroll 		(n: Number)	: Void{base['maxscroll']= n;}	public function set multiline 		(b: Boolean): Void{base['multiline']= b;}	public function set password 		(b: Boolean): Void{base['password']= b;}	public function set restrict 		(s: String)	: Void{base['restrict']=s;}	public function set scroll 			(n: Number)	: Void{base['scroll']= n;}	public function set selectable 		(b: Boolean): Void{base['selectable']= b;}	public function set tabEnabled 		(b: Boolean): Void{base['tabEnabled']= b;}	public function set tabIndex 		(n: Number)	: Void{base['tabIndex']= n;}	public function set textColor 		(n: Number)	: Void{base['textColor']= n;}	public function set textHeight 		(n: Number)	: Void{base['textHeight']= n;}	public function set textWidth 		(n: Number)	: Void{base['textWidth']= n;}	public function set type 			(s: String)	: Void{base['type']=s;}	public function set variable 		(s: String)	: Void{base['variable']=s;}	public function set wordWrap 		(b: Boolean): Void{base['wordWrap'] = b;}	public function set mouseWheelEnabled(b: Boolean): Void{base['mouseWheelEnabled'] = b;}	public function set styleSheet 		(s: StyleSheet): Void{base['styleSheet'] =s;}*/	// Flash 8//	public function get antiAliasType() : String{return base['antiAliasType'];}	public function get filters() : Array{return base['filters'];}//	public function get gridFitType() : String{return base['gridFitType'];}//	public function get sharpness() : Number{return base['sharpness'];}//	public function get thickness() : Number{return base['thickness'];}//	public function set antiAliasType(s : String):Void{base['antiAliasType']=s;}	public function set filters(a : Array):Void{base['filters']=a;}//	public function set gridFitType(s : String):Void{base['gridFitType']=s;}//	public function set sharpness(n : Number):Void{base['sharpness']=n;}//	public function set thickness(n : Number):Void{base['thickness']=n;}	public function getBounds(targetCoordinateSpace : IDisplayObject) : Rectangle {		var bound:Object = base['getBounds'](targetCoordinateSpace);		return new Rectangle(bound['xMin'],bound['yMin'],bound['xMax']-bound['xMin'],bound['yMax']-bound['yMin']);	}		public function getRect(targetCoordinateSpace : IDisplayObject) : Rectangle {		var bound:Object = base['getBounds'](targetCoordinateSpace);		return new Rectangle(bound['xMin'],bound['yMin'],bound['xMax']-bound['xMin'],bound['yMax']-bound['yMin']);	}		public function globalToLocal(point : Point) : Point {		var pt:Point = point.clone();		base['globalToLocal'](pt);		return pt;	}		public function hitTestObject(obj : IDisplayObject) : Boolean {		trace('method not implement: MovieClipEvt.hitTestObject '+obj);		return false;	}		public function hitTestPoint(x : Number, y : Number, shapeFlag : Boolean) : Boolean {		shapeFlag = (shapeFlag==null)?false:shapeFlag;		return base['hitTest'](x,y,shapeFlag);	}		public function localToGlobal(point : Point) : Point {		var pt:Point = point.clone();		base['globalToLocal'](pt);		return pt;	}}