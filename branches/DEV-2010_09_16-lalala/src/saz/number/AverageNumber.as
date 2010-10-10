package saz.number {
	
	/**
	 * 平均値。
	 * @author saz
	 */
	public class AverageNumber {
		
		private var $count:int = 0;
		private var $total:Number = 0.0;
		
		function AverageNumber() {
		}
		
		/**
		 * 値を追加する。
		 * @param	newValue	追加する値。
		 */
		public function add(newValue:Number):void {
			$count++;
			$total += newValue;
		}
		
		
		public function get count():int { return $count; }
		
		public function set count(value:int):void {
			$count = value;
		}
		
		public function get total():Number { return $total; }
		
		public function set total(value:Number):void {
			$total = value;
		}
		
		/**
		 * 平均値を得る。
		 */
		public function get value():Number {
			return $total / $count;
		}
		
	}
	
}