import com.mixmedia.motion.MotionTweenIterator;import com.mixmedia.motion.TweenControl;import com.mixmedia.mx.events.AbstractEventDispatcher;import com.mixmedia.mx.events.Event; /**	
@class  MotionTween
	@package com.mixmedia.motion
	@author Colin Leung
	@param mc:MovieClip,obj:Object
	@return Boolean
	version 1.0 motion tween class, tween method compatible to robertpenner's easing.
	version 1.2 remove initX,initY,etc. targetMC change to target_mc. tween when needed. tweenUID within 0-65536. optimize initized speed to 0.9ms
	version 1.3 multiple tween can run in same time, setTargetProps(), initObject, feedbackFunction,quality added.
	version 1.4 fix tween ID
	version 1.5 isNeedTween function update
	version 1.6 ignore call same function again.
	version 2.0 rewrite it.
	version 2.1 add back force run.
	version 2.2 
	version 2.3 direct set target properties during startTween;
	version 2.3.1 fix error on replay in test movie.
	version 2.3.2 fix bug after loadMovie,(tween control deleted)
	version 2.3.3 optimize speed of tweenCode
	version 2.4 added gotoAndPlay motion object.
	version 2.4.1 added setDefaultProps();
	version 2.5 add event replace onTweenEnd;
	version 2.5.1 correct private function and public function
	version 2.5.2 add noScale propertie.
	version 2.5.3 not accept startTween if tweening.
	version 2.5.4 seperate every properties with different tween method.
	version 2.5.5 change forceRun to response
	version 2.6 update iterator
	version 2.7 use Event obj
*/

class com.mixmedia.motion.MotionTween extends AbstractEventDispatcher{
	private var target_mc:MovieClip; 
	private var dx:Number,dy:Number,dr:Number,dxs:Number,dys:Number,dcra:Number,dcrb:Number,dcga:Number,dcgb:Number,dcba:Number,dcbb:Number,dcaa:Number,dcab:Number;

	private var time:Number;
	private var beginX:Number;
	private var beginY:Number;
	private var beginR:Number;
	private var beginXS:Number;
	private var beginYS:Number;
	private var beginC:Object;
	private var delay:Number;

	public var dur:Number = 10;
	public var tweenDelay:Number = 0;
	public var targetX:Number;
	public var targetY:Number;
	public var targetR:Number;
	public var targetXS:Number;
	public var targetYS:Number;
	public var targetC:Object;
	public var response:Boolean;
	public var fixTweenID:Boolean;
	public var goFrame:String="";
	public var indTweenMethod:Array;
	
	public var MTID:Number;//motiontween ID
	private var colorNeedTween:Boolean;	
	private var iterator:MotionTweenIterator;
	private var mcProxy:TweenControl;
	
	public function MotionTween(mc:MovieClip,obj:Object) {//constructor
		if(mc==undefined){
			trace('motiontween require movieclip');
			return;
		}
		iterator = MotionTweenIterator.instance();	
		target_mc = mc;
		MTID = iterator.getMotionID();
		//add common tweening control to tweenControl array.
		//to force iterator only run count of movieclip, not count of MT.
		mcProxy = iterator.getTweenControl(target_mc);
		//default value
		setDefaultProps();
		if(obj!=undefined)setTargetProps(obj);
		indTweenMethod = new Array();
	};

