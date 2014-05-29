package saz.media
{
	/**
	 * SoundMangerに対してフェードイン/アウトを提供。
	 * 
	 * @author saz
	 * 
	 */
	public class SoundManagerFader
	{

		public var manager:SoundManager;
		
		public function SoundManagerFader(soundManager:SoundManager=null)
		{
			manager = soundManager || SoundManager.getInstance();
		}
		
		
		
		public function fadeIn(name:String, second:Number=1.0, callback:Function=null):void
		{
			if (!manager.valid(name)) return;
			
			var dat:Object = manager.getData(name);
			SoundFacadeFader.tweenVolume(
				manager.getFacade(name), dat.volume, second, {
					transition:"easeOutSine"				// こっちは未検証
					,onComplete:callback
				});
		}
		
		public function playFadein(name:String, second:Number=1.0, callback:Function=null):void
		{
			manager.play(name);
			fadeIn(name, second, callback);
		}
		
		
		
		public function fadeOut(name:String, second:Number=1.0, callback:Function=null):void
		{
			if (!manager.valid(name)) return;
			
			SoundFacadeFader.tweenVolume(
				manager.getFacade(name), 0.0, second, {
					transition:"easeInSine"				// linearよりこっちの方が自然
					,onComplete:callback
				});
		}
		
		public function fadeOutStop(name:String, second:Number=1.0, callback:Function=null):void
		{
			fadeOut(name, second, function():void
			{
				manager.stop(name);
				if (callback != null) callback();
			});
		}
		
	}
}