package saz.util {
	/**
	 * ...
	 * @author saz
	 */
	public class ObjectFormatter {
		
		public static function toString(target:Object, name:String = "", indent:String = "  "):String {
			var res:String = "";
			res += _switchByType(target, name, 0, indent);
			return _cropEndComma(res);
		}
		
		private static function _switchByType(target:Object, name:String, depth:int = 0, indent:String = "  "):String {
			if (_isArray(target)) {
				return _arrayToString(target, name, depth, indent);
			}else if (_isMap(target)) {
				return _mapToString(target, name, depth, indent);
			}
			return _singleToString(target, name, depth, indent);
		}
		
		//
		// collection
		//
		
		private static function _arrayToString(target:Object, name:String, depth:int = 0, indent:String = "  "):String {
			var res:String = "";
			res += _makeIndent(depth, indent) + _formatName(name) + "[\n";
			for (var i:int = 0, l:int = target.length; i < l; i++) {
				res += _switchByType(target[i], "", depth + 1, indent);
			}
			res = _cropEndComma(res);
			res += _makeIndent(depth, indent) + "],\n";
			return res;
		}
		
		private static function _mapToString(target:Object, name:String, depth:int = 0, indent:String = "  "):String {
			var arr:Array = [];
			// いったん配列に入れて…
			for (var p:String in target) {
				arr.push({key:p, value:target[p]});
			}
			// ソートする
			arr.sortOn("key");
			
			var res:String = "";
			res += _makeIndent(depth, indent) + _formatName(name) + "{\n";
			for (var i:int = 0, l:int = arr.length; i < l; i++) {
				res += _switchByType(arr[i].value, arr[i].key, depth + 1, indent);
			}
			res = _cropEndComma(res);
			res += _makeIndent(depth, indent) + "},\n";
			return res;
		}
		
		//
		// not collection
		//
		
		private static function _singleToString(target:Object, name:String, depth:int = 0, indent:String = "  "):String {
			return [_makeIndent(depth, indent), _formatName(name), _formatValue(target), ",\n"].join("");
		}
		
		// Top level class
		// http://help.adobe.com/ja_JP/FlashPlatform/reference/actionscript/3/package-detail.html
		// Array Boolean Class Date Function int Number Object RegExp String uint Vector XML XMLList 
		// Error ArgumentError ...
		
		
		//
		// edit string
		//
		
		private static function _cropEndComma(target:String):String {
			if (target.substr( -2, 2) == ",\n") {
				return target.substr(0, target.length - 2) + "\n";
			}
			return target;
		}
		
		private static function _formatName(name:String):String {
			return name == "" ? "" : name + ": ";
		}
	   
	   /**
		* 
		* @param	target	Boolean, 
		* @return
		*/
		private static function _formatValue(target:Object):String {
			if (target is String) {
			   return '"' + target + '"';
			}
			return target.valueOf();
		}
		
		private static function _makeIndent(depth:int, indent:String = "  "):String {
			var res:String = "";
			for (var i:int = 0; i < depth; i++) {
				res += indent;
			}
			return res;
		}
		
		
		
		
		private static function _isArray(target:Object):Boolean {
			return target is Array;
		}
		
		private static function _isMap(target:Object):Boolean {
			return typeof(target) == "object";
		}
		
	}

}