package saz.display.bitmapmix {
	import flash.display.BitmapData;
	import flash.geom.*;
	/**
	 * BitmapMixerスーパークラス。
	 * @author saz
	 */
	public class BitmapMixer implements IBitmapMixer {
		
		protected var $dst:BitmapData;
		protected var $srca:BitmapData;
		protected var $srcb:BitmapData;
		protected var $exts:/*BitmapData*/Array;
		protected var $ratio:Number;
		
		public var newPoint:Point;
		public var newRectangle:Rectangle;
		public var newMatrix:Matrix;
		public var newColorTransform:ColorTransform;
		
		public function BitmapMixer(dst:BitmapData = null, srcA:BitmapData = null, srcB:BitmapData = null) {
			if (null != dst)$dst = dst;
			if (null != srcA) $srca = srcA;
			if (null != srcB)$srcb = srcB;
			$exts = new Array();
			
			if(null==newPoint) newPoint = new Point();
			if(null==newRectangle) newRectangle = new Rectangle();
			if(null==newMatrix) newMatrix = new Matrix();
			if(null==newColorTransform) newColorTransform = new ColorTransform();
			
			$ratio = 0;
			
			$initHook();
		}
		
		public function destroy():void {
			$dst = null;
			$srca = null;
			$srcb = null;
			$exts.forEach(function(item:*, index:int, arr:Array):void {
				item = null;
			});
			$exts = null;
			
			newPoint = null;
			newRectangle = null;
			newMatrix = null;
			newColorTransform = null;
			
			$destroyHook();
		}
		
		/* INTERFACE saz.display.bitmapmix.IBitmapMixer */
		
		public function getDestination():BitmapData{
			return $dst;
		}
		
		public function setDestination(bmp:BitmapData):void{
			$dst = bmp;
			$setDestinationHook(bmp);
		}
		
		public function getSourceA():BitmapData{
			return $srca;
		}
		
		public function setSourceA(bmp:BitmapData):void{
			$srca = bmp;
			$setSourceAHook(bmp);
		}
		
		public function getSourceB():BitmapData{
			return $srcb;
		}
		
		public function setSourceB(bmp:BitmapData):void{
			$srcb = bmp;
			$setSourceBHook(bmp);
		}
		
		public function getExtra(index:int = 0):BitmapData {
			return $exts[index];
		}
		
		public function setExtra(bmp:BitmapData, index:int = 0):void{
			$exts[index] = bmp;
			$setExtraHook(bmp, index);
		}
		
		public function getRatio():Number{
			return $ratio;
		}
		
		public function setRatio(value:Number):void{
			$ratio = value;
		}
		
		public function draw():void{
			$drawHook();
		}
		
		//--------------------------------------
		// hook
		//--------------------------------------
		
		/**
		 * コンストラクタフック。
		 */
		protected function $initHook():void{
		}
		
		/**
		 * デストラクタフック。
		 */
		protected function $destroyHook():void{
		}
		
		/**
		 * 出力指定フック。
		 * @param	bmp	BitmapDataインスタンス。
		 */
		protected function $setDestinationHook(bmp:BitmapData):void{
		}
		
		/**
		 * ソースA指定フック。
		 * @param	bmp	BitmapDataインスタンス。
		 */
		protected function $setSourceAHook(bmp:BitmapData):void{
		}
		
		/**
		 * ソースB指定フック。
		 * @param	bmp	BitmapDataインスタンス。
		 */
		protected function $setSourceBHook(bmp:BitmapData):void{
		}
		
		/**
		 * 特別ソース指定フック。
		 * @param	bmp	BitmapDataインスタンス。
		 * @param	index	特別ソース用インデックス。
		 */
		protected function $setExtraHook(bmp:BitmapData, index:int):void{
		}
		
		/**
		 * 描画フック。描画ルーチンを指定。
		 */
		protected function $drawHook():void{
		}
		
	}

}