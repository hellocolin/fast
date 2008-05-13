/** * @author colin */import com.gamemeal.cardMatch.Card;import com.gamemeal.cardMatch.CardMatchGameEvent;import com.mixmedia.mx.events.AbstractEventDispatcher;
class com.gamemeal.cardMatch.CardMatchGame extends AbstractEventDispatcher {
	private var row : Number;
	private var col : Number;
	private var match : Number;
	private var cards:Array;
	private var openedCards:Array;

	public function CardMatchGame(row:Number,col:Number,match:Number){
		this.row = row==null?4:row;
		this.col = col==null?4:col;
		this.match=match==null?2:match;
		if(row*col%match!=0)trace('card counts cannot divided by matches');
	}
	
	public function start():Void{		cards = [];
		openedCards = [];
		for(var i:Number = 0;i<row*col/match;i++){
			for(var j:Number=0;j<match;j++){
				cards.push(new Card(i.toString()));
			}
		}		suffleCards();		dispatchEvent(new GameEvent(this,GameEvent.START));
	}
	
	public function open(x:Number,y:Number):Void{
		getCard(x,y).open();
		openedCards.push(getCard(x,y));
		if(openedCards.length==1)return;

		if(checkMatch()==false){			closeCards();
			dispatchEvent(new CardMatchGameEvent(this,CardMatchGameEvent.NOTMATCH));
			return;
		}

		if(openedCards.length>=match){			dispatchEvent(new CardMatchGameEvent(this,CardMatchGameEvent.MATCH));			
			openedCards=[];
		}		//check is all card opened		for(var i:Number=0;i<cards.length;i++){			if(Card(cards[i]).isOpen==false)return;		}		dispatchEvent(new GameEvent(this,GameEvent.WIN));
	}
	public function getCard(x:Number,y:Number):Card{		return cards[y*col+x];	}	
	private function checkMatch():Boolean{
		for(var i:Number=1;i<openedCards.length;i++){			if(Card(openedCards[i]).id != Card(openedCards[i-1]).id){
				return false;
			}
		}
		return true;
	}

	private function closeCards():Void{
		for(var i:Number=0;i<openedCards.length;i++){
			Card(openedCards[i]).close();
		}
		openedCards=[];
	}

	private function suffleCards() : Void {
		var nLength:Number,nRandom:Number,temp:Array,i:Number;
		nLength = cards.length;
		for (i = 0; i < nLength; i++) {
			nRandom = Math.floor(Math.random()*nLength);
			temp = cards[i];
			cards[i] = cards[nRandom];
			cards[nRandom] = temp;
		}
	}}