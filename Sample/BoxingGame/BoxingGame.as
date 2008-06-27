import mx.utils.Delegate;

import com.mixmedia.mx.events.AbstractEventDispatcher;

/**
 * @author colin
 */
class BoxingGame extends AbstractEventDispatcher {
	private var playerCount : Number;
	private var player1:Boxer;
	private var player2:Boxer;
	
	public function BoxingGame(player1:Boxer,player2:Boxer){
		this.player1 = player1;
		this.player2 = player2;
		player1.addEventListener(BoxerEvent.ATTACK, Delegate.create(this,rule));
		player1.addEventListener(BoxerEvent.ATTACK, Delegate.create(this,rule));
	}
	
	private function rule(e:BoxerEvent):Void{
		var testPlayer:Boxer = (e.target == player1)?player2:player1;
		testPlayer.hit(e.position);
	}
}