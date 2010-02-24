package saz.group {
	import flash.events.*;
	import saz.events.GroupEvent;
	import saz.IteratorBreakError;
	import saz.util.ArrayUtil;
	import saz.util.ObjectUtil;
	
	/**
	 * ...
	 * @author saz
	 */
	public class SelectableGroup extends EventDispatcher {
		
		private var $isRunning:Boolean;
		
		private var $selectedEntry:Object;
		private var $items:Array;
		
		function SelectableGroup() {
			this.$isRunning = false;
			this.$selectedEntry = null;
			this.$items = new Array();
		}
		
		public function get isSelect():Boolean {
			return (this.$selectedEntry != null);
		}
		
		public function get selectedItem():IEventDispatcher {
			if (this.isSelect) {
				return this.$selectedEntry.target;
			}else {
				return null;
			}
		}
		
		public function get selectedIndex():int {
			if (this.isSelect) {
				return this.getIndex(this.selectedItem);
			}else {
				return -1;
			}
		}
		
		public function get selectedId():String {
			if (this.isSelect) {
				return this.getId(this.selectedItem);
			}else {
				return "";
			}
		}
		
		/**
		 * 登録アイテム数。
		 * @return
		 */
		public function get count():int {
			return this.$items.length;
		}
		
		/**
		 * インデックス値で指定したアイテムを返す。
		 * @param	index
		 * @return
		 */
		public function getItemByIndex(index:int):IEventDispatcher {
			return this.$items[index].target;
		}
		
		/**
		 * idで指定したアイテムを返す。
		 * @param	id
		 * @return
		 */
		public function getItemById(id:String):IEventDispatcher {
			var res:IEventDispatcher;
			ArrayUtil.each(this.$items, function(curItem:Object, curIndex:int):void {
				if (id == curItem.id) {
					res = curItem.target;
					throw(new IteratorBreakError());
				}
			});
			return res;
		}
		
		
		public function start():void {
			if (this.$isRunning) return;
			
			this.$isRunning = true;
			var scope:SelectableGroup = this;
			var target:IEventDispatcher;
			ArrayUtil.each(this.$items, function(curItem:Object, curIndex:int):void {
				target = curItem.target;
				target.addEventListener(curItem.event, scope.$onAction);
			});
		}
		
		public function stop():void {
			if (this.$isRunning == false) return;
			
			this.$isRunning = false;
			var scope:SelectableGroup = this;
			var target:IEventDispatcher;
			ArrayUtil.each(this.$items, function(curItem:Object, curIndex:int):void {
				target = curItem.target;
				target.removeEventListener(curItem.event, scope.$onAction);
			});
		}
		
		public function destroy():void {
			this.stop();
			ArrayUtil.removeAll(this.$items);
		}
		
		
		/**
		 * 指定アイテムのインデックス値を調べる。
		 * @param	item
		 * @return	見つからない場合は-1を返す。
		 */
		public function getIndex(item:IEventDispatcher):int {
			/*var index:Number = -1;
			ArrayUtil.each($items, function(curItem:DispatchableInterface, curIndex:Number) {
				if (item == curItem) index = curIndex;
			});
			return index;*/
			var search:Object = this.$searchEntry(item);
			return search.index;
		}
		
		/**
		 * 指定アイテムのidを調べる。
		 * @param	item
		 * @return	見つからない場合は""を返す。
		 */
		public function getId(item:IEventDispatcher):String {
			//return "";
			var search:Object = this.$searchEntry(item);
			return search.entry.id;
		}
		
		/**
		 * アイテムを追加する。
		 * @param	item
		 * @param	eventName
		 * @param	selectHandle
		 * @param	unselectHandle
		 * @param	id
		 * @return	登録したアイテムのインデックス値。
		 */
		//public function add(item:IEventDispatcher, eventName:String, selectClosure:Function, unselectClosure:Function, id:String):void {
		public function add(item:IEventDispatcher, eventName:String, selectHandle:String, unselectHandle:String, id:String = ""):int {
			//trace("SelectableGroup.add(" + arguments);
			var newItem:Object = { target:item, event:eventName, select:selectHandle, unselect:unselectHandle, id:id };
			//trace(newItem);
			//trace(ObjectUtil.dump(newItem));
			this.$items.push( newItem );
			return this.$items.length - 1;
		}
		
		public function remove(item:IEventDispatcher):void {
			var index:int = this.getIndex(item);
			this.$items.splice(index, 1);
		}
		
		public function select(item:IEventDispatcher):void {
			//trace("SelectableGroup.select(" + arguments);
			
			if (this.$isRunning == false) return;
			
			if (this.$selectedEntry != null) {
				var oldItem = this.$selectedEntry.target;
				if (item == oldItem) return;		//変わってないので処理中止
				//unselect
				oldItem[this.$selectedEntry.unselect]();
			}
			
			//select
			this.$selectedEntry = this.$searchEntry(item).entry;
			
			//var search:Object = this.$searchEntry(item);
			var select:String = this.$searchEntry(item).entry.select;
			item[select]();
		}
		
		public function unselect():void {
			if (this.$isRunning == false) return;
			
			if (this.$selectedEntry != null) {
				var oldItem = this.$selectedEntry.target;
				//unselect
				oldItem[this.$selectedEntry.unselect]();
				this.$selectedEntry = null;
			}
		}
		
		private function $searchEntry(item:IEventDispatcher):Object {
			var entry:Object;
			var index:int = -1;
			ArrayUtil.each(this.$items, function(curItem:Object, curIndex:int):void {
				if (item == curItem.target) {
					entry = curItem;
					index = curIndex;
					//throw(new Error("みつかった"));
					throw(new IteratorBreakError());
				}
			});
			return { entry:entry, index:index };
		}
		
		// イベントリスナ。イベント発行するだけ。
		private function $onAction(e:Event):void{
			//this.dispatchEvent(new Event(GroupEvent.CHANGED));
			var event:GroupEvent = new GroupEvent(GroupEvent.CHANGED);
			event.oldValue = this.selectedItem;
			event.newValue = e.target;
			this.dispatchEvent(event);
		}
	}
	
}