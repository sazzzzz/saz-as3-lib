package saz.data.chainTester {
	import saz.data.chainTester.IChainTester;
	/**
	 * 必ず反応。
	 * @author saz
	 */
	public class AnyStringTester extends StringTesterBase implements IChainTester{
		
		public function AnyStringTester(resFunc:Function = null, alwaysChain:Boolean = false) {
			super(resFunc, alwaysChain);
		}
		
		/* INTERFACE saz.data.chainTester.IChainTester */
		
		override public function canResponse(msg:String):Boolean {
			return true;
		}
		
	}

}