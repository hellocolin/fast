
/**
 * @author colin
 */
import flash.external.ExternalInterface;

import com.mixmedia.navigation.DeepLinking;

class TestSWFAddress {
	private var base : MovieClip;
	private var txfResp:TextField;
	private var txtCall:TextField;
	
	public function TestSWFAddress(base:MovieClip){
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		this.base = base;
		
		txtCall = base['txtCall'];
		txfResp = base['txfResp'];
		DeepLinking.instance();	
	}
	
	public function test():Void{
		var returnValue:String = String(ExternalInterface.call(txtCall.text));
		if(returnValue=='null'){
			returnValue += "\nplease check security setting";
			if(System.capabilities.playerType == 'ActiveX')returnValue +="\nplease check the movie name in html is assigned";
		}
		if(returnValue=='undefined'){
			returnValue += "are you sure the function "+txtCall.text +" added to html?";
		}
		txfResp.text = returnValue;
	}
}
