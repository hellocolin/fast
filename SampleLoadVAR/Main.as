
/**
 * @author colin
 */
import mx.utils.Delegate;

import com.mixmedia.mx.events.Event;
import com.mixmedia.mx.events.IOErrorEvent;
import com.mixmedia.mx.events.LoaderEvent;
import com.mixmedia.net.LoadVAR;

class Main {
	private var base:MovieClip;
	private var poster  : LoadVAR;
	private var load_lv : LoadVAR;

	public function Main(mc:MovieClip){
		base = mc;

		var path:String = "daxta.txt";
		
		poster = new LoadVAR();
		load_lv = new LoadVAR();
		poster.getBase()['postion'] ='1';
		poster.getBase()['gardenId']='18283';
		poster.getBase()['userId']  ='5444';
		load_lv.addEventListener(LoaderEvent.COMPLETE,  Delegate.create(this,display));
		load_lv.addEventListener(IOErrorEvent.IO_ERROR, Delegate.create(this,onError));	
		poster.sendAndLoad(path, load_lv, "post");
	}
	
	private function display(e:LoaderEvent) : Void {
		trace(LoadVAR(e.currentTarget).getBase()['result']);
	}
	
	private function onError():Void{
		trace('load Error');
	}
}
