package saz.collections.array
{
	import saz.math.LCG;

	/**
	 * 乱数にLCGを使用したLotteryBox。
	 * 
	 * @author saz
	 * 
	 */
	public class LCGLotteryBox extends LotteryBox
	{

		private var lcg:LCG;
		public function LCGLotteryBox(sourceArray:Array, seed:int = 1)
		{
			super(sourceArray);
			
			lcg = new LCG(seed);
		}
		
		override protected function atRandom():Number
		{
			return lcg.nextNumber();
		}
		
	}
}