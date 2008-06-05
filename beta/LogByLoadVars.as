import mx.utils.Delegate;

 * @author Colin
 */
class LogByLoadVars {
	private var lv:LoadVAR;
	private var url:String;

	public function LogByLoadVars(url:String){
		this.url = url;
		Navigation.instance().addEventListener(NavigationEvent.CHANGE, Delegate.create(this,log));
		lv = new LoadVAR();
	}

	private function log(e:NavigationEvent):Void{
		if(e.isSuppress==true)return;
		lv.load(url+"?p=" + e.navKey);
	}
}