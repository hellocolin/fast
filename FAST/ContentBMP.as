﻿import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.geom.Matrix;

import com.mixmedia.motion.MotionTween;
import com.mixmedia.mx.StageEvt;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.navigation.Navigation;
import com.mixmedia.navigation.NavigationEvent;
import com.mixmedia.net.LoadSWF;
import com.mixmedia.view.net.Loader;

/**
 * @author Colin
 */
class ContentBMP extends MovieClip implements IEventDispatcher, IFASTEventDispatcher{
	private var frozenPic:Bitmap;
	private var loader:Loader;
	private var prefix:String;
	private var currentNavKey:String;
	private var fadein:MotionTween;
	private var fadeout:MotionTween;
	private var targetName: String;	private var extension : String;
	public function ContentBMP(){
		var base:MovieClip = this;
	
		loader = new Loader(new LoadSWF(base));
		loader.setPreloader(base);
		loader.setErrorIcon(base);
		loader.when(LoaderEvent.READY, this,onLoadContentAndFadeIn);

		var para:Array = base._name.split('$');
		targetName	= para[1]==null?"":para[1];
		prefix		= para[2]==null?"":para[2];
		extension   = para[3]==null?"swf":para[3];

		frozenPic = new Bitmap(base,null,PixelSnapping.NEVER,false);

		fadein  = new MotionTween(MovieClip(loader.getTargetContainer()),{a:100});
		fadeout = new MotionTween(frozenPic.toMovieClip(),{a:0});
		fadeout.when(Event.TWEENEND, this, onFadeOutAndLoad);

		var n:Navigation = Navigation.instance();
		n.when(NavigationEvent.CHANGE, this,onNavChange);
	}

	private function onNavChange(e:NavigationEvent):Void{
		//if targetName is empty, load only 
		var navTargetIsEmpty:Boolean = (e.targetContainer==""||e.targetContainer==null);
 		var criteria1:Boolean = (targetName==""&&navTargetIsEmpty);
 		var criteria2:Boolean = (navTargetIsEmpty==false&&e.targetContainer==targetName);
		if(criteria1==false&&criteria2==false)return;

		currentNavKey = e.navKey;
		transitionOut();
	}

	private function transitionOut():Void{
		var s:StageEvt = StageEvt.instance();
		var tmx:Matrix = new Matrix(1,0,0,1,0,0);

		var bd:BitmapData = new BitmapData(s.width, s.height, true, 0);
		bd.draw(MovieClip(loader.getTargetContainer()),tmx);
//		bd.applyFilter(bd, bd.rectangle, new Point(0,0), new BlurFilter(5,5,3));

		frozenPic.bitmapData = bd;
		MovieClip(loader.getTargetContainer()).unloadMovie();
		MovieClip(loader.getTargetContainer())._alpha=0;
		frozenPic.toMovieClip()._alpha=100;
		fadeout.startTween();
	}

	private function onFadeOutAndLoad():Void {
		loadAction();
	}

	private function onLoadContentAndFadeIn():Void{
		if(Navigation.instance().getNavStackRequests()!=null)Navigation.instance().nextSection();
		fadein.startTween();
	}

	private function loadAction():Void{
		loader.load(prefix+currentNavKey+"."+extension);	
	}

	public function addEventListener(event : String, handler : Function) : Void {
		loader.addEventListener(event, handler);
	}
	
	public function removeEventListener(event : String, handler : Function) : Void {
		loader.removeEventListener(event, handler);
	}
	
	public function setCurrentTarget(currentTarget : Object) : Void {
		loader.setCurrentTarget(currentTarget);
	}
	
	public function when(eventType : String, whichObject : Object, callFunction : Function) : Void {
		loader.when(eventType, whichObject, callFunction);
	}
}
