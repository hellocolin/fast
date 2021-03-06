﻿import flash.display.BitmapData;

import mx.utils.Delegate;

import com.mixmedia.mx.MovieClipLoaderEvt;
import com.mixmedia.mx.events.LoaderEvent;

/** * @author colin */class com.mixmedia.net.LoadIMG implements ILoader, IFASTEventDispatcher{	private var mcImageLoader:MovieClip;	private var mcl:MovieClipLoaderEvt;	private var target:MovieClip;	public function LoadIMG(target:MovieClip){		if(target==undefined)trace('com.mixmedia.net.LoadBMP require target movieclip');		this.target = target;		mcImageLoader = target.createEmptyMovieClip("mcImageLoader",10);		mcl = new MovieClipLoaderEvt();		mcl.setCurrentTarget(this);		mcl.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,onComplete));	}		public function load(requestURL:String):Void {		mcImageLoader.unloadMovie();		mcl.loadClip(requestURL,mcImageLoader);	}		private var doNextFrameMC:MovieClip;	private function onComplete():Void{		doNextFrameMC = mcImageLoader.createEmptyMovieClip('doNextFrameMC', 20000);		doNextFrameMC.onEnterFrame = Delegate.create(this,draw);	}	private function draw():Void{		var b:BitmapData = new BitmapData(mcImageLoader._width,mcImageLoader._height);		b.draw(mcImageLoader);		mcImageLoader.attachBitmap(b,10000,'auto',true);		doNextFrameMC.removeMovieClip();	}	public function getTargetContainer() : Object {		return mcImageLoader;	}	public function addEventListener(event : String, handler:Function) : Void {		mcl.addEventListener(event,handler);	}	public function removeEventListener(event : String, handler:Function) : Void {		mcl.removeEventListener(event, handler);	}		public function setCurrentTarget(currentTarget : Object) : Void {		mcl.setCurrentTarget(currentTarget);	}		public function unload() : Void {		mcImageLoader.unloadMovie();	}
	
	public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {
		this.addEventListener(eventType, Delegate.create(whichObject,callFunction));
	}}