	//tween method for different properties.
	public function indTweenMethodCode(prop:String,t:Number, b:Number, c:Number, d:Number):Number{
		return (typeof(indTweenMethod[prop])=='function')?indTweenMethod[prop](t,b,c,d):tweenMethod(t,b,c,d);
	}
	private function setDeltaValues() : Void {
		dx=targetX-beginX;
		dy=targetY-beginY;
		dr=targetR-beginR;
		dxs=targetXS-beginXS;
		dys=targetYS-beginYS;
		dcra=targetC['ra']-beginC['ra'];
		dcrb=targetC['rb']-beginC['rb'];
		dcga=targetC['ga']-beginC['ga'];
		dcgb=targetC['gb']-beginC['gb'];
		dcba=targetC['ba']-beginC['ba'];
		dcbb=targetC['bb']-beginC['bb'];
		dcaa=targetC['aa']-beginC['aa'];
		dcab=targetC['ab']-beginC['ab'];
	}
	public function tweenCode():Void{
		if(beginX!=targetX)target_mc._x = indTweenMethodCode('x',time,beginX,dx,dur);
		if(beginY!=targetY)target_mc._y = indTweenMethodCode('y',time,beginY,dy,dur);
		if(beginR!=targetR)target_mc._rotation = indTweenMethodCode('r',time,beginR,dr,dur);
		if(beginXS!=targetXS)target_mc._xscale = indTweenMethodCode('xs',time,beginXS,dxs,dur);
		if(beginYS!=targetYS)target_mc._yscale = indTweenMethodCode('ys',time,beginYS,dys,dur);
		if(colorNeedTween!=0){
			if(colorNeedTween==2){
				target_mc._alpha=indTweenMethodCode('c',time,beginC['aa'],dcaa,dur);
			}else{
				mcProxy.tweenColor.setTransform({ra:indTweenMethodCode('c',time,beginC['ra'],dcra,dur),ga:indTweenMethodCode('c',time,beginC['ga'],dcga,dur),ba:indTweenMethodCode('c',time,beginC['ba'],dcba,dur),aa:indTweenMethodCode('c',time,beginC['aa'],dcaa,dur),rb:indTweenMethodCode('c',time,beginC['rb'],dcrb,dur),gb:indTweenMethodCode('c',time,beginC['gb'],dcgb,dur),bb:indTweenMethodCode('c',time,beginC['bb'],dcbb,dur),ab:indTweenMethodCode('c',time,beginC['ab'],dcab,dur)});
			}
		}
		dispatchEvent(new Event(this,Event.TWEENING));//{target:this,type:'onTween'});
		time++;
		if(time>dur){
			killTween();
			onTweenEnd();
		}
	}

	private function clearDelayInterval():Void{
		var i:Number;
		var totalDelayInterval:Number = mcProxy.delayInterval_array.length;
		for(i=0;i<totalDelayInterval;i++){
			clearInterval(mcProxy.delayInterval_array[i]);
		}
	}

	public function isTweening():Boolean{
		return mcProxy.isTweening;
	}

	public function startTween(obj:Object):Boolean{//speed 1.54		//if target props same and response!=true, return false		if(isTargetPropsSameAsPrevious(obj)==true && response!=true)return false;
		if(obj!=undefined)setTargetProps(obj);		if(mcProxy.isTweening&&response==false)return false;
		//v2.3 set target properties if arguments presents
		//stop tween running
		killTween();
		//create timeout for tweenDelay.
		if(mcProxy.isTweening == true){
			if(iterator.tweenArray[mcProxy.motionMCID].MTID!=MTID){
				clearDelayInterval();
				mcProxy.delayInterval_array.push(setInterval(this,"initTween", tweenDelay));
				return true;
			}
		}else{//ready to tween
			clearDelayInterval();
			mcProxy.delayInterval_array.push(setInterval(this,"initTween", tweenDelay));
			return true;
		}
	};
	private function isTargetPropsSameAsPrevious(obj:Object):Boolean{		if(obj['x']!=null && obj['x']!=targetX)return false;		if(obj['y']!=null && obj['y']!=targetY)return false;		if(obj['r']!=null && obj['r']!=targetR)return false;		if(obj['xs']!=null&& obj['xs']!=targetXS)return false;		if(obj['ys']!=null&& obj['ys']!=targetYS)return false;		if(obj['a']!=null && obj['a']!=targetC['aa'])return false;		if(obj['c']!=null && obj['c']!==targetC)return false;		return true;	}	
	private function initTween():Void{
		clearDelayInterval();
		if(goFrame!=""){
			if(target_mc['goFrame']==null){
				target_mc.gotoAndPlay(goFrame);
			}else{
				target_mc['goFrame'](goFrame);
			}
		}
		if(isNeedTween()){
			onTweenStart();
			setBeginProps();
			setDeltaValues();
			addTween();
			colorNeedTween = isColorNeedTween();
			mcProxy.isTweening = true;
		}
	};

	public function killTween():Void{
		clearDelayInterval();
		removeTween(mcProxy.motionMCID);
		target_mc._visible = (mcProxy.tweenColor.getTransform()['aa'] == 0) || (mcProxy.tweenColor.getTransform()['ab'] == -255)||(target_mc._alpha==0)?false:true;
		mcProxy.isTweening = false;
	};

