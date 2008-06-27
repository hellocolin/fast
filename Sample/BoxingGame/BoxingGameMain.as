
/**
 * @author colin
 */
import mx.utils.Delegate;

import com.gamemeal.Timer;
import com.gamemeal.TimerEvent;

class BoxingGameMain {
	private var base:MovieClip;
	private var player:Boxer;
	private var computer:Boxer;
	private var score:Number=0;
	//timer
	//game loop
	//visual
	
	public function BoxingGameMain(mc:MovieClip){
		base = mc;
		//model setup
		player  = new Boxer();
		computer= new Boxer();
		var timer:Timer = new Timer(30000);

		//view setup

		var mcPlayer:MCBoxer  = mc['mplayer'];
		var mcComputer:MCBoxer= mc['mcComputer'];
		var mcHitSign:MCBoxer = mc['mcHit'];
		var mcTimer:MCTimer   = mc['mcTimer'];

		//bind
		timer.addEventListener(TimerEvent.CHANGE,     Delegate.create(mcTimer,   mcTimer.onTimerEvent));
		player.addEventListener(BoxerEvent.ATTACK,    Delegate.create(mcPlayer,  mcPlayer.onBoxerEvent));
		computer.addEventListener(BoxerEvent.GUARD,   Delegate.create(mcComputer,mcComputer.onBoxerEvent));
		computer.addEventListener(BoxerEvent.HIT,     Delegate.create(mcHitSign, mcHitSign.onBoxerEvent));
		computer.addEventListener(BoxerEvent.HIT,     Delegate.create(this,hit));
		timer.addEventListener(TimerEvent.TIMEUP,     Delegate.create(this,gameOver));
		

		//init game
		new BoxerKeyboardControl(player);
		new BoxerComputerControl(computer);
		new BoxingGame(player,computer);

		timer.start();
		score = 0;
	}

	private function gameOver():Void{
		player.removeEventListener(BoxerEvent.ATTACK,    Delegate.create(base['mplayer'],     base['mplayer'].onBoxerEvent));
		computer.removeEventListener(BoxerEvent.GUARD,   Delegate.create(base['mcComputer'],  base['mcComputer'].onBoxerEvent));
		computer.removeEventListener(BoxerEvent.HIT,     Delegate.create(base['mcHit'],       base['mcHit'].onBoxerEvent));
		MCScore(base['mcScore']).showScore(score);
		base.gotoAndPlay('gameOver');
	}

	private function attack(e:BoxerEvent):Void{
		trace('player attack' + e.position);
	}

	private function guard(e:BoxerEvent):Void{
		trace('computer guard' + e.position);
	}

	private function hit():Void{
		score++;
	}

	private function missed():Void{
		trace('computer Missed!');
	}
}
