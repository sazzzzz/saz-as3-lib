package saz.display.pixel {
	import flash.display.BitmapData;
	
	/**
	 * Pixelインターフェース。
	 * @author saz
	 */
	public interface IPixel {
		
		//--------------------------------------
		// get/set
		//--------------------------------------
		
		function get bitmapData():BitmapData;
		function set bitmapData(value:BitmapData):void;
		
		function get parent():IPixel;
		//function set parent(value:IPixel):void;
		
		function get root():IPixel;
		//function set root(value:IPixel):void;
		
		//function get x():Number;
		//function set x(value:Number):void;
		//function get y():Number;
		//function set y(value:Number):void;
		
		function get width():int;
		function get height():int;
		
		function get name():String;
		function set name(value:String):void;
		
		//--------------------------------------
		// method
		//--------------------------------------
		
		function draw():void;
		
		function atAdded(target:IPixel):void;
		function atRemoved(target:IPixel):void;
		
	}
	
}