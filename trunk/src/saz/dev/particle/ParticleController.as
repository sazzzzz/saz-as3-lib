package saz.dev.particle {
	import flash.display.*;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import jp.progression.commands.display.AddChild;
	import saz.collections.enumerator.Enumerable;
	import saz.controll.Pool;
	import saz.util.VarDefault;
	/**
	 * パーティクルコントロール.<br/>
	 * 初出：KHABiz、未テスト.<br/>
	 * 要progression4. <br/>
	 * TODO	仕様がイマイチ。
	 * @author saz
	 */
	public class ParticleController {
		
		private var _pools:Array;
		//private var _enum:Enumerable;
		private var _timer:Timer;
		
		public var canvas:DisplayObjectContainer;
		public var area:DisplayObject;
		
		/**
		 * 単位：msec. 
		 */
		public function get delay():Number {
			return _delay;
		}
		public function set delay(value:Number):void {
			_delay = value;
			if (_timer)_timer.stop();
			_timer = new Timer(_delay);
			_timer.addEventListener(TimerEvent.TIMER, _timer_timer);
		}
		private var _delay:Number;
		
		
		/**
		 * コンストラクタ. 
		 * @param	canvas	パーティクルをAddChildするDisplayObjectContainer. 
		 * @param	area	パーティクルを生成する範囲を表すDisplayObject. 
		 * @example <listing version="3.0" >
		 * _parCon = new ParticleController(this, frame);
		 * _parCon.add(new ParticlePool(PanelKira));
		 * _parCon.delay = 2 / 30 * 1000;
		 * _parCon.start();
		 * </listing>
		 */
		public function ParticleController(canvas:DisplayObjectContainer, area:DisplayObject) {
			this.canvas = canvas;
			this.area = area;
		}
		
		
		
		
		private function _detectPool():Pool {
			return Pool(_pools[(_pools.length == 1) ? 0 : Math.floor(Math.random() * _pools.length)]);
		}
		
		private function _timer_timer(e:TimerEvent):void {
			var px:Number, py:Number;
			var b:Rectangle = area.getRect(area.parent);
			//do {
				px = Math.floor(Math.random() * b.width) + b.x;
				py = Math.floor(Math.random() * b.height) + b.y;
			//}while (area.hitTestPoint(px, py, true) == false)
			var p:ParticleBase = ParticleBase(_detectPool().getItem());
			p.x = px;
			p.y = py;
			new AddChild(canvas, p).execute();
		}
		
		
		public function add(pool:Pool):void {
			if (_pools == null) {
				_pools = new Array();
				//_enum = new Enumerable(_pools);
			}
			_pools.push(pool);
		}
		
		public function start():void {
			if (VarDefault.isNumberDefault(delay)) delay = 1 / 30;
			_timer.start();
		}
		
		public function stop():void {
			_timer.stop();
		}
		
		
	}

}