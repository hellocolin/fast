import com.gamemeal.Timer;
import com.gamemeal.TimerEvent;
import com.gamemeal.cardMatch.Card;
import com.gamemeal.cardMatch.CardEvent;
import com.gamemeal.cardMatch.CardMatchGame;
import com.gamemeal.cardMatch.CardMatchGameEvent;
import com.mixmedia.mx.events.MouseEvent;
import com.mixmedia.utils.ArrayUtils;

/**
 * @author colin
 */
class Main {
	private var game:CardMatchGame;
	private var col:Number = 4;
	private var row:Number = 4;
	private var base : MovieClip;
	private var timer : Timer;
	private var hideStartButton:Motion;
	private var products:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];
	private var iid : Number;

	public function Main(mc:MovieClip){
		base = mc;
		game = new CardMatchGame(col,row,2);
		game.addEventListener(CardMatchGameEvent.MATCH, Fix.ref(this,match));
		game.addEventListener(CardMatchGameEvent.NOTMATCH, Fix.ref(this,notMatch));
		game.addEventListener(GameEvent.WIN, Fix.ref(this,win));

		hideStartButton = new Motion(base['btnStart'],{dur:10,a:0});
		ButtonClip(base['btnStart']).when(MouseEvent.CLICK, this, start);
		TimeupPanel(base['timeupPanel']).addEventListener(MouseEvent.CLICK,Fix.ref(this, start));
		
		timer = new Timer(30000);
		timer.addEventListener(TimerEvent.TIMEUP, Fix.ref(this,gameover));
		timer.addEventListener(TimerEvent.CHANGE, Fix.ref(this,updateTimerView));
		
		demo();
	}
	
	private function demo():Void{
		ArrayUtils.suffle(products);
		game.start();
		bindView();
		clearInterval(iid);
		iid = setInterval(Fix.ref(this,demoLoop),1000);
	}
	
	private function demoLoop():Void{
		var card:Card = game.getCard(random(col), random(row));
		card.isOpen?card.close():card.open();
	}
	
	private function updateTimerView() : Void {
		TimerView(base['mcTimer']).move();
		TimerView(base['mcTimer']).setTime(timer.countDown);
	}

	private function gameover() : Void {
		TimeupPanel(base['timeupPanel']).show();
	}

	private function bindView():Void{
		for(var y:Number=0;y<row;y++){
			for(var x:Number=0;x<col;x++){
				//bind each card to cardview
				var view:CardView = CardView(base['card$'+x+'_'+y]);
				view.reset();
				view.setId(products[Number(game.getCard(x, y).id)]);
				game.getCard(x, y).addEventListener(CardEvent.OPEN, Fix.ref(view,view.open));
				game.getCard(x, y).addEventListener(CardEvent.CLOSE, Fix.ref(view,view.close));
				CardView(base['card$'+x+'_'+y]).when('click', this, select);
			}
		}	
	}

	private function start():Void{
		clearInterval(iid);
		TimeupPanel(base['timeupPanel']).hide();
		hideStartButton.startTween();

		timer.start();
		game.start();
		ArrayUtils.suffle(products);
		bindView();

		debug();
	}

	private function debug():Void{
		for(var y:Number=0;y<row;y++){
			var str:String = '';
			for(var x:Number=0;x<col;x++){
				str+= game.getCard(x, y).id+',';
			}
			trace(str);
		}
	}
	
	private function win() : Void {
		timer.stop();
		getURL('form.php');
	}

	private function notMatch() : Void {
//		trace('not match');
	}

	private function match() : Void {
//		trace('match');
	}

	private function select(e:MouseEvent):Void {
		var id:String = ButtonClip(e.currentTarget)._name.split("$")[1];
		game.open(Number(id.split('_')[0]), Number(id.split('_')[1]));
	}
}
