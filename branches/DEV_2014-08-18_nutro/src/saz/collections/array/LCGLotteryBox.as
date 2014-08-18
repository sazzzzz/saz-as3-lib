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

		private var lcgSeed:int;
		private var lcg:LCG;
		
		public function LCGLotteryBox(sourceArray:Array, seed:int = 1)
		{
			lcgSeed = seed;
			
			super(sourceArray);
		}
		
		override protected function atInit():void
		{
			lcg = new LCG(lcgSeed);
		}
		
		
		override protected function atRandom():Number
		{
			return lcg.nextNumber();
		}
		
	}
}