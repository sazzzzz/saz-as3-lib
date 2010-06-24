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
		
		protected static var $nPoint:Point;
		protected static var $nRect:Rectangle;
		protected static var $nMtx:Matrix;
		protected static var $nCT:ColorTransform;
		
		public function BitmapMixer(dst:BitmapData, srcA:BitmapData, srcB:BitmapData) {
			$dst = dst;
			$srca = srcA;
			$srcb = srcB;
			$exts = new Array();
			
			if(null==$nPoint) $nPoint = new Point();
			if(null==$nRect) $nRect = new Rectangle();
			if(null==$nMtx) $nMtx = new Matrix();
			if(null==$nCT) $nCT = new ColorTransform();
			
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
			
			$nPoint = null;
			$nRect = null;
			$nMtx = null;
			$nCT = null;
			
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