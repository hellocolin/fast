
/**
 * @author colin
 */
class utils.CSSColor {
    private var _color:Number=0;
    private var _alpha:Number=1;

    public static var aqua:String = "#00FFFF";
    public static var black:String = "#000000";
    public static var blue:String = "#0000FF";
    public static var fuchsia:String = "#FF00FF";
    public static var gray:String = "#808080";
    public static var green:String = "#008000";
    public static var lime:String = "#00FF00";
    public static var maroon:String = "#800000";
    public static var navy:String = "#000080";
    public static var olive:String = "#808000";
    public static var purple:String = "#800080";
    public static var red:String = "#FF0000";
    public static var silver:String = "#C0C0C0";
    public static var teal:String = "#008080";
    public static var white:String = "#FFFFFF";
    public static var yellow:String = "#FFFF00";

    public function CSSColor(str:String){
            //rgb(255,221,0), rgba(255,255,255,1), #FFFFFF
            if(str.indexOf('#')!=-1){
                    _color = parseInt("0x"+str.substr(1,6));
                    _alpha = 1;
            }else
            if(str.indexOf('rgb(')!=-1){
                    _color = decStrToHexColor(str.substring(4,str.length-1).split(","));
                    _alpha = 1;
            }else
            if(str.indexOf('rgba(')!=-1){
                    var components:Array = str.substring(5, str.length-1).split(",");
                    _color = decStrToHexColor(components);
                    _alpha = components[3];
            }else{
                    str = str.toLowerCase();
                    try{
                            _color = parseInt("0x"+this[str].substr(1,6));
                            _alpha =1;
                    }catch(e:Error){
                            _color = 0x000000;
                            _alpha = 1;
                    }
            }
    }

    private function decStrToHexColor(components:Array):Number{
            //255,255,0
            var cr:Number = Number(components[0])<<16;
            var cg:Number = Number(components[1])<<8;
            var cb:Number = Number(components[2]);
            return cr+cg+cb;
    }

    public function get color():Number{
            return _color;
    }

    public function get alpha():Number{
            return _alpha;
    }

    public function get rgba():Number{
            return _color<<8 + Math.round(_alpha*255);
    }
}