	public function setBeginProps():Void{
		time = 0;
		beginX = target_mc._x;
		beginY = target_mc._y;
		beginR = target_mc._rotation;
		beginXS = target_mc._xscale;
		beginYS = target_mc._yscale;
		beginC = mcProxy.tweenColor.getTransform();
	};

	public function setDefaultProps():Void{
		targetX = target_mc._x;
		targetY = target_mc._y;
		targetR = target_mc._rotation;
		targetXS = target_mc._xscale;
		targetYS = target_mc._yscale;
		targetC = mcProxy.tweenColor.getTransform();
	};

	public function setTargetProps(obj:Object):Void{//
		if(mcProxy.isTweening ==true){
			if(iterator.tweenArray[mcProxy.motionMCID].MTID==MTID){
				killTween();
			}
		}
		if(obj['x']!=undefined)targetX=obj['x'];
		if(obj['y']!=undefined)targetY=obj['y'];
		if(obj['r']!=undefined)targetR=obj['r'];
		if(obj['xs']!=undefined)targetXS=obj['xs'];
		if(obj['ys']!=undefined)targetYS=obj['ys'];
		if(obj['targetC']!=undefined)targetC=obj['c'];
		if(obj['c']!=undefined)targetC=obj['c'];
		if(obj['a']!=undefined)targetC['aa']=obj['a'];
		if(obj['dur']!=undefined)dur=obj['dur'];
		if(obj['tweenDelay']!=undefined)tweenDelay=obj['tweenDelay'];
		if(obj['tweenMethod']!=undefined)tweenMethod=obj['tweenMethod'];
		if(obj['onTweenEnd']!=undefined)onTweenEnd=obj['onTweenEnd'];
		if(obj['onTweenStart']!=undefined)onTweenStart=obj['onTweenStart'];
		if(obj['fixTweenID']!=undefined)fixTweenID=obj['fixTweenID'];
		if(obj['response']!=undefined)response=obj['response'];
		if(obj['goFrame']!=undefined)goFrame=obj['goFrame'];

		if(obj['tmx']!=undefined)indTweenMethod['x'] = obj['tmx'];
		if(obj['tmy']!=undefined)indTweenMethod['y'] = obj['tmy'];
		if(obj['tmr']!=undefined)indTweenMethod['r'] = obj['tmr'];
		if(obj['tmxs']!=undefined)indTweenMethod['xs'] = obj['tmxs'];
		if(obj['tmys']!=undefined)indTweenMethod['ys'] = obj['tmys'];
		if(obj['tmc']!=undefined)indTweenMethod['c'] = obj['tmc'];
	};

	private function onTweenEnd():Void{
		dispatchEvent(new Event(this,Event.TWEENEND));//{target:this,type:'onTweenEnd'});
	};

	private function onTweenStart():Void{
		dispatchEvent(new Event(this,Event.TWEENSTART));//{target:this,type:'onTweenStart'});
	};

	private function isNeedTween():Boolean{
		if(response==true)return true;
		if(isColorNeedTween()!=0)return true;
		if(target_mc._x!=targetX)return true;
		if(target_mc._y!=targetY)return true;
		if(target_mc._alpha!=targetC['aa'])return true;
		if(target_mc._rotation!=targetR)return true;
		if(target_mc._xscale!=targetXS)return true;
		if(target_mc._yscale!=targetYS)return true;
		if(target_mc._visible==false)return true;
		return false;
	};

	private function isColorNeedTween():Boolean{
		var output:Number=0;
		var i:Number=0;
		var name:String;
		var nowC:Object = mcProxy.tweenColor.getTransform();
		for (name in nowC) {
			output +=((nowC[name]!=targetC[name])?1:0)<<i;
			i++;
		}
		return output>0;
		//ra rb ga gb ba bb aa ab
	}

	private function addTween():Void{
		var mID:Number = mcProxy.motionMCID;
		iterator.tweenArray[mID] = this;
		target_mc._visible = true;
	};

	private function removeTween(mtID:Number):Void{//arg is motionID
		iterator.tweenArray[mtID] = null;
	};

	public function tweenMethod(t:Number, b:Number, c:Number, d:Number):Number{// t = time, b = begin, c = end , d = duration
		if ((t/=d/2) < 1) return c/2*t*t*t + b;
		return c/2*((t-=2)*t*t + 2) + b;
	};

}