package saz.display
{
	import saz.model.FiniteAutomaton;
	
	/**
	 * いずれかのプロパティに変化があった場合に、送出されます。
	 * @eventType saz.events.WatchEvent.CHANGE
	 */
	[Event(name = "change", type = "saz.events.WatchEvent")]
	
	/**
	 * ボタン用ステート管理クラス。ホバー状態とプレス状態からステートに変換。…必要か？
	 * @author saz
	 * 
	 */
	public class ButtonStateMachine extends FiniteAutomaton
	{
		
		public static const STATE_NORMAL:String = "normal";
		public static const STATE_HOVER:String = "hover";
		public static const STATE_PRESS:String = "press";
//		public static const STATE_DISABLE:String = "disable";
		

		public function get hovering():Boolean
		{
			return _hovering;
		}

		public function set hovering(value:Boolean):void
		{
			_hovering = value;
			update();
		}
		private var _hovering:Boolean = false;
		
		

		public function get pressing():Boolean
		{
			return _pressing;
		}

		public function set pressing(value:Boolean):void
		{
			_pressing = value;
			update();
		}
		private var _pressing:Boolean = false;
		
		
		public var onNormal:Function;
		public var onHover:Function;
		public var onPress:Function;

		
		public function ButtonStateMachine(current:String="")
		{
			super(current);
			
			onNormal = function(name:String, oldVal:Object, newVal:Object):void{};
			onHover = function(name:String, oldVal:Object, newVal:Object):void{};
			onPress = function(name:String, oldVal:Object, newVal:Object):void{};
			
			update();
		}
		
		
		
		
		public function update():void
		{
			var old:String = state;
			transition(detectState());
			//callback
			detectCallback(state)("state", old, state);
		}
		
		
		
		protected function detectState():String
		{
			if (hovering && pressing) return STATE_PRESS;
			if (hovering && !pressing) return STATE_HOVER;
			return STATE_NORMAL;
		}
		
		protected function detectCallback(name:String):Function
		{
			switch (name)
			{
				case STATE_HOVER:
					return onHover;
				case STATE_PRESS:
					return onPress;
				case STATE_NORMAL:
				default:
					return onNormal;
			}
		}
		
	}
}