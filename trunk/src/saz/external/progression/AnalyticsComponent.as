package saz.external.progression {
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import saz.external.google.GoogleAnalyticsProxy;
	/**
	 * SceneObjectにAnalyticsを貼っつける. 
	 * Unityコンポーネント的にしてみた. オレって天才かも. 
	 * デタッチもできるといいなあ…
	 * @author saz
	 */
	public class AnalyticsComponent {
		private var _gaProxy:GoogleAnalyticsProxy;
		
		/**
		 * コンストラクタ. 
		 * @param	gaProxy
		 * @example <listing version="3.0" >
		 * var ga:GoogleAnalyticsProxy = GoogleAnalyticsProxy.getInstance();
		 * if (!GoogleAnalyticsProxy.isInit) {
		 * 	ga.init(container, "window.pageTracker", GoogleAnalyticsProxy.MODE_BRIDGE, Define.IS_DEBUG);
		 * }
		 * var ana:AnalyticsComponent = new AnalyticsComponent(ga);
		 * ana.attach(coverScene, SceneEvent.SCENE_INIT, "DIGA-keisan");
		 * ana.attach(readyScene, SceneEvent.SCENE_INIT, "DIGA-keisan-tasizan");
		 * </listing>
		 */
		public function AnalyticsComponent(gaProxy:GoogleAnalyticsProxy) {
			_gaProxy = gaProxy;
		}
		
		private function _createListener(pageName:String):Function {
			return function(e:Event):void {
				_gaProxy.trackPageview(pageName);
			};
		}
		
		/**
		 * イベントにトラッキングを追加. 
		 * @param	target
		 * @param	eventType
		 * @param	pageName
		 */
		public function attach(target:IEventDispatcher, eventType:String, pageName:String):void {
			//dettach(target, eventType, pageName);
			target.addEventListener(eventType, _createListener(pageName));
		}
		
		// デタッチもできるといいなあ…
		// TODO	dettachを実装！
		public function dettach(target:IEventDispatcher, eventType:String, pageName:String):void {
			
		}
		
	}

}