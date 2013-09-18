package saz.collections.array
{
	import saz.util.ArrayUtil;
	import saz.util.ObjectUtil;

	/**
	 * 配列で指定した要素の中から、抽選箱方式で要素を選ぶ。
	 * 
	 * @author saz
	 * 
	 * @see	http://ameblo.jp/evezoo/entry-10704872133.html
	 * 
	 */
	public class LotteryBox
	{
		
		/**
		 * オリジナル配列。
		 */
		public var source:Array;
		
		/**
		 * ワークが空になった時に、同じ値が連続しないようにチェックするかどうか。
		 */
		public var neverRepeat:Boolean = true;
		
		/*public var shuffleAtEmpty:Boolean = true;*/
		
		
		protected var work:Array = [];
		protected var lastItem:Object;
		
		
		/**
		 * コンストラクタ。
		 * 
		 * @param sourceArray	オリジナル配列。
		 * 
		 * @example サンプルコード:
		 * <listing version="3.0">
		 * var org:Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
		 * var lb:LotteryBox = new LotteryBox(org);
		 * lb.draw();
		 * </listing>
		 */
		
		public function LotteryBox(sourceArray:Array)
		{
			source = sourceArray;
		}
		
		/**
		 * 要素を一つ選ぶ。
		 * @return 
		 * 
		 */
		public function draw():Object
		{
			readyWorkIfEmpty();
			
			lastItem = work.pop();
			return lastItem;
		}
		
		/**
		 * 強制的にシャッフル。
		 * 
		 */
		public function shuffle():void
		{
			shuffleWork();
		}
		
		public function toString():String
		{
			/*return ObjectUtil.formatToString(this, "LotteryBox", ["work"]);*/
			return work.toString();
		}
		
		//--------------------------------------
		// private
		//--------------------------------------
		
		
		/**
		 * ワーク配列が空なら準備する。
		 */
		private function readyWorkIfEmpty():void
		{
			if (work.length > 0) return;
			
			readyWork();
		}
		
		/**
		 * ワーク配列を準備する。
		 */
		private function readyWork():void
		{
			work = ArrayUtil.clone(source);
			shuffle();
		}
		
		/**
		 * ワーク配列をシャッフル。
		 */
		private function shuffleWork():void
		{
			atShuffle();
			
			if (neverRepeat)
			{
				// 適当に切り上げる
				for (var i:int = 0; i < 99; i++) 
				{
					/*trace(i, lastItem, work[work.length - 1]);*/
					if (!atEqual(lastItem, work[work.length - 1])) break;
					atShuffle();
				}
			}
		}
		
		
		//--------------------------------------
		// for override
		//--------------------------------------
		
		
		/**
		 * 要素が同じかどうかを判定する関数。
		 * @param oldItem
		 * @param newItem
		 * @return 
		 * 
		 */
		protected function atEqual(oldItem:Object, newItem:Object):Boolean
		{
			return oldItem == newItem;
		}
		
		/**
		 * 配列のシャッフル関数。
		 * 
		 */
		protected function atShuffle():void
		{
			ArrayUtil.shuffleFY(work, atRandom);
		}
		
		/**
		 * atShuffleで使用する乱数生成関数。
		 * @return 
		 * 
		 */
		protected function atRandom():Number
		{
			return Math.random();
		}
		
	}
}