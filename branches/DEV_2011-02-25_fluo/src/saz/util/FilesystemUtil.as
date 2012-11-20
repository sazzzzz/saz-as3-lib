package saz.util {
	import flash.filesystem.File;
	/**
	 * flash.filesystem関連ユーティリティー.
	 * @author saz
	 */
	public class FilesystemUtil {
		
		/**
		 * Fileインスタンスから、ベースネームを返す. "001.txt"->"001". 
		 * @param	file	Fileインスタンス. 
		 * @return
		 */
		public static function getBasenameFromFile(file:File):String {
			return file.name.slice(0, -file.extension.length - 1);
		}
		
	}

}