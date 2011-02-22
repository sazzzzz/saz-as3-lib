package saz.display.loading {
	import flash.display.*;
	
	/**
	 * ...
	 * @author saz
	 */
	public class SimpleCircularLoading extends LoadingIndicatorBase {
		
		/**
		 * 半径
		 */
		public var radius:Number = 9.0;
		/**
		 * 回転するスピード. 単位は度. 
		 */
		public var speed:Number = 4.0;
		/**
		 * 基準となる角度. 
		 */
		public var baseRotation:Number = 0.0;
		
		
		public function SimpleCircularLoading() {
			super();
		}
		
		
		/**
		 * 表示するDisplayObjectの生成メソッドを定義する. 
		 * @param	index	表示アイテムインデックス. 
		 * @param	num		表示アイテムの総数. 
		 * @param	extra	リレーオブジェクト. 各atCreateItem間で共有されるので、値を変更すると次のアイテムに渡される. 
		 */
		override protected function atCreateItem(index:int, num:int, extra:Object):DisplayObject {
			var res:Shape = new Shape();
			var g:Graphics = res.graphics;
			g.lineStyle();
			g.beginFill(0xFFFFFF, 1.0);
			g.drawRect( -1, -1, 3, 3);
			return res;
		}
		
		/**
		 * 表示更新時に呼ばれる. この直後にatDrawItemが実行される. 
		 * @param	extra	各atDrawItemに渡されるリレーオブジェクト. プロパティを追加して各atDrawItem内で使用する. 
		 */
		override protected function atDraw(extra:Object):void {
			baseRotation += speed;
			extra.radian = baseRotation * 2 * Math.PI / 360;
		}
		
		/**
		 * 各アイテムの描画更新メソッド. atDraw直後に呼ばれる. 
		 * @param	item	表示アイテム. 
		 * @param	index	表示アイテムインデックス. 
		 * @param	num		表示アイテムの総数. 
		 * @param	extra	リレーオブジェクト. 各atDrawItem間で共有されるので、値を変更すると次のアイテムに渡される. 
		 */
		override protected function atDrawItem(item:DisplayObject, index:int, num:int, extra:Object):void {
			extra.radian += 2 * Math.PI / num;
			item.x = Math.cos(extra.radian) * radius;
			item.y = Math.sin(extra.radian) * radius;
		}
		
		
		/**
		 * ADDED_TO_STAGE直後に呼ばれる. 主に表示アニメーションを行う. showComplete()を実行すること！
		 */
		override protected function atShow():void {
			visible = true;
			//
			showComplete();
		}
		
		/**
		 * REMOVED_FROM_STAGE後に呼ばれる. 主に消えるアニメーションを行う. hideComplete()を実行すること！
		 */
		override protected function atHide():void {
			visible = false;
			//
			hideComplete();
		}
		
	}

}