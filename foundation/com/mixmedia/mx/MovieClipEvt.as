﻿/** * @author colin */import mx.utils.Delegate;import com.mixmedia.mx.DisplayObject;import com.mixmedia.mx.events.Event;import com.mixmedia.mx.events.MouseEvent;class com.mixmedia.mx.MovieClipEvt extends DisplayObject implements IDisplayObject,IFASTEventDispatcher,IEventDispatcher{	private var base:MovieClip;	private var tracker:MovieClip;	private var isOver:Boolean = false;		public function MovieClipEvt(base:MovieClip,isCheckRollOver:Boolean,isCheckEnterFrame:Boolean){		isCheckRollOver  = (isCheckRollOver==null)?true:isCheckRollOver;		isCheckEnterFrame= (isCheckEnterFrame==null)?true:isCheckEnterFrame;		this.base = base;		tracker = base.createEmptyMovieClip('_mxmEventTracker', 30500);		tracker.onUnload = Delegate.create(this,onUnload);		tracker.onMouseDown = Delegate.create(this,onMouseDown);		tracker.onMouseUp = Delegate.create(this,onMouseUp);		if(isCheckRollOver)tracker.onMouseMove = Delegate.create(this,onMouseMove);		if(isCheckEnterFrame)tracker.onEnterFrame = Delegate.create(this,onEnterFrame);	}		private function onEnterFrame() : Void {		dispatchEvent(new Event(this, Event.ENTER_FRAME, base));	}	private function onUnload() : Void {		dispatchEvent(new Event(this, Event.REMOVED_FROM_STAGE,base));	}		private function onMouseDown():Void{		if(base.hitTest(base._parent._xmouse, base._parent._ymouse,true))dispatchEvent(new MouseEvent(this,MouseEvent.MOUSE_DOWN));	}	private function onMouseUp() : Void {		if(base.hitTest(base._parent._xmouse, base._parent._ymouse,true)){			dispatchEvent(new MouseEvent(this,MouseEvent.MOUSE_UP));			dispatchEvent(new MouseEvent(this,MouseEvent.CLICK));		}	}		private function onMouseMove():Void{		var pt:Object = {x:base._xmouse,y:base._ymouse};		base.localToGlobal(pt);		var isHit:Boolean = base.hitTest(pt['x'], pt['y'],true);		if(isHit==true && isOver==false){			dispatchEvent(new MouseEvent(this,MouseEvent.ROLL_OVER));			isOver = isHit;			return;		}				if(isHit==false && isOver==true){			dispatchEvent(new MouseEvent(this,MouseEvent.ROLL_OUT));			isOver = isHit;			return;		}	}		public function getBase() : Object {		return base;	}}