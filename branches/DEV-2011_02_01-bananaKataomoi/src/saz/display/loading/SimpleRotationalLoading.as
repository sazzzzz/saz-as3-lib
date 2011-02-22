package saz.display.loading {
	import flash.display.*;
	import saz.util.ObjectUtil;
	/**
	 * ...
	 * @author saz
	 */
	public class SimpleRotationalLoading extends LoadingDrawerBase {
		
		/**
		 * 回転するスピード. 単位は度. 
		 */
		public var speed:Number = 4.0;
		/**
		 * 基準となる角度. 
		 */
		public var baseRotation:Number = 0.0;
		
		
		public function SimpleRotationalLoading(displayContainer:DisplayObjectContainer) {
			super(displayContainer);
		}
		
		/**
		 * 表示するDisplayObjectの生成メソッドを定義する. 
		 * @param	index	表示アイテムインデックス. 
		 * @param	num		表示アイテムの総数. 
		 * @param	extra	リレーオブジェクト. 各atCreateItem間で共有されるので、値を変更すると次のアイテムに渡される. 
		 */
		override protected function atCreateItem(index:int, num:int, extra:Object):DisplayObject {
			//ObjectUtil.dump2(extra);
			//extra.test++;
			var res:Shape = new Shape();
			var g:Graphics = res.graphics;
			g.lineStyle(0, 0xFFFFFF);
			g.moveTo(7, 0);
			g.lineTo(10, 0);
			return res;
		}
		
		/**
		 * 表示更新時に呼ばれる. この直後にatDrawItemが実行される. 
		 * @param	extra	各atDrawItemに渡されるリレーオブジェクト. プロパティを追加して各atDrawItem内で使用する. 
		 */
		override protected function atDraw(extra:Object):void {
			baseRotation += speed;
			extra.rotation = baseRotation;
		}
		
		/**
		 * 各アイテムの描画更新メソッド. atDraw直後に呼ばれる. 
		 * @param	item	表示アイテム. 
		 * @param	index	表示アイテムインデックス. 
		 * @param	num		表示アイテムの総数. 
		 * @param	extra	リレーオブジェクト. 各atDrawItem間で共有されるので、値を変更すると次のアイテムに渡される. 
		 */
		override protected function atDrawItem(item:DisplayObject, index:int, num:int, extra:Object):void {
			extra.rotation += 360 / num;
			item.rotation = extra.rotation;
		}
		
		
	}

}