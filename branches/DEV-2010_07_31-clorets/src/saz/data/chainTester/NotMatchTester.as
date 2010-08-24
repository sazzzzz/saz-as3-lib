package saz.data.chainTester {
	/**
	 * 空文字列に反応。
	 * @author saz
	 */
	public class NotMatchTester extends StringTesterBase{
		private var $regExp:RegExp;
		
		public function NotMatchTester(regExp:RegExp, resFunc:Function = null, alwaysChain:Boolean = false) {
			super(resFunc, alwaysChain);
			
			$regExp = regExp;
		}
		
		/* INTERFACE saz.data.chainTester.IChainTester */
		
		override public function canResponse(msg:String):Boolean {
			//trace("NotMatchTester.canResponse(", arguments);
			return !$regExp.test(msg);
		}
		
	}

}