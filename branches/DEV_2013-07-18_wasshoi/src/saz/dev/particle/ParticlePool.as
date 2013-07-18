package saz.dev.particle {
	import saz.controll.Pool;
	
	/**
	 * パーティクル用インスタンスプール.<br/>
	 * 初出：KHABiz、未テスト.<br/>
	 * 要progression4. <br/>
	 * @author saz
	 */
	public class ParticlePool extends Pool {
		private var _particleClass:Class;
		
		/**
		 * コンストラクタ. 
		 * @param	particleClass	パーティクルクラス＝ParticleBaseのサブクラスを指定. 
		 * @example <listing version="3.0" >
		 * _parCon = new ParticleController(this, frame);
		 * // コンストラクタでパーティクルクラス（インスタンスでなく）を渡す
		 * _parCon.add(new ParticlePool(PanelKira));
		 * _parCon.delay = 2 / 30 * 1000;
		 * _parCon.start();
		 * </listing>
		 */
		public function ParticlePool(particleClass:Class) {
			_particleClass = particleClass;
			
			super(_atCreateParticle);
		}
		
		protected function _atCreateParticle():ParticleBase {
			var res:ParticleBase = new _particleClass();
			res.pool = this;
			return res;
		}
		
	}

}