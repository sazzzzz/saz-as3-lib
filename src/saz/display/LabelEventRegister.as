package saz.display
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	
	import saz.collections.enumerator.Enumerable;

	/**
	 * MovieClipのラベルにイベントを登録。
	 * @author saz
	 */
	public class LabelEventRegister
	{
		
		/**
		 * 
		 * @param target	対象MovieClip。
		 * @param filter	フィルタ関数。function(item:FrameLabel index:int):Boolean
		 * @return 
		 */
		public static function regist(target:MovieClip, filter:Function=null):int
		{
			var all:Array, sel:Array, enum:Enumerable, fa:FrameAction;
			
			all = target.currentLabels;
			enum = new Enumerable(all);
			sel = filter!=null ? enum.select(filter) : all;
			
			fa = new FrameAction(target);
			for (var i:int = 0, n:int = sel.length, label:FrameLabel; i < n; i++) 
			{
				label = sel[i];
				fa.setAction(label.frame, _genLabelEventListener(target, label));
			}
			return sel.length;
		}
		
		private static function _genLabelEventListener(target:MovieClip, frameLabel:FrameLabel):Function
		{
			return function():void{
				target.dispatchEvent(new LabelEvent(LabelEvent.LABEL, true, false, frameLabel));
			};
		}
		
	}
}