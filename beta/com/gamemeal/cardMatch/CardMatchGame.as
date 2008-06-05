﻿/**
import com.gamemeal.cardMatch.Card;
import com.gamemeal.cardMatch.CardMatchGameEvent;
import com.mixmedia.mx.events.AbstractEventDispatcher;
import com.mixmedia.utils.ArrayUtils;

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
	
	public function start():Void{
		openedCards = [];
		for(var i:Number = 0;i<row*col/match;i++){
			for(var j:Number=0;j<match;j++){
				cards.push(new Card(i.toString()));
			}
		}
	}
	
	public function open(x:Number,y:Number):Void{
		getCard(x,y).open();
		openedCards.push(getCard(x,y));
		if(openedCards.length==1)return;

		if(checkMatch()==false){
			dispatchEvent(new CardMatchGameEvent(this,CardMatchGameEvent.NOTMATCH));
			return;
		}

		if(openedCards.length>=match){
			openedCards=[];
		}
	}

	private function checkMatch():Boolean{
		for(var i:Number=1;i<openedCards.length;i++){
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