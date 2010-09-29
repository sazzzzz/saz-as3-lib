package saz.display.pixel {
	import flash.display.BitmapData;
	import saz.display.pixel.IPixel;
	import saz.util.ArrayUtil;
	
	/**
	 * BitmapData上のレイヤー。
	 * @author saz
	 */
	public class PixelLayer extends PixelSprite implements IPixel {
		
		private var $children:/*IPixel*/Array;
		
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
		
		private function $removeChildAt(index:int) {
			
		}
		
		public function addChild(child:IPixel):void {
			// 重複登録しないようremove
			removeChild(child);
			
			child.atAdded(this);
			$children.push(child);
		}
		
		public function removeChild(child:IPixel):void {
			var index:int = ArrayUtil.find($children, child);
			// 子じゃなかったら終了
			if ( -1 == index) return;
			
			child.atRemoved(this);
			$children.splice(index, 1);
		}
		
		
		
		public function get children():/*IPixel*/Array { return $children; }
		
		
		/* INTERFACE saz.display.pixel.IPixel */
		
		override public function draw():void {
			if (0 == $children.length) return;
			$children.forEach(function(item:IPixel, index:int, arr:Array):void {
				item.draw();
			});
		}
		
	}

}