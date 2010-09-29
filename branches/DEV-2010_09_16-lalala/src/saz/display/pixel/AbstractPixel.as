package saz.display.pixel {
	import flash.display.*;
	import flash.geom.*;
	/**
	 * pixel抽象クラス。
	 * @author saz
	 */
	public class AbstractPixel {
		
		public var x:Number = 0.0;
		public var y:Number = 0.0;
		
		public function AbstractPixel() {
		}
		
		/* INTERFACE saz.display.pixel.IPixel */
		
		public function get bitmapData():BitmapData{
			return null;
		}
		
		public function set bitmapData(value:BitmapData):void{
		}
		
		public function get parent():AbstractPixel{
			return null;
		}
		
		public function get root():AbstractPixel{
			return null;
		}
		
		public function get width():int{
			return 0;
		}
		
		public function get height():int{
			return 0;
		}
		
		public function get rect():Rectangle{
			return null;
		}
		
		public function get name():String{
			return null;
		}
		
		public function set name(value:String):void{
		}
		
		public function draw():void{
		}
		
		public function atAdded(target:AbstractPixel):void{
		}
		
		public function atRemoved(target:AbstractPixel):void{
		}
		
	}

}