/**
 * @author colin
 */
import mx.transitions.easing.Regular;class com.mixmedia.view.ToolTips {
	static private var ins:ToolTips;	static public function instance():ToolTips{		if(ins==null)ins = new ToolTips();		return ins;	}	private var txf:TextField;	private var base : MovieClip;	private var motion : Motion;
	public function ToolTips(){}		public function setClip(base:MovieClip,txf:TextField):Void{		this.base = base;		this.txf = txf;		motion = new Motion(base,{dur:5,tweenMethod:Regular.easeOut});		}	public function show(msg:String,x:Number,y:Number):Void{		x = (x==null)?base._parent._xmouse:x;		y = (y==null)?base._parent._ymouse:y;				txf.text = msg;		base._x = x;		base._y = y;		motion.startTween({a:100,x:x,y:y});	} 	public function hide():Void{		motion.startTween({a:0,x:base._x,y:base._y});	}
}