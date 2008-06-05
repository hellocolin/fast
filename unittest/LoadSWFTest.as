import mx.utils.Delegate;

import com.mixmedia.mx.MovieClipLoaderEvt;
import com.mixmedia.mx.events.ErrorEvent;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.LoadSWF;

class LoadSWFTest extends LoaderTestCase {
	private var className:String = "LoadSWFTest";

	private var eventType:Object;
	private var instanceType:Object;
	private var targetType: Object;
	private var mcHoldExternalAsset : MovieClip;

	public function LoadSWFTest(testMethod:String) {
		super(testMethod);
	}

	public function run():Void {
		eventType = LoaderEvent;
		instanceType = LoadSWF;
		targetType = MovieClipLoaderEvt;
		filePath = "http://www.colvia.com/FAST/test.swf";
		
		mcHoldExternalAsset = _root.createEmptyMovieClip('m10006', 10006);
		instance = new LoadSWF(mcHoldExternalAsset);
		instance.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,resumeTest));
		instance.addEventListener(ErrorEvent.ERROR, Delegate.create(this,resumeTest));
		instance.load(filePath);
	}

	private function resumeTest(e:Event):Void{
		mcHoldExternalAsset.removeMovieClip();
		super.resumeTest(e);
	}

	public function testEventNotError():Void{
		super.testEventNotError();
	}
	
	public function testEventIsLoaderEvent():Void{
		super.testEventIsLoaderEvent();
	}
	
	public function testEventCurrentTargetIsSameClassOfInstance():Void{
		super.testEventCurrentTargetIsSameClassOfInstance();
	}

	public function testEventCurrentTargetMustSameAsInstance():Void{
		super.testEventCurrentTargetMustSameAsInstance();
	}

	public function testEventTarget():Void{
		super.testEventTarget();
	}
	
	public function testEnd():Void{
		super.testEnd();
	}
}