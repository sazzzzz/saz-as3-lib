package saz.geom
{
	/**
	 * Alignを表すクラス。テストしてません！
	 * StageAlignから思いついてクラスにしてみた。けど、必要かな？
	 * 
	 * @author saz
	 * 
	 */
	public class Align
	{
		
		public static const BOTTOM_CENTER : String = "BC";
		public static const BOTTOM_LEFT : String = "BL";
		public static const BOTTOM_RIGHT : String = "BR";
		public static const MIDDLE_CENTER : String = "MC";
		public static const MIDDLE_LEFT : String = "ML";
		public static const MIDDLE_RIGHT : String = "MR";
		public static const TOP_CENTER : String = "TC";
		public static const TOP_LEFT : String = "TL";
		public static const TOP_RIGHT : String = "TR";
		
		public static const BOTTOM : String = "B_";
		public static const MIDDLE : String = "M_";
		public static const TOP : String = "T_";
		public static const CENTER : String = "_C";
		public static const LEFT : String = "_L";
		public static const RIGHT : String = "_R";
		
		
		// String > Number用。
		private const ALIGN_TO_NUM:Object = {R:1, C:0, L:-1,
											B:1, M:0, T:-1,
											"_":0};
		
		
		

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}
		private var _type:String = "";
		
		
		
		
		
		public function Align(type:String)
		{
			// TODO:	クラス全体、まったくテストしてません！
			this.type = type;
		}
		
		
		
		
		public function get horizontalType():String
		{
			return type.substr(1, 1);
		}
		
		public function get verticalType():String
		{
			return type.substr(0, 1);
		}
		
		/**
		 * alignのX成分を表すNumberを返す。
		 * @return LEFTなら-1、CENTERなら0、RIGHTなら1。
		 */
		public function get horizontalSign():Number
		{
			return ALIGN_TO_NUM[horizontalType];
		}
		
		/**
		 * alignのY成分を表すNumberを返す。
		 * @param align
		 * @return TOPなら-1、MIDDLEなら0、BOTTOMなら1。
		 */
		public function get verticalSign():Number
		{
			return ALIGN_TO_NUM[verticalType];
		}
		
		
		
	}
}