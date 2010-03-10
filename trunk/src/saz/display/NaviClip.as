package saz.display {
	import flash.display.*;
	import flash.events.*;
	import saz.events.NaviEvent;
	
	/**
	 * ナビ用ボタン。as2から移植。
	 * @author saz
	 * @deprecated	as2から移植したけど不要かな…。
	 */
	public class NaviClip extends BtnClip {
		
		
		
		protected var $isSelected:Boolean;
		
		function NaviClip(inputObject:InteractiveObject) {
			super(inputObject);
			
			this.$isSelected = false;
		}
		
		public function get isSelected():Boolean { return $isSelected; }
		
		public function select():void {
			trace("NaviClip.select(" + arguments);
			if (this.$isSelected) return;
			
			this.$isSelected = true;
			//this.$selectHook();
			
			//this.dispatchEvent(NaviEvent.SELECTED, this);
			var e:Event = new Event(NaviEvent.SELECTED);
			this.dispatchEvent(e);
		}
		
		public function unselect():void {
			trace("NaviClip.unselect(" + arguments);
			if (this.$isSelected == false) return;
			
			this.$isSelected = false;
			//this.$unselectHook();
			
			//this.dispatchEvent(NaviEvent.UNSELECTED, this);
			var e:Event = new Event(NaviEvent.UNSELECTED);
			this.dispatchEvent(e);
		}
		
		/*private function $selectHook():void{
		}
		
		private function $unselectHook():void{
		}*/
		
	}
	
}