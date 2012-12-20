package saz.widget
{
	import flash.display.InteractiveObject;
	
	public class VSlider extends SliderBase
	{
		public function VSlider(thumObj:InteractiveObject)
		{
			super(thumObj);
		}
		
		override protected function getThumPosition():Number
		{
			return thum.y;
		}
		
		override protected function setThumPosition(value:Number):void
		{
			thum.y = value;
		}
		
		override protected function getMousePosition():Number
		{
			return thum.parent.mouseY;
		}
	}
}