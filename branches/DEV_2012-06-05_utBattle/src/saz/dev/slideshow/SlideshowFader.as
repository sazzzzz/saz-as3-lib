package saz.dev.slideshow {
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	/**
	 * SlideshowController用メソッド.
	 * @author saz
	 */
	public class SlideshowFader {
		
		/**
		 * クロスフェード用. 
		 * @param	target	描画するBitmapData.
		 * @param	value	0だとoutItem=100%、1だとinItem=100%
		 * @param	outItem	フェードアウトするBitmapData.
		 * @param	inItem	フェードインするBitmapData.
		 */
		static public function crossFade(target:BitmapData, value:Number, outItem:BitmapData, inItem:BitmapData):void {
			if (value <= 1.0) target.draw(outItem);
			if (0.0 <= value) target.draw(inItem, null, new ColorTransform(1, 1, 1, value));
		}
		
	}

}