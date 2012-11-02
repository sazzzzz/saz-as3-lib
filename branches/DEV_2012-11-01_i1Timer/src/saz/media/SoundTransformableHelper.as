package saz.media
{
	import flash.media.*;
	import saz.util.ObjectUtil;

	/**
	 * soundTransformプロパティを持つオブジェクト用ヘルパ。主にpanとvolumeの変更を容易にする 
	 * （Microphone、NetStream、SimpleButton、SoundChannel、SoundMixer、Sprite用）
	 * @author saz
	 * @see	http://feb19.jp/blog/archives/000130.php
	 * @see	http://level0.kayac.com/#!2009/01/post_10.php
	 */
	public class SoundTransformableHelper
	{
		
		
		/**
		 * 操作対象となる（soundTransformプロパティを持つ）オブジェクト.
		 * @return 
		 */
		public function get target():Object
		{
			return _target;
		}
		public function set target(value:Object):void
		{
			_target = value;
		}
		private var _target:Object;
		
		

		/**
		 * SoundTransformインスタンス.
		 * @return 
		 */
		public function get soundTransform():SoundTransform
		{
			if(!_soundTransform) _soundTransform = target.soundTransform;
			return _soundTransform;
		}
		private var _soundTransform:SoundTransform;

		

		public function get volume():Number
		{
			return soundTransform.volume;
		}

		public function set volume(value:Number):void
		{
			soundTransform.volume = value;
			target.soundTransform = soundTransform;
		}


		public function get pan():Number
		{
			return soundTransform.pan;
		}

		public function set pan(value:Number):void
		{
			soundTransform.pan = value;
			target.soundTransform = soundTransform;
		}
		

		
		/**
		 * コンストラクタ. 
		 * @param target	操作対象となる（soundTransformプロパティを持つ）オブジェクト.
		 */
		public function SoundTransformableHelper(sndTransformable:Object = null)
		{
			if(sndTransformable) target = sndTransformable;
		}
		
		
		public function setProperties(data:Object):void
		{
			ObjectUtil.setProperties(soundTransform, data);
			target.soundTransform = soundTransform;
		}
		
	}
}