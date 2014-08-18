package saz.media
{
	import caurina.transitions.Tweener;
	
	import saz.util.ObjectUtil;

	/**
	 * SoundFacadeのvolumeフェードとpanのトィーンを提供する。
	 * Tweenerを使ってます。
	 * 
	 * @author saz
	 * 
	 */
	public class SoundFacadeFader
	{
		
		/**
		 * SoundFacadeのvolumeを時間をかけて変化させる。
		 * 
		 * @param target
		 * @param value
		 * @param second
		 * @param params
		 * 
		 */
		public static function tweenVolume(target:ISoundFacade, value:Number, second:Number=1.0, options:Object=null):void
		{
			var param:Object = {volume:value, time:second};
			if (options) _mergeParams(param, options);
			Tweener.addTween(target, param);
		}
		
		/**
		 * SoundFacadeのpanを時間をかけて変化させる。
		 * 
		 * @param target
		 * @param value
		 * @param second
		 * @param transition
		 * 
		 */
		public static function tweenPan(target:ISoundFacade, value:Number, second:Number=1.0, options:Object=null):void
		{
			var param:Object = {pan:value, time:second};
			if (options) _mergeParams(param, options);
			Tweener.addTween(target, param);
		}
		
		
		private static function _mergeParams(base:Object, params:Object):void
		{
			ObjectUtil.setProperties(base, params);
		}
		
	}
}