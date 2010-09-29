package saz.display.pixel {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
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
		
		function get root():IPixel;
		
		//function get x():Number;
		//function set x(value:Number):void;
		//function get y():Number;
		//function set y(value:Number):void;
		
		function get width():int;
		function get height():int;
		function get rect():Rectangle;
		
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