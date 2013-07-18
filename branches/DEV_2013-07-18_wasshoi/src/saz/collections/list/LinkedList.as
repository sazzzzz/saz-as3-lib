package saz.collections.list {
	import flash.errors.IllegalOperationError;
	import saz.collections.enumerator.*;
	import saz.ICore;
	import saz.util.ObjectUtil;
	/**
	 * IListを実装した連結リスト.
	 * @author saz
	 * @see	http://ja.wikipedia.org/wiki/%E9%80%A3%E7%B5%90%E3%83%AA%E3%82%B9%E3%83%88
	 * @see	http://msdn.microsoft.com/ja-jp/library/he2s3bh7.aspx
	 * @see	http://java.sun.com/j2se/1.5.0/ja/docs/ja/api/java/util/LinkedList.html
	 */
	public class LinkedList implements IList, IEnumerator, IEnumeration, ICore {
		
		private var _first:Element;
		private var _last:Element;
		private var _count:int;
		
		/**
		 * コンストラクタ. 
		 */
		public function LinkedList() {
		}
		
		// TODO	キュー、スタックを実装すべき。
		// TODO	高速化のためにインスタンスプールを使用？
		
		
		/* http://ja.wikipedia.org/wiki/%E9%80%A3%E7%B5%90%E3%83%AA%E3%82%B9%E3%83%88 */
		/*
		 * （片方向リストは）逆方向に繰り返すことができないので、"insertBefore" や "removeBefore" といった操作を効率的に実装することはできない。
		 * 片方向リストの操作は先頭ノードの扱いが特殊であるが、先頭にダミー要素を追加することでこれを排除できる。
		 * これによって、"insertBeginning()" や "removeBeginning()" が不要となる。
		 * この場合、最初のデータを持ったノードは "list.firstNode.next" で参照可能である。
		 * 
		 * 双方向リストでは…特殊ケースの関数が不要になる。ノードには前の要素を指す "prev" フィールドが追加される。
		 * また リスト構造の "lastNode" が最後尾のノードを指す。空のリストの場合、"list.firstNode" も "list.lastNode" も "null" である。
		 */
		
		/*private function _loop():void {
			var e:Element = _first;
			while (e != null) {
				// do something
				
				e = e.next;
			}
		}
		// newElementをelementの次に挿入
		private function _insertAfter(element:Element, newElement:Element):void {
			newElement.next = element.next;
			element.next = newElement;
			newElement.prev = element.prev;
			element.prev = newElement;
		}
		// 現在の先頭ノードの前にノードを挿入
		private function _insertBeginning(newElement:Element):void {
			_first.prev = newElement;
			newElement.next = _first;
			_first = newElement;
		}
		// このノードの次のノードを削除
		private function _removeAfter(element:Element):void {
			var obsolete:Element = element.next;	//いらないもの
			element.next = element.next.next;
			element.next.prev = element;
			obsolete.destroy();
		}
		// 先頭ノードを削除
		private function _removeBeginning():void {
			var obsolete:Element = _first;	//いらないもの
			_first = _first.next;
			_first.next.prev = _first;
			obsolete.destroy();
		}*/
		
		
		
		/* INTERFACE saz.collections.list.IList */
		
		/**
		 * @inheritDoc
		 */
		public function get(index:int):* {
			var o:Object = _getElementAt(index);
			return (o.index == -1) ? undefined : o.element.data;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set(index:int, item:*):void {
			var o:Object = _getElementAt(index);
			if (o.index == -1) return;
			
			var e:Element = Element(o.element);
			var ne:Element = new Element(item);
			/*if (e.prev != null) {
				e.prev.next = ne;
				ne.prev = e.prev;
			}
			if (e.next != null) {
				e.next.prev = ne;
				ne.next = e.next;
			}*/
			_swapElement(e, ne);
			e.destroy();
		}
		
		/**
		 * @inheritDoc
		 */
		public function insert(index:int, item:*):void {
			var ne:Element = new Element(item);
			
			if (index == 0) {
				_first.prev = ne;
				ne.next = _first;
				_first = ne;
			}else if (index == count) {
				_last.next = ne;
				ne.prev = _last;
				_last = ne;
			}else{
				var o:Object = _getElementAt(index);
				if (o.index == -1) return;
				var e:Element = Element(o.element);
				if (e.prev != null) {
					ne.prev = e.prev;
					e.prev.next = ne;
				}
				ne.next = e;
				e.prev = ne;
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		public function removeAt(index:int):void {
			/*if (index == 0) {
				_removeFirstElement();
			}else if (index == count - 1) {
				_removeLastElement();
			}else{
				var o:Object = _getElementAt(index);
				if (o.index == -1) return;
				_removeMiddleElement(Element(o.element));
			}*/
			var o:Object = _getElementAt(index);
			if (o.index == -1) return;
			_removeElement(Element(o.element));
		}
		
		/**
		 * @inheritDoc
		 */
		public function indexOf(item:*):int {
			var res:int = -1;
			var e:Element = _first;
			var i:int = 0;
			while (e != null) {
				if (item == e.data) return i;
				e = e.next;
				i++;
			}
			return res;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get count():int {
			// TODO	更新タイミングを最適化できそう. 
			_updateCount();
			return _count;
		}
		
		private function _updateCount():void {
			var res:int = 0;
			forEach(function(item:*, index:int, collection:Object):void {
				res++;
			});
			_count = res;
		}
		
		/**
		 * @inheritDoc
		 */
		public function add(item:*):void {
			var ne:Element = new Element(item);
			if (_first == null) {
				_first = _last = ne;
			}else {
				_last.next = ne;
				ne.prev = _last;
				_last = ne;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear():void {
			var e:Element = _first;
			var n:Element;
			while (e != null) {
				n = e.next;
				e.destroy();
				e = n;
			}
			_first = _last = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains(item:*):Boolean {
			var o:Object = _searchElement(item);
			return (o.index > -1);
		}
		
		/**
		 * @inheritDoc
		 */
		public function copyTo(arr:Array, arrIndex:int = 0):void {
			var ai:int = arrIndex - 1;
			forEach(function(item:*, index:int, collection:Object):void {
				ai++;
				arr[ai] = item;
			});
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(item:*):Boolean {
			var o:Object = _searchElement(item);
			if (o.index == -1) return false;
			
			/*if (o.index == 0) {
				_removeFirstElement();
			}else if (o.index == count - 1) {
				_removeLastElement();
			}else{
				_removeMiddleElement(Element(o.element));
			}*/
			_removeElement(Element(o.element));
			return true;
		}
		
		/* INTERFACE saz.collections.enumerator.IEnumerator */
		
		/**
		 * @inheritDoc
		 */
		public function forEach(callback:Function, thisObject:* = null):void {
			if (_first == null) return;
			
			var e:Element = _first;
			var i:int = 0;
			while (e != null) {
				callback.call(thisObject, e.data, i, this);
				e = e.next;
				i++;
			}
		}
		
		/* INTERFACE saz.collections.enumerator.IEnumeration */
		
		/**
		 * @inheritDoc
		 */
		public function enumerator():IEnumerator {
			throw new IllegalOperationError("このメソッドは実装されていません。");
			return new ArrayEnumerator(new Array());	// FIXME	ダミー
		}
		
		/* INTERFACE saz.ICore */
		
		/**
		 * @inheritDoc
		 */
		public function equals(item:*):Boolean {
			throw new IllegalOperationError("このメソッドは実装されていません。");
			return true;	// FIXME	ダミー
		}
		
		/**
		 * @inheritDoc
		 */
		public function clone():* {
			var res:LinkedList = new LinkedList();
			forEach(function(item:*, index:int, collection:Object):void {
				res.add(item);
			});
			return res;
		}
		
		/**
		 * @inheritDoc
		 */
		public function destroy():void {
			clear();
		}
		
		/**
		 * @inheritDoc
		 */
		public function toString():String {
			return toArray().join(",");
		}
		
		
		/* ORIGINAL */
		
		
		public function get last():* {
			return (_last == null) ? null : _last.data;
		}
		
		public function get first():* {
			return (_first == null) ? null : _first.data;
		}
		
		public function toArray():Array {
			var res:Array = new Array(count);
			copyTo(res, 0);
			return res;
		}
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * 指定したインデックス位置のElementとインデックス値を返す. 
		 * @param	index
		 * @return
		 */
		private function _getElementAt(index:int):Object {
			var e:Element = _first;
			var i:int = 0;
			while (e != null) {
				if (i == index) return { index:i, element:e };
				e = e.next;
				i++;
			}
			return { index:-1, element:undefined };
		}
		
		/**
		 * 指定したアイテムを探し、Elementとインデックス値を返す. 
		 * @param	item
		 * @return
		 */
		private function _searchElement(item:*):Object {
			var e:Element = _first;
			var i:int = 0;
			while (e != null) {
				if (e.data === item) return { index:i, element:e };
				e = e.next;
				i++;
			}
			return { index:-1, element:undefined };
		}
		
		/**
		 * Elementを入れ替える. 
		 * @param	oe	古いElement
		 * @param	ne	新しいElement
		 */
		private function _swapElement(oe:Element, ne:Element):void {
			if (oe.prev != null) {
				oe.prev.next = ne;
				ne.prev = oe.prev;
			}
			if (oe.next != null) {
				oe.next.prev = ne;
				ne.next = oe.next;
			}
		}
		
		/**
		 * 指定要素を削除. 
		 * @param	e
		 */
		private function _removeElement(e:Element):void {
			if (_first == _last && _first == e) {
				_first = _last = null;
			}else {
				if (e == _first && e.next != null) {
					_first = e.next;
					_first.prev = null;
				}
				if (e == _last && e.prev != null) {
					_last = e.prev;
					_last.next = null;
				}
				if (e.prev != null) e.prev.next = e.next;
				if (e.next != null) e.next.prev = e.prev;
			}
			/*if (e == _first) {
				if(e.next != null) {
					_first = e.next;
					_first.prev = null;
				}else {
					_first = null;
				}
			}
			if (e == _last) {
				if(e.prev != null) {
					_last = e.prev;
					_last.next = null;
				}else {
					_last = null;
				}
			}*/
			if (e.prev != null) e.prev.next = e.next;
			if (e.next != null) e.next.prev = e.prev;
			e.destroy();
		}
		
		/**
		 * 最初の要素を削除する. 
		 */
		/*private function _removeFirstElement():void {
			if (_removeOne()) return;
			
			var e:Element = _first;
			_first = e.next;
			_first.prev = null;
			e.destroy();
		}*/
		
		/**
		 * 最後の要素を削除する. 
		 */
		/*private function _removeLastElement():void {
			if (_removeOne()) return;
			
			var e:Element = _last;
			_last = e.prev;
			_last.next = null;
			e.destroy();
		}*/
		
		/**
		 * 指定要素を削除. 
		 * @param	e
		 */
		/*private function _removeMiddleElement(e:Element):void {
			if (_removeOne()) return;
			
			e.prev.next = e.next;
			e.next.prev = e.prev;
			e.destroy();
		}*/
		
		/**
		 * 要素が1つだけの時削除する. 
		 * @return	削除したらtrue、しなかったらfalseを返す. 
		 */
		/*private function _removeOne():Boolean {
			if (_first == _last) {
				_first.destroy();
				_first = _last = null;
				return true;
			}else {
				return false;
			}
		}*/
		
	}
}

/**
 * LinkedList用エレメントクラス（内部クラス）. 
 */
internal class Element {
	public var data:*;
	public var prev:Element = null;
	public var next:Element = null;
	
	public function Element(intData:*) {
		data = intData;
	}
	
	public function destroy():void {
		data = prev = next = null;
	}
	
	public function toString():String {
		return ["data:" + data, "prev:" + prev, "next:" + next].join(",");
	}
}
