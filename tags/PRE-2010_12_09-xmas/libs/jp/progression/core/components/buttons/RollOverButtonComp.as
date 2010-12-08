﻿/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.92
 * @see http://progression.jp/
 * 
 * Progression Libraries is dual licensed under the "Progression Library License" and "GPL".
 * http://progression.jp/license
 */
package jp.progression.core.components.buttons {
	import jp.progression.casts.buttons.RollOverButton;
	import jp.progression.core.components.buttons.ButtonComp;
	
	[IconFile( "RollOverButton.png" )]
	/**
	 * @private
	 */
	public class RollOverButtonComp extends ButtonComp {
		
		/**
		 * <span lang="ja">ボタンがクリックされた時の移動先を示すシーンパスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="navigatePath", type="String", defaultValue="" )]
		public function get navigatePath():String { return RollOverButton( component ).navigatePath; }
		public function set navigatePath( value:String ):void { RollOverButton( component ).navigatePath = value; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function RollOverButtonComp() {
			// スーパークラスを初期化する
			super( new RollOverButton() );
		}
	}
}
