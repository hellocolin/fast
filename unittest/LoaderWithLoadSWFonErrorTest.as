import mx.utils.Delegate;

import com.mixmedia.mx.MovieClipLoaderEvt;
import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IOErrorEvent;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.ILoader;
import com.mixmedia.net.LoadSWF;
import com.mixmedia.net.Loader;

class LoaderWithLoadSWFonErrorTest extends LoaderTestCase {
	private var className:String = "LoaderWithLoadSWFonErrorTest";

	private var eventType:Object;
	private var instanceType:Object;
	private var targetType:Object;

	private var mcHoldExternalAsset:MovieClip;

	public function LoaderWithLoadSWFonErrorTest(testMethod:String) {
		super(testMethod);
	}

	public function run():Void {
		eventType = LoaderEvent;
		instanceType = Loader;
		targetType = MovieClipLoaderEvt;
		filePath = "failLoad.swf";
		
		mcHoldExternalAsset = _root.createEmptyMovieClip('m12000', 12000);
		instance = new Loader(new LoadSWF(mcHoldExternalAsset));
		instance.addEventListener(LoaderEvent.COMPLETE, Delegate.create(this,resumeTest));
		instance.addEventListener(IOErrorEvent.IO_ERROR, Delegate.create(this,resumeTest));
		instance.load(filePath);
	}
	
	private function resumeTest(e:Event):Void{
		mcHoldExternalAsset.removeMovieClip();
		super.resumeTest(e);
	}

	public function testEventIsError():Void{
		assertTrue("Event must IOErrorEvent:", event instanceof IOErrorEvent == true);
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