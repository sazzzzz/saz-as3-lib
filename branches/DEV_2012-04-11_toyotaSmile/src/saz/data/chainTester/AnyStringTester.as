package saz.data.chainTester {
	/**
	 * 必ず反応。
	 * @author saz
	 */
	public class AnyStringTester extends StringTesterBase{
		
		public function AnyStringTester(resFunc:Function = null, alwaysChain:Boolean = false) {
			super(resFunc, alwaysChain);
		}
		
		/* INTERFACE saz.data.chainTester.IChainTester */
		
		override public function canResponse(msg:String):Boolean {
			//trace("AnyStringTester.canResponse(", arguments);
			return true;
		}
		
	}

}