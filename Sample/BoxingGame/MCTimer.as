
/**
 * @author colin
 */
import com.gamemeal.Timer;
import com.gamemeal.TimerEvent;
import com.mixmedia.mx.events.Event;

class MCTimer extends MovieClip{
	private var txt:TextField;
	
	public function onTimerEvent(e:TimerEvent):Void{
		txt.text = String(Math.round(Timer(e.currentTarget).countDown/1000));
	}
}
