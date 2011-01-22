package saz.util.tagcloud {
	/**
	 * タグクラウド用データ
	 * @author saz
	 */
	public class TCData {
		/**
		 * タグ名。
		 */
		public var name:String;
		
		/**
		 * カウント数。
		 */
		public var count:int;
		
		/**
		 * 
		 * @param	tagName	タグ名。
		 * @param	tagCount	カウント数。
		 */
		public function TCData(tagName:String, tagCount:int) {
			name = tagName;
			count = tagCount;
		}
	}

}