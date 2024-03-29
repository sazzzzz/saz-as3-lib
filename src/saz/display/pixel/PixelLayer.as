package saz.display.pixel {
	import flash.display.*;
	import flash.geom.*;
	import saz.util.ArrayUtil;
	
	/**
	 * BitmapData上のレイヤー。
	 * @author saz
	 */
	public class PixelLayer extends PixelSprite {
		
		private var $children:/*AbstractPixel*/Array;
		
		//インスタンスを使いまわす。
		static protected var $destPoint:Point;
		
		public function PixelLayer(bmp:BitmapData) {
			super(bmp);
			
			$children = new Array();
		}
		
		public function get children():/*AbstractPixel*/Array { return $children; }
		
		
		//private function $removeChildAt(index:int) {
		
		
		public function contains(child:AbstractPixel):Boolean {
			// これも全然おそい
			return $children.some(function(item:*, index:int, array:Array):Boolean{
				return (item == child);
			});
		}
		
		
		public function addChild(child:AbstractPixel):void {
			// 重複登録しないようremove
			// FIXME	すごく遅いのでコメントアウト。
			//contains(child);
			//removeChild(child);
			
			child.atAdded(this);
			$children.push(child);
		}
		
		// FIXME	遅い！
		public function removeChild(child:AbstractPixel):void {
			var index:int = ArrayUtil.find($children, child);
			// 子じゃなかったら終了
			if ( -1 == index) return;
			
			child.atRemoved(this);
			$children.splice(index, 1);
		}
		
		
		
		
		// FPS=29／半分はみだす FPS=37
		// 描画量によって、FPSは変化してるようだ。
		private function $drawChildren():void {
			if (0 == $children.length) return;
			for (var i:int = 0, len:int = $children.length, item:AbstractPixel; i < len; i++) {
				item = $children[i];
				item.draw();
			}
		}
		
		
		
		/* INTERFACE saz.display.pixel.IPixel */
		
		
		// TODO	最適化するなら、PixelLayerを入れ子にした場合。
		// 例えば、grandPlayer>parentLayer>childSpriteの場合、parentLayerの表示領域を確定してから、childSpriteの描画をすれば、余計な描画をしなくて済む。難しそうだけど。
		override public function draw():void {
			$drawChildren();
			$drawSelf();
		}
		
	}

}