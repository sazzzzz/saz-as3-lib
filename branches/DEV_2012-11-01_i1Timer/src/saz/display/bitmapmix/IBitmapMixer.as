package saz.display.bitmapmix {
	import flash.display.BitmapData;
	
	/**
	 * BitmapDataミキサ インターフェース
	 * @author saz
	 */
	public interface IBitmapMixer {
		
		function getDestination():BitmapData;
		function setDestination(bmp:BitmapData):void;
		function getSourceA():BitmapData;
		function setSourceA(bmp:BitmapData):void;
		function getSourceB():BitmapData;
		function setSourceB(bmp:BitmapData):void;
		function getExtra(index:int = 0):BitmapData;
		function setExtra(bmp:BitmapData, index:int = 0):void;
		
		function getRatio():Number;
		function setRatio(value:Number):void;
		
		function draw():void;
		
	}
	
}