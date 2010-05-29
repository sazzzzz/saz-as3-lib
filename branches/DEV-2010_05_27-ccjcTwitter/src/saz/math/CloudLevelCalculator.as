package saz.math {
	import saz.util.VarDefault;
	/**
	 * タグクラウドレベル計算機。<br/>
	 * @author saz
	 */
	public class CloudLevelCalculator {
		
		// 0-24:25steps
		private var $maxLevel:int;
		private var $k:Number;
		private var $minCount:int;
		private var $maxCount:int;
		private var $min:Number;
		
		public function CloudLevelCalculator(maxLevel:int = 24) {
			setMaxLevel(maxLevel);
		}
		
		/**
		 * クラウドレベルを計算する。
		 * @param	count
		 * @return	整数とは限らない。小数点あり。
		 */
		public function calcLevel(count:int):Number {
			if (VarDefault.isNumberDefault($k)) throw new Error("CloudLevelCalculator.calcLevel(): minCountまたはmaxCountが設定されていません。");
			return (Math.sqrt(count) - $min) * $k;
		}
		
		/**
		 * カウントの配列を渡して、minCountとmaxCountを自動設定。
		 * @param	countList
		 */
		public function detectRange(countList:/*int*/Array):void {
			setRange(Math.min.apply(null, countList), Math.max.apply(null, countList));
		}
		
		/**
		 * 最小値、最大値を設定する。係数を自動更新。
		 * @param	minCount
		 * @param	maxCount
		 */
		public function setRange(minCount:int, maxCount:int):void {
			trace("CloudLevelCalculator.setRange(" + arguments);
			$minCount = minCount;
			$maxCount = maxCount;
			$updateK();
		}
		
		/**
		 * レベルの最大値を変更する。係数を自動更新。
		 * @param	level
		 */
		public function setMaxLevel(level:int):void {
			$maxLevel = level;
			if (VarDefault.INT != $minCount && VarDefault.INT != $maxCount)$updateK();
		}
		
		/**
		 * 係数kを更新。
		 */
		private function $updateK():void {
			if (VarDefault.INT == $minCount || VarDefault.INT == $maxCount) throw new Error("CloudLevelCalculator.$updateK(): minCountまたはmaxCountが設定されていません。");
			$min = Math.sqrt($minCount);
			var max:Number = Math.sqrt($maxCount);
			$k = $maxLevel / (max - $min);
		}
		
	}

}