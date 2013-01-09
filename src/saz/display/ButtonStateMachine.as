package saz.display
{
	import saz.model.FiniteAutomaton;
	
	public class ButtonStateMachine extends FiniteAutomaton
	{
		
		protected static const STATE_NORMAL:String = "normal";
		protected static const STATE_HOVER:String = "hover";
		protected static const STATE_PRESS:String = "press";

		public function get hovering():Boolean
		{
			return _hovering;
		}

		public function set hovering(value:Boolean):void
		{
			_hovering = value;
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

		
		public function ButtonStateMachine(current:String="")
		{
			super(current);
			update();
		}
		
		public function update():void
		{
			transition(detectState());
		}
		
		protected function detectState():String
		{
			if (hovering && pressing) return STATE_PRESS;
			if (hovering && !pressing) return STATE_HOVER;
			return STATE_NORMAL;
		}
		
	}
}