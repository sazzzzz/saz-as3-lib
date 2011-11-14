package saz.display.particle {
	import jp.progression.casts.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	import jp.progression.commands.managers.*;
	import jp.progression.commands.media.*;
	import jp.progression.commands.net.*;
	import jp.progression.commands.tweens.*;
	import jp.progression.commands.*;
	import jp.progression.data.*;
	import jp.progression.events.*;
	import jp.progression.scenes.*;
	import saz.controll.Pool;
	
	/**
	 * パーティクル（キラキラ）ベースクラス. 
	 * 初出：KHABiz、未テスト。
	 * @author saz
	 */
	public class ParticleBase extends CastSprite {
		
		public var pool:Pool;
		
		private var _isInit:Boolean = false;
		
		/**
		 * 新しい ParticleBase インスタンスを作成します。
		 */
		public function ParticleBase( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
			
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		protected function waitAndRemove(wait:Number = 1 / 30):void {
			var self:ParticleBase = this;
			new SerialList(null,
				new Wait(wait),
				function():void {
					this.parent.insertCommand(new RemoveChild(self.parent, self));
				}
			).execute();
		}
		
		//--------------------------------------
		// オーバーライド用
		//--------------------------------------
		
		protected function initHook():void { }
		protected function castAddedHook():void { }
		protected function castRemovedHook():void { }
		
		
		
		
		
		protected function _init():void {
			_isInit = true;
			initHook();
		}
		
		/**
		 * IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastAdded():void {
			if (!_isInit)_init();
			
			castAddedHook();
		}
		
		/**
		 * IExecutable オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由で表示リストから削除された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastRemoved():void {
			castRemovedHook();
			
			var self:ParticleBase = this;
			addCommand(
				function():void {
					pool.backItem(self);
				}
			);
		}
	}
}
