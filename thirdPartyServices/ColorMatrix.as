/**
* ColorMatrix by Grant Skinner. August 8, 2005
* Visit www.gskinner.com/blog for documentation, updates and more free code.
*
* You may distribute this class freely, provided it is not modified in any way (including
* removing this header or changing the package path).
*
* Please contact info@gskinner.com prior to distributing modified versions of this class.
*/

class ColorMatrix extends Array {
	// identity matrix constant:
	private static var IDENTITY_MATRIX:Array = [
		1,0,0,0,0,
		0,1,0,0,0,
		0,0,1,0,0,
		0,0,0,1,0,
		0,0,0,0,1
	];
	private static var LENGTH:Number = IDENTITY_MATRIX.length;
	
	
// initialization:
	public function ColorMatrix(p_matrix:Array) {
		copyMatrix(((p_matrix.length == LENGTH) ? p_matrix : IDENTITY_MATRIX));
	}

// public methods:
	public function adjustHue(p_val:Number):Void {
		p_val = cleanValue(p_val,180)/180*Math.PI;
		if (p_val == 0 || isNaN(p_val)) { return; }
		var cosVal:Number = Math.cos(p_val);
		var sinVal:Number = Math.sin(p_val);
		var lumR:Number = 0.213;
		var lumG:Number = 0.715;
		var lumB:Number = 0.072;
		multiplyMatrix([
			lumR+cosVal*(1-lumR)+sinVal*(-lumR),lumG+cosVal*(-lumG)+sinVal*(-lumG),lumB+cosVal*(-lumB)+sinVal*(1-lumB),0,0,
			lumR+cosVal*(-lumR)+sinVal*(0.143),lumG+cosVal*(1-lumG)+sinVal*(0.140),lumB+cosVal*(-lumB)+sinVal*(-0.283),0,0,
			lumR+cosVal*(-lumR)+sinVal*(-(1-lumR)),lumG+cosVal*(-lumG)+sinVal*(lumG),lumB+cosVal*(1-lumB)+sinVal*(lumB),0,0,
			0,0,0,1,0,
			0,0,0,0,1
		]);
	}
	
// private methods:
	// copy the specified matrix's values to this matrix:
	private function copyMatrix(p_matrix:Array):Void {
		var l:Number = LENGTH;
		for (var i:Number=0;i<l;i++) {
			this[i] = p_matrix[i];
		}
	}
	
	// multiplies one matrix against another:
	private function multiplyMatrix(p_matrix:Array):Void {
		var col:Array = [];
		
		for (var i:Number=0;i<5;i++) {
			for (var j:Number=0;j<5;j++) {
				col[j] = this[j+i*5];
			}
			for (j=0;j<5;j++) {
				var val:Number=0;
				for (var k:Number=0;k<5;k++) {
					val += p_matrix[j+k*5]*col[k];
				}
				this[j+i*5] = val;
			}
		}
	}
	
	// make sure values are within the specified range, hue has a limit of 180, others are 100:
	private function cleanValue(p_val:Number,p_limit:Number):Number {
		return Math.min(p_limit,Math.max(-p_limit,p_val));
	}
}