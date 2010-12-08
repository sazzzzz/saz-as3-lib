﻿/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.display {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import jp.nium.core.display.IExDisplayObjectContainer;
	
	/**
	 * <span lang="ja">ChildIterator クラスは、IExDisplayObjectContainer インターフェイスを実装しているクラスと実装していないクラスを同じ構文で走査するためのイテレータクラスです。</span>
	 * <span lang="en">ChildIterator class is an iterator class to scan the class which implements or does not implement the IExDsiplayObjectContainer interface, with same syntax.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class ChildIterator {
		
		/**
		 * インデックスを整理する対象コンテナを取得します。
		 */
		private var _container:DisplayObjectContainer;
		
		/**
		 * 現在のインデックス位置を取得します。
		 */
		private var _index:int = 0;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ChildIterator インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ChildIterator object.</span>
		 * 
		 * @param container
		 * <span lang="ja">関連付けたい DisplayObjectContainer インスタンスです。</span>
		 * <span lang="en">The DisplayObjectContainer instance that want to relate.</span>
		 */
		public function ChildIterator( container:DisplayObjectContainer ) {
			// 引数を保存する
			_container = container;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">現在の対象を返して、次の対象にインデックスを進めます。</span>
		 * <span lang="en">Returns the current object and move the index to the next object.</span>
		 * 
		 * @return
		 * <span lang="ja">現在の対象である DisplayObject インスタンスです。</span>
		 * <span lang="en">The current DisplayObject instance.</span>
		 */
		public function next():DisplayObject {
			var index:int = _index++;
			
			// IExDisplayObjectContainer を実装していれば
			if ( _container is IExDisplayObjectContainer ) {
				return IExDisplayObjectContainer( _container ).children[index] as DisplayObject;
			}
			
			return ( index < _container.numChildren ) ? _container.getChildAt( index ) : null;
		}
		
		/**
		 * <span lang="ja">現在のインデックス位置に対象が存在するかどうかを返します。</span>
		 * <span lang="en">Returns if the object exists in the current index position.</span>
		 * 
		 * @return
		 * <span lang="ja">対象が存在すれば true を、存在しなければ false です。</span>
		 * <span lang="en">Returns true if the object exists and returns false if not.</span>
		 */
		public function hasNext():Boolean {
			return ( _index < _container.numChildren );
		}
		
		/**
		 * <span lang="ja">現在のインデックス位置をリセットします。</span>
		 * <span lang="en">Reset the current index position.</span>
		 */
		public function reset():void {
			_index = 0;
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public function toString():String {
			return "[object ChildIterator]";
		}
	}
}
