package saz.util.tagcloud {
	import saz.util.VarDefault;
	/**
	 * タグクラウドレベル計算機。<br/>
	 * @author saz
	 */
	public class TCLevelCalculator {
		
		// 0-24:25steps
		private var $maxLevel:int;
		private var $k:Number;
		private var $minCount:int;
		private var $maxCount:int;
		private var $min:Number;
		
		/**
		 * コンストラクタ。
		 * @param	maxLevel
		 * @example <listing version="3.0" >
		 * const DATS:Array = [
		 * 	{name:"js", count:10}, {name:"ruby", count:5}, {name:"php", count:3}, {name:"html", count:1}
		 * ];
		 * // 数字配列をつくる
		 * var countList3:Array = new Array();
		 * DATS.forEach(function(item:*, index:int, array:Array):void{
		 * 	countList3.push(item.count);
		 * });
		 * 
		 * var cCalc3:TCLevelCalculator = new TCLevelCalculator();
		 * // max,minを自動で決定。
		 * cCalc3.detectRange(countList3);
		 * 
		 * // レベルを計算。
		 * DATS.forEach(function(item:*, index:int, array:Array):void{
		 * 	trace(DATS[index].name, cCalc2.calcLevel(DATS[index].count));
		 * });
		 * </listing>
		 */
		public function TCLevelCalculator(maxLevel:int = 24) {
			setMaxLevel(maxLevel);
		}
		
		/**
		 * クラウドレベルをまとめて計算する。
		 * @param	countList	カウントの配列。
		 * @return	レベルの配列。
		 */
		public function calcLevelList(countList:/*int*/Array):/*Number*/Array {
			var res:Array = new Array(countList.length);
			countList.forEach(function(item:*, index:int, array:Array):void{
				res[index] = calcLevel(item);
			});
			return res;
		}
		
		/**
		 * クラウドレベルを計算する。
		 * @param	count
		 * @return	整数とは限らない。小数点あり。
		 */
		public function calcLevel(count:int):Number {
			if (VarDefault.isNumberDefault($k)) throw new Error("TCLevelCalculator.calcLevel(): minCountまたはmaxCountが設定されていません。");
			return (Math.sqrt(count) - $min) * $k;
		}
		
		/**
		 * カウントの配列を渡して、minCountとmaxCountを自動設定。
		 * @param	countList
		 */
		public function detectRange(countList:/*int*/Array):void {
			//trace("TCLevelCalculator.detectRange(" + arguments);
			setRange(Math.min.apply(null, countList), Math.max.apply(null, countList));
		}
		
		/**
		 * 最小値、最大値を設定する。係数を自動更新。
		 * @param	minCount
		 * @param	maxCount
		 */
		public function setRange(minCount:int, maxCount:int):void {
			//trace("TCLevelCalculator.setRange(" + arguments);
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
			// VarDefault.INT=0 なのでいらないか。
			//if (VarDefault.INT == $minCount || VarDefault.INT == $maxCount) throw new Error("TCLevelCalculator.$updateK(): minCountまたはmaxCountが設定されていません。");
			$min = Math.sqrt($minCount);
			var max:Number = Math.sqrt($maxCount);
			$k = $maxLevel / (max - $min);
		}
		
		public function get minCount():int { return $minCount; }
		
		public function get maxCount():int { return $maxCount; }
		
	}

}