package saz.display.pixel {
	import flash.display.*;
	import flash.geom.*;
	import saz.util.ArrayUtil;
	
	/**
	 * BitmapData上のレイヤー。
	 * @author saz
	 */
	//public class PixelLayer extends PixelSprite implements IPixel {
	public class PixelLayer extends PixelSprite {
		
		private var $children:/*AbstractPixel*/Array;
		
		//インスタンスを使いまわす。
		static protected var $destPoint:Point;
		
		public function PixelLayer(bmp:BitmapData) {
			super(bmp);
			
			$children = new Array();
		}
		
		
		// FIXME	テスト用
		/*public function DUMP():void {
			$children.forEach(function(item:*, index:int, arr:Array):void {
			});
			trace($children);
		}*/
		
		
		
		//private function $addChild
		
		//private function $removeChildAt(index:int) {
			//
		//}
		
		public function addChild(child:AbstractPixel):void {
			// 重複登録しないようremove
			removeChild(child);
			
			child.atAdded(this);
			$children.push(child);
		}
		
		public function removeChild(child:AbstractPixel):void {
			var index:int = ArrayUtil.find($children, child);
			// 子じゃなかったら終了
			if ( -1 == index) return;
			
			child.atRemoved(this);
			$children.splice(index, 1);
		}
		
		public function get children():/*AbstractPixel*/Array { return $children; }
		
		// FPS=29／半分はみだす FPS=37
		// 描画量によって、FPSは変化してるようだ。
		private function $drawChildren():void {
			if (0 == $children.length) return;
			$children.forEach(function(item:AbstractPixel, index:int, arr:Array):void {
				item.draw();
			});
		}
		
		// FPS=24	遅くなってる！
		/*private function $hitDraw():void {
			var rect:Rectangle = new Rectangle(0, 0, width, height);
			var hitRect:Rectangle;
			
			$children.forEach(function(item:AbstractPixel, index:int, arr:Array):void {
				hitRect = rect.intersection(item.rect);
				//表示範囲内
				if (0.0 < hitRect.width && 0.0 < hitRect.height) {
					item.draw();
				}
			});
		}*/
		// FPS=23／半分はみだす FPS=30
		// Rectangle.intersection()のせい ⇒コメントアウトするとFPS=35に
		// BitmapData側でクリップ処理をしてるせいか？
		/*private function $hitDraw():void {
			var rect:Rectangle = new Rectangle(0, 0, width, height);
			var hitRect:Rectangle;
			var childRect:Rectangle = new Rectangle();
			
			$children.forEach(function(item:AbstractPixel, index:int, arr:Array):void {
				childRect.x = item.x;
				childRect.y = item.y;
				childRect.width = item.width;
				childRect.height = item.height;
				
				hitRect = rect.intersection(childRect);
				//表示範囲内
				if (0.0 < hitRect.width && 0.0 < hitRect.height) {
					item.draw();
				}
			});
		}*/
		
		/*private function $clipDraw():void {
			var bmp:BitmapData = bitmapData;
			var rect:Rectangle = new Rectangle(0, 0, width, height);
			var sourceRect:Rectangle = new Rectangle();
			var destPoint:Point = new Point();
			var hitRect:Rectangle;
			
			//$parentBmp.copyPixels($bitmapData, $bitmapData.rect, $destPoint, null, null, mergeAlpha);
			$children.forEach(function(item:AbstractPixel, index:int, arr:Array):void {
				hitRect = rect.intersection(item.rect);
				//表示範囲内
				if (0.0 < hitRect.width && 0.0 < hitRect.height) {
					item.draw();
				}
			});
		}*/
		
		
		
		
		/* INTERFACE saz.display.pixel.IPixel */
		
		
		// TODO	最適化するなら、PixelLayerを入れ子にした場合。
		// 例えば、grandPlayer>parentLayer>childSpriteの場合、parentLayerの表示領域を確定してから、childSpriteの描画をすれば、余計な描画をしなくて済む。難しそうだけど。
		override public function draw():void {
			$drawChildren();
			$drawSelf();
		}
		
	}

}