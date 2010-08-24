package saz.data.chainTester {
	/**
	 * 文字列テスト用ベースクラス。<br/>
	 * Chain of Responsibility パターンにしてみた。
	 * @author saz
	 * @see	http://www.techscore.com/tech/DesignPattern/ChainOfResponsibility.html
	 * @see	http://ja.wikipedia.org/wiki/Chain_of_Responsibility_%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3
	 */
	public class StringTesterBase implements IChainTester {
		
		protected var $response:Function;
		
		protected var $alwaysChain:Boolean;
		protected var $next:IChainTester;
		
		/**
		 * 
		 * @param	resFunc
		 * @param	alwaysChain
		 */
		public function StringTesterBase(resFunc:Function = null, alwaysChain:Boolean = false) {
			response = (null != resFunc) ? resFunc : $defaultResponse;
			$alwaysChain = alwaysChain;
		}
		
		/**
		 * 次のIChainTesterインスタンスを設定する。
		 * @param	tester
		 * @return
		 */
		public function setNext(tester:IChainTester):IChainTester {
			$next = tester;
			//return this;
			return tester;
		}
		
		/**
		 * メッセージを受け取る。
		 * @param	msg
		 */
		public function test(msg:String):void {
			if (canResponse(msg)) {
				response(msg);
				if($alwaysChain && $next) $next.test(msg);
			}else if ($next) {
				$next.test(msg);
			}else {
				// 末端
				trace("誰も反応しなかった。");
			}
		}
		
		//--------------------------------------
		// 以下サブクラス用
		//--------------------------------------
		
		public function canResponse(msg:String):Boolean {
			return false;
		}
		
		//public function response(msg:String):void {
		//}
		
		protected function $defaultResponse(msg:String):void {
			trace(this, "$defaultResponse", msg);
		}
		
		public function get response():Function { return $response; }
		
		public function set response(value:Function):void {
			$response = value;
		}
		
	}

}