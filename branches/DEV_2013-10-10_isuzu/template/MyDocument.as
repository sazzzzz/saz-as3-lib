package  {
	import saz.display.Document;
	
	/**
	 * ...
	 * @author saz
	 */
	public class MyDocument extends Document{
		
		public function MyDocument() {
			super();
		}
		
		/**
		 * SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に送出されます。
		 */
		override protected function atReady():void {
			// 初期化処理
			
		}
		
	}

}