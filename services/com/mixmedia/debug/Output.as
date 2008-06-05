/**
   @author Colin 
*/

class com.mixmedia.debug.Output {
	private static var currentURL: String;
	private static var domains : Array;

	public static function init(domain:String):Void{
		currentURL = _root._url;
		domains = arguments;
		_global['mtrace'] = Output.t;
		domain = null;
	} 
	
	public static function t(exp:Object):Void{//constructor
		trace(exp);

		var outputString:String = String(exp);
		outputString = '<font face="Courier New" style="font-size: 11px">'+outputString+'<br></font>';

		for(var i:Number=0;i<domains.length;i++){
			if(currentURL.indexOf(domains[i])!=-1){
				getURL("javascript:" + "flDebug=window.open('','flDebug','toolbar=0,width=300,height=300,scrollbars=1,resizable=yes');flDebug.document.write('"+outputString+"')");
				return;
			}
		}
	}
}
