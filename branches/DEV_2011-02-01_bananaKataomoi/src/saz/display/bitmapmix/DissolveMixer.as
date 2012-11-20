package saz.display.bitmapmix {
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	
	/**
	 * ソースAとソースBをディゾルブで描画。
	 * @author saz
	 */
	public class DissolveMixer extends BitmapMixer {
		
		private var $alphaCT:ColorTransform;
		
		//public function DissolveMixer(dst:BitmapData, srcA:BitmapData, srcB:BitmapData) {
		public function DissolveMixer(dst:BitmapData = null, srcA:BitmapData = null, srcB:BitmapData = null) {
			super(dst, srcA, srcB);
		}
		
		
		/**
		 * コンストラクタフック。
		 */
		override protected function $initHook():void {
			$alphaCT = new ColorTransform();
		}
		
		/**
		 * デストラクタフック。
		 */
		override protected function $destroyHook():void {
			$alphaCT = null;
		}
		
		
		/**
		 * 描画フック。描画ルーチンを指定。
		 */
		override protected function $drawHook():void {
			$dst.copyPixels($srca, $srca.rect, newPoint);
			$alphaCT.alphaMultiplier = $ratio;
			$dst.draw($srcb, newMatrix, $alphaCT);
		}
		
	}

}