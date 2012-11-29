package saz.display {
	import flash.display.*;
	import flash.geom.*;
	
	//FIXME	範囲を超えると表示がおかしくなる。
	//TODO		ループを実装しないと。
	/**
	 * BitmapDataでスクロール。
	 * 大きい元BitmapDataから、小さな表示用BitmapDataにcopyPixels()する。
	 * @author saz
	 * 
	 * @example <listing version="3.0" >
	 * // BitmapData準備
	 * var dst:BitmapData = new BitmapData(550,400,false,0);
	 * var dstDsp:Bitmap = new Bitmap(dst);
	 * addChild(dstDsp);
	 * 
	 * // BitmapScrollerインスタンスを生成。
	 * var scroller:BitmapScroller = new BitmapScroller(src,dst);
	 * 
	 * this.addEventListener(Event.ENTER_FRAME,this.drawLoop);
	 * 
	 * function drawLoop (e:Event) {
	 * 	// 描画する
	 * 	scroller.draw();
	 * }
	 * </listing>
	 */
	public class BitmapScroller {
		
		/**
		 ソースのx座標。Number型だが、レンダリング時に丸められる。
		 */
		public var x:Number;
		/**
		 ソースのy座標。Number型だが、レンダリング時に丸められる。
		 */
		public var y:Number;
		
		private var $source:BitmapData;
		private var $destination:BitmapData;
		
		private var $sourceRect:Rectangle;
		private var $destPoint:Point;
		
		/**
		 * コンストラクタ。
		 * @param	source	ソースBitmapData。
		 * @param	destination	出力先BitmapData。
		 */
		function BitmapScroller(source:BitmapData, destination:BitmapData) {
			this.$source = source;
			this.$destination = destination;
			
			this.x = 0;
			this.y = 0;
			
			//this.$sourceRect = this.$source.rect;
			this.$sourceRect = new Rectangle(0, 0, this.$source.width, this.$source.height);
			this.$destPoint = new Point();
		}
		
		/**
		 * 表示更新。出力先はPoint(0,0)固定。
		 */
		public function draw():void {
			this.$updateSourceRect();
			this.$destination.copyPixels(this.$source, this.$sourceRect, this.$destPoint);
			//trace([this.$source, this.$sourceRect, this.$destPoint]);
		}
		
		private function $updateSourceRect():void {
			this.$sourceRect.x = Math.round(this.x);
			this.$sourceRect.y = Math.round(this.y);
			//this.$sourceRect.x = this.x;
			//this.$sourceRect.y = this.y;
		}
		
	}
	
}