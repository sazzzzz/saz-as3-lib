package saz.display.pixel {
	import flash.display.*;
	import flash.geom.*;
	/**
	 * BitmapData上のスプライト。
	 * @author saz
	 */
	public class PixelSprite implements IPixel {
		
		public var x:Number = 0.0;
		public var y:Number = 0.0;
		public var mergeAlpha:Boolean;
		
		protected var $bitmapData:BitmapData;
		protected var $parent:IPixel;
		protected var $root:IPixel;
		
		//protected var $x:Number;
		//protected var $y:Number;
		
		protected var $name:String = "PixelSprite";
		
		//参照をキャッシュ
		protected var $parentBmp:BitmapData;
		protected var $destPoint:Point;
		
		public function PixelSprite(bmp:BitmapData, mergeAlpha:Boolean = true) {
			bitmapData = bmp;
			this.mergeAlpha = mergeAlpha;
			
			$destPoint = new Point();
		}
		
		public function toString():String {
			return name;
		}
		
		/* INTERFACE saz.display.pixel.IPixel */
		
		//--------------------------------------
		// get/set
		//--------------------------------------
		
		public function get bitmapData():BitmapData{
			return $bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void{
			$bitmapData = value;
		}
		
		public function get parent():IPixel{
			return $parent;
		}
		
		/*public function set parent(value:IPixel):void{
			$parent = value;
		}*/
		
		public function get root():IPixel{
			//return $root;
			
			//どこにも所属してない場合はnullを返す。
			if (null == $parent) return null;
			
			//チェーンをたどって探す
			var p:IPixel = parent;
			do {
				if (null == p.parent) {
					break;
				}else {
					p = p.parent;
				}
			}while (true)
			return p;
		}
		
		/*public function set root(value:IPixel):void{
			$root = value;
		}*/
		
		/*public function get x():Number{
			return $x;
		}
		
		public function set x(value:Number):void{
			$x = value;
		}
		
		public function get y():Number{
			return $y;
		}
		
		public function set y(value:Number):void{
			$y = value;
		}*/
		
		/**
		 * bitmapDataの幅。bitmapDataが指定されてない場合は、-1を返す。
		 */
		public function get width():int{
			return ($bitmapData) ? $bitmapData.width : -1;
		}
		
		/**
		 * bitmapDataの高さ。bitmapDataが指定されてない場合は、-1を返す。
		 */
		public function get height():int{
			return ($bitmapData) ? $bitmapData.height : -1;
		}
		
		public function get name():String{
			return $name;
		}
		
		public function set name(value:String):void{
			$name = value;
		}
		
		
		//--------------------------------------
		// method
		//--------------------------------------
		
		/**
		 * 描画
		 */
		public function draw():void {
			//trace(name, "draw", x, y);
			$destPoint.x = x;
			$destPoint.y = y;
			$parentBmp.copyPixels($bitmapData, $bitmapData.rect, $destPoint, null, null, mergeAlpha);
		}
		
		
		public function atAdded(target:IPixel):void {
			$parent = target;
			$parentBmp = target.bitmapData;
		}
		
		public function atRemoved(target:IPixel):void {
			$parent = null;
			$parentBmp = null;
		}
		
	}

}