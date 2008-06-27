
/**
 * @author colin
 */
class MCScore extends MovieClip {
	private var txt:TextField;
	
	public function MCScore(){
		txt.text = "";
	}
	
	public function showScore(score:Number):Void{
		gotoAndPlay('show');
		var grade:String;
		if(score<20){
			grade = "成績強差人意, 請再接再厲啦!";
		}else if(score<40){
			grade = "成績麻麻, 請再接再厲啦!";
		}else if(score<60){
			grade = "成績一般, 請再接再厲啦!";
		}else if(score<80){
			grade = "成績不錯, 請繼續挑戰下一個遊戲啦!";
		}else{
			grade = "成績傑出, 請繼續挑戰下一個遊戲啦!";
		}
		txt.text = grade;
	}
}
