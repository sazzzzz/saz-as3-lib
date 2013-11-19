package saz.external.youtube3
{
	public class PlayerWrapper
	{
		
		public var player:Object;
		
		public function PlayerWrapper(youtubePlayer:Object=null)
		{
			player = youtubePlayer;
		}
		
		/**
		 * プレーヤーのサイズをピクセル単位で設定します。MovieClip の width プロパティと height プロパティの代わりにこのメソッドを使うことをおすすめします。
		 * このメソッドは動画プレーヤーの縦横比を固定しないので、4:3 のアスペクト比が維持されるように注意する必要があります。
		 * 別の SWF に読み込まれたときのクロムレス SWF のデフォルト サイズは 320x240 ピクセルで、埋め込みプレーヤー SWF のデフォルト サイズは 480x385 ピクセルです。
		 * 
		 * @param width
		 * @param height
		 * 
		 */
		public function setSize(width:Number, height:Number):void
		{
			player.setSize(width, height);
		}
		
		/**
		 * この関数は、現在の動画の推奨画質を設定し、現在の位置から新しい画質で動画をリロードします。再生画質を変更した場合、再生している動画の画質のみが変更されます。
		 * 
		 * @param suggestedQuality
		 * 
		 */
		public function setPlaybackQuality(suggestedQuality:String):void
		{
			player.setPlaybackQuality(suggestedQuality);
		}
		
		/**
		 * この関数は、現在の動画で有効な画質のセットを返します。この関数を使用すると、ユーザーが表示している画質よりも高い画質で動画を再生できるかどうかを判断し、プレーヤーにボタンなどの要素を表示してユーザーが画質を調整できるようにすることができます。
		 * 
		 * この関数は、高画質から低画質の順で、画質を示す文字列の配列を返します。配列要素の値には、hd720、large、medium、small があります。現在の動画がない場合、この関数は空の配列を返します。
		 * 
		 * クライアントで、最高または最低の画質や不明な画質形式に自動的に切り替えないようにしてください。YouTube は、お使いのプレーヤーに適さない画質レベルを追加する可能性があります。
		 * 同様に、ユーザー操作の妨げとなり得る画質オプションを削除する可能性もあります。有効な既知の画質形式のみに切り替えるようにすることで、クライアントは、新しい画質レベルの追加やプレーヤーに適さない画質レベルの削除による影響を受けなくなります。
		 * 
		 * @return 
		 * 
		 */
		public function getAvailableQualityLevels():Array
		{
			return player.getAvailableQualityLevels();
		}
	}
}