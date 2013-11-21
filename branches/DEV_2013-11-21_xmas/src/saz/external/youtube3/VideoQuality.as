package saz.external.youtube3
{
	/**
	 * 再生画質定数。
	 * 
	 * @author saz
	 * @see	https://developers.google.com/youtube/flash_api_reference?hl=ja#Playback_quality
	 */
	public class VideoQuality
	{
		
		/**
		 * 解像度が 640x360 ピクセル未満のプレーヤー向け。
		 */
		public static const SMALL:String = "small";
		
		/**
		 * 解像度が 640x360 ピクセル以上のプレーヤー向け。
		 */
		public static const MEDIUM:String = "medium";
		
		/**
		 * 解像度が 854x480 ピクセル以上のプレーヤー向け。
		 */
		public static const LARGE:String = "large";
		
		/**
		 * 解像度が 1280x720 ピクセル以上のプレーヤー向け。
		 */
		public static const HD720:String = "hd720";
		
		/**
		 * YouTube が適切な再生画質を選択します。この設定は、画質レベルをデフォルトの状態に戻し、
		 * それまでに cueVideoById、loadVideoById、setPlaybackQuality の各関数で行った再生画質の設定を無効にします。
		 */
		public static const DEFAULT:String = "default";
		
	}
}