package sample.dev.particle {
	import flash.events.Event;
	import saz.dev.particle.ParticleBase;
	
	/**
	 * ParticleBaseサンプル.
	 * @author saz
	 */
	public class SampleParticle extends ParticleBase {
		
		private var _speed:Number;
		
		public function SampleParticle(initObject:Object = null) {
			super(initObject);
		}
		
		private function _loop(e:Event):void {
			_speed += 0.1;
			y += _speed;
		}
		
		/**
		 * 初期化用. 最初のatCastAdded時に呼ばれる. 
		 */
		/*override protected function initHook():void {
			trace("SampleParticle.initHook(", arguments);
		}*/
		
		/**
		 * atCastAddedフック. 
		 */
		override protected function castAddedHook():void {
			_speed = 0.1;
			x = Math.round(Math.random() * stage.stageWidth);
			y = Math.round(Math.random() * stage.stageHeight);
			addEventListener(Event.ENTER_FRAME, _loop);
			// 1秒後に消える
			waitAndRemove(1.0);
		}
		
		/**
		 * atCastRemovedフック. 
		 */
		override protected function castRemovedHook():void {
			removeEventListener(Event.ENTER_FRAME, _loop);
		}
		
	}

}