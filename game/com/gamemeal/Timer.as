import mx.utils.Delegate;

import com.gamemeal.TimerEvent;
import com.mixmedia.mx.events.AbstractEventDispatcher;

/**
 * @author colin
 */
class com.gamemeal.Timer extends AbstractEventDispatcher{
	private var limit:Number = 30000;
	private var iid : Number;
	private var startTime:Number=0;

	public function Timer(limit:Number){
		this.limit = limit;
	}

	public function start():Void{
		startTime = getTimer();

		clearInterval(iid);
		iid = setInterval(Delegate.create(this,loop),500);
		dispatchEvent(new TimerEvent(this, TimerEvent.START));
		loop();
	}

	private function loop() : Void {
		dispatchEvent(new TimerEvent(this,TimerEvent.CHANGE));
		if(getTimer()-startTime>=limit){
			dispatchEvent(new TimerEvent(this, TimerEvent.TIMEUP));
			stop();
			clearInterval(iid);
		}
	}

	public function resume():Void{
		clearInterval(iid);
		iid = setInterval(Delegate.create(this,loop),500);
	}

	public function stop():Void{
		clearInterval(iid);
		dispatchEvent(new TimerEvent(this, TimerEvent.STOP));
	}

	public function get time():Number{
		return getTimer()-startTime;
	}
	
	public function get countDown():Number{
		var left:Number = limit-(getTimer()-startTime);
		if(left<0)left = 0;
		return left;
	}
}
