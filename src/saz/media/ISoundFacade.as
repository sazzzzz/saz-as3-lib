package saz.media
{
	import flash.media.*;

	/**
	 * SoundFacadeインターフェース。
	 * @author saz
	 * 
	 */
	public interface ISoundFacade
	{
		function get sound():Sound;
		function set sound(value:Sound):void;
		
		function get soundChannel():SoundChannel;
		function get soundTransform():SoundTransform;
		
		function get volume():Number;
		function set volume(value:Number):void;
		
		function get pan():Number;
		function set pan(value:Number):void;
		
		function get holdings():SoundHoldings;
		function get resumer():SoundResumer;
		
		function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel;
		function resumablePlay(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel;
		function stop():void;
		function pause():void;
		function resume():void;
	}
}