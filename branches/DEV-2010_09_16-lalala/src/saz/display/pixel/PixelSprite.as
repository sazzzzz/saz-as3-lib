package saz.display.pixel {
	import flash.display.*;
	import flash.geom.*;
	/**
	 * BitmapData上のスプライト。
	 * @author saz
	 */
	public class PixelSprite extends AbstractPixel {
		
		// 当然mergeAlpha=falseのほうが早い。FPS60で、38対29の差。
		public var mergeAlpha:Boolean;
		
		//外部参照
		protected var $bitmapData:BitmapData;
		protected var $parent:AbstractPixel;
		protected var $root:AbstractPixel;
		
		//インスタンスを使いまわす。
		static protected var $destPoint:Point;
		
		protected var $rect:Rectangle;
		
		protected var $name:String = "PixelSprite";
		
		//参照をキャッシュ
		protected var $parentBmp:BitmapData;
		
		
		public function PixelSprite(bmp:BitmapData, mergeAlpha:Boolean = true) {
		//public function PixelSprite(bmp:BitmapData = null, mergeAlpha:Boolean = true) {
			if (bmp) bitmapData = bmp;
			this.mergeAlpha = mergeAlpha;
			
			if (null == $destPoint) $destPoint = new Point();
		}
		
		public function toString():String {
			return name;
		}
		
		public function destroy():void {
			$bitmapData = null;
			$parent = null;
			
		}
		
		/* INTERFACE saz.display.pixel.IPixel */
		
		//--------------------------------------
		// get/set
		//--------------------------------------
		
		override public function get bitmapData():BitmapData{
			return $bitmapData;
		}
		
		override public function set bitmapData(value:BitmapData):void {
			if (null == value) throw new ArgumentError("PixelSprite.bitmapData 引数がnullです。");
			$bitmapData = value;
			
			if (null == $rect) $rect = new Rectangle();
			$rect.width = value.width;
			$rect.height = value.height;
		}
		
		override public function get parent():AbstractPixel{
			return $parent;
		}
		
		override public function get root():AbstractPixel{
			//どこにも所属してない場合はnullを返す。
			if (null == $parent) return null;
			
			//チェーンをたどって探す
			var p:AbstractPixel = parent;
			do {
				if (null == p.parent) {
					break;
				}else {
					p = p.parent;
				}
			}while (true)
			return p;
		}
		
		
		/**
		 * bitmapDataの幅。bitmapDataが指定されてない場合は、-1を返す。
		 */
		override public function get width():int{
			return ($bitmapData) ? $bitmapData.width : -1;
		}
		
		/**
		 * bitmapDataの高さ。bitmapDataが指定されてない場合は、-1を返す。
		 */
		override public function get height():int{
			return ($bitmapData) ? $bitmapData.height : -1;
		}
		
		override public function get rect():Rectangle {
			$rect.x = x;
			$rect.y = y;
			return $rect;
		}
		
		
		
		override public function get name():String{
			return $name;
		}
		
		override public function set name(value:String):void{
			$name = value;
		}
		
		
		//--------------------------------------
		// method
		//--------------------------------------
		
		protected function $drawSelf():void {
			if (null == $parent) return;
			$destPoint.x = x;
			$destPoint.y = y;
			$parentBmp.copyPixels($bitmapData, $bitmapData.rect, $destPoint, null, null, mergeAlpha);
		}
		
		/**
		 * 描画
		 */
		override public function draw():void {
			$drawSelf();
		}
		
		//--------------------------------------
		// internal
		//--------------------------------------
		
		override internal function atAdded(target:AbstractPixel):void {
			$parent = target;
			$parentBmp = target.bitmapData;
		}
		
		override internal function atRemoved(target:AbstractPixel):void {
			$parent = null;
			$parentBmp = null;
		}
		
	}

}