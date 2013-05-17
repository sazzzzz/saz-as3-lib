package saz.model
{
	import saz.util.StringUtil;

	/**
	 * 
	 * @author saz
	 * 
	 * 仕様はprogression4のSceneIdを参考にしました。
	 * @see	http://en.wikipedia.org/wiki/Path_(computing)
	 * @see	http://asdoc.progression.jp/4.0/jp/progression/scenes/SceneId.html
	 */
	public class PathId
	{
		

		/**
		 * パスを表す文字列。
		 * @return 
		 * 
		 */
		public function get fullPath():String
		{
			return _fullPath;
		}
		private var _fullPath:String = "";

		
		
		
		/**
		 * パスの深さ。
		 * @return 
		 * 
		 */
		public function get depth():int
		{
			return _names.length;
		}

		private var _names:Array;
		
		/**
		 * コンストラクタ。
		 * @param path	パスを表す文字列。ex."/main/about"
		 * 
		 */
		public function PathId(path:String)
		{
			_init(path);
		}
		
		
		private function _init(path:String):void
		{
			_fullPath = _normalize(path);
			_names = path.split("/");
			_names.shift();
		}
		
		/**
		 * パスストリングを正規化。
		 * @param path
		 * @return 
		 * 
		 */
		private function _normalize(path:String):String
		{
			var p:String = path;
			/*while(p.substr(-1) == "/")
			{
				p = p.substr(0, p.length - 1);
			}*/
			return p;
		}
		
		
		/**
		 * 指定されたPathIdが、自身の表すパスの子かどうかを返します。
		 * @param pathId
		 * @return 
		 * 
		 */
		public function contains(pathId:PathId):Boolean
		{
			return StringUtil.leftHandMatch(pathId.fullPath, fullPath);
		}
		
		
		/**
		 * 指定されたPathIdが、自身の表すパスと同一かどうかを返します。
		 * @param pathId	テストするPathId。
		 * @return 
		 * 
		 */
		public function equals(pathId:PathId):Boolean
		{
			return fullPath == pathId.fullPath;
		}
		
		/**
		 * 指定位置にあるパスの名前を返します。
		 * @param index	位置を示すインデックス。負の数値を指定した場合は末尾から開始。
		 * @return 
		 * 
		 */
		public function getNameAt(index:int):String
		{
			if (index < 0) index += _names.length;
			return _names[index];
		}
		
		/**
		 * 指定された絶対パスもしくは相対パスを使用して移動後のPathIdを返します。 この操作で元のPathIdは変更されません。
		 * @param path
		 * @return 移動後のPathId。
		 * 
		 */
		public function transferred(path:String):PathId
		{
			throw new Error("未実装です。");
			return new PathId("/dummy");
		}
		
		
		/**
		 * 複製する。
		 * @return 
		 * 
		 */
		public function clone():PathId
		{
			return new PathId(fullPath);
		}
		
		public function toArray():Array
		{
			return _names;
		}
		
		public function toString():String
		{
			return fullPath;
		}
		
	}
}