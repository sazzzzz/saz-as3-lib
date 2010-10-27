package saz.collections {
	import saz.util.StringUtil;
	/**
	 * Map専用XMLパーサ.
	 * E4X忘れるんで…
	 * @author saz
	 * 
	 * @example <listing version="3.0" >
	 * var map:Map = new Map();
	 * var prs = new MapXMLParser(map);
	 * 
	 * var xml:XML = 
	 * <config>
	 * 	<param name="loadIntervalTwitter" value="60" />
	 * 	<param name="telopMax" value="50" />
	 * 	<param name="timelineMax" value="200" />
	 * </config>;
	 * 
	 * prs.readParamList(xml.param);
	 * 
	 * trace(map.keys);
	 * trace(map.gets("loadIntervalTwitter"));
	 * trace(map.gets("telopMax"));
	 * trace(map.gets("timelineMax"));
	 * </listing>
	 */
	public class MapXMLParser{
		
		private var $target:Map;
		
		/**
		 * コンストラクタ.
		 * @param	map
		 */
		public function MapXMLParser(map:Map = null) {
			if(map) target = map;
		}
		
		public function get target():Map { return $target; }
		
		public function set target(value:Map):void {
			$target = value;
		}
		
		// ノード名のダンプ作ろうとしたけど止めた.
		/*public function nameDump(xmlOrXmllist:Object, indent:String = ""):void {
			trace(indent, XML(xmlOrXmllist).name());
			if (xmlOrXmllist.children()) {
				nameDump(xmlOrXmllist.children()[0]);
			}
		}*/
		
		
		/**
		 * XMLListのそれぞれの要素になんかする.
		 * @param	list
		 * @param	iterator
		 * function callback(item:XML, index:int, collection:XMLList):void;
		 */
		public function each(list:XMLList, iterator:Function):void {
			//trace("MapXMLParser.each(");
			for (var i:int = 0, n:int = list.length(), item:XML; i < n; i++) {
				item = list[i];
				//trace(item);				// コレじゃダメ
				trace(item.toXMLString());
				iterator(item, i, list);
			}
		}
		
		/**
		 * param型エントリをよみこむ
		 * @param	xml
		 * @param	keyName	キー名として使用する属性の名前
		 * @param	valueName	値名として使用する属性の名前
		 * @param	convertNumbers	Numberに自動変換
		 * @param	convertBooleans	Booleanに自動変換
		 */
		public function readParam(xml:XML, keyName:String = "name", valueName:String = "value", convertNumbers:Boolean = false, convertBooleans:Boolean = false):void {
			trace(xml.name(), xml.@[keyName], xml.@[valueName]);
			var value:*= xml.@[valueName];
			if (convertNumbers) value = StringUtil.asNumber(value);
			if (!(value is Number) && convertBooleans) value = StringUtil.asBoolean(value);
			$target.put(xml.@[keyName], value);
		}
		
		/**
		 * param型エントリをまとめてよみこむ
		 * @param	list
		 * @param	keyName	キー名として使用する属性の名前
		 * @param	valueName	値名として使用する属性の名前
		 * @param	convertNumbers	Numberに自動変換
		 * @param	convertBooleans	Booleanに自動変換
		 * @see	#readParam
		 */
		public function readParamList(list:XMLList, keyName:String = "name", valueName:String = "value", convertNumbers:Boolean = false, convertBooleans:Boolean = false):void {
			//trace("MapXMLParser.readParamList(");
			each(list, function (item:XML, index:int, collection:XMLList):void {
				readParam(item, keyName, valueName, convertNumbers, convertBooleans);
			});
		}
		
		
	}

}