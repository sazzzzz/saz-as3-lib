package saz.data.chainTester {
	/**
	 * 空文字列に反応。
	 * @author saz
	 */
	public class EmptyStringTester extends StringTesterBase{
		
		public function EmptyStringTester(resFunc:Function = null, alwaysChain:Boolean = false) {
			super(resFunc, alwaysChain);
		}
		
		/* INTERFACE saz.data.chainTester.IChainTester */
		
		override public function canResponse(msg:String):Boolean {
			//trace("EmptyStringTester.canResponse(", arguments);
			return "" == msg;
		}
		
	}

}