import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.mx.events.Event;

/**
 * @author colin
 */
class Timer extends AbstractEventDispatcher{
	private var limit:Number = 30000;
	private var iid : Number;
	private var startTime:Number=0;

	public function Timer(limit:Number){
		this.limit = limit;
	}
	
	public function start():Void{
		startTime = getTimer();

		clearInterval(iid);
		iid = setInterval(Fix.ref(this,loop),500);
		dispatchEvent(new Event(this, Event.START));
		loop();
	}
	
	private function loop() : Void {
		dispatchEvent(new Event(this,Event.CHANGE));
		if(getTimer()-startTime>=limit){
			dispatchEvent(new Event(this, Event.COMPLETE));
			stop();
			clearInterval(iid);
		}
	}
	
	public function resume():Void{
		clearInterval(iid);
		iid = setInterval(Fix.ref(this,loop),500);
	}

	public function stop():Void{
		clearInterval(iid);
		dispatchEvent(new Event(this, Event.STOP));
	}

	public function get time():Number{
		return getTimer()-startTime;
	}
	
	public function get countDown():Number{
		return limit-(getTimer()-startTime);
	}
}
