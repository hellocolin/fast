﻿import com.mixmedia.motion.MotionTween;
import com.mixmedia.utils.Conversion;
/** * @author colin */class Motion extends MotionTween{	public static function getTransform(x:Number,y:Number,xs:Number,ys:Number,r:Number,c:Number,a:Number):Object{		var rt:Object = new Object();		if(x!=null)rt['x']=x;		if(y!=null)rt['y']=y;		if(xs!=null)rt['xs']=xs;		if(ys!=null)rt['ys']=ys;		if(r!=null)rt['r']=r;				if(c!=null||a!=null){			rt['c'] = Conversion.hexToColor(c==null?-1:c,a==null?100:a);		}		return rt;	}	public function Motion(mc : MovieClip, obj : Object) {		super(mc, obj);	}}