package saz.dev
{
	import saz.util.ObjectUtil;

	/**
	 * URLを扱うクラス。つくりかけ。
	 * これで何度目かわからないが、今度は正規表現で実装。
	 * @author saz
	 * 
	 */
	public class UrlAlt
	{
		
		public function get url():String {
			return _url;
		}
		
		public function set url(value:String):void {
			parse(value);
			_url = value;
		}
		private var _url:String = "";
		
		
		
		
		private var _protocol:String = "";
		private var _host:String = "";
		private var _port:String = "";
		private var _dir:String = "";
		private var _file:String = "";
		private var _param:String = "";
		private var _anchor:String = "";
		
		
		public function UrlAlt(url:String=null)
		{
			if (url) this.url = url;
		}
		
		
		
		private function parse(value:String):void
		{
			var re:RegExp = new RegExp("(https?|ftp)://([^:/]+)(:(\d+))?(/([^/]+/)*)?([^/?#]*)?(&#038;[^#]*)?(#.*)?", "g");
//			var re:RegExp = new RegExp("(https?|ftp)://([^:/]+)(:(\d+))?(/([^/]+/)*)?([^/?#]*)?(&#038;[^#]*)?", "g");
			
//			var re:RegExp = new RegExp("(https?|ftp)://([^:/]+)(:(\d+))?(/([^/]+/)*)?([^/?#]*)?(\?[^#]*)?(#.*)?", "g");
//			var re:RegExp = new RegExp("(https?|ftp)://([^:/]+)(:(\d+))?(/([^/]+/)*)?([^/?#]*)?(\?[^#]*)?", "g");
//			var re:RegExp = new RegExp("(https?|ftp)://([^:/]+)(:(\d+))?(/([^/]+/)*)?([^/?#]*)?", "g");
//			var re:RegExp = new RegExp("(https?|ftp)://([^:/]+)(:(\d+))?(/([^/]+/)*)?", "g");
//			var re:RegExp = new RegExp("(https?|ftp)://([^:/]+)(:(\d+))?", "g");
//			var re:RegExp = new RegExp("(https?|ftp)://([^:/]+)", "g");
			
//			var re:RegExp = new RegExp("(https?|ftp)(://[[:alnum:]\+\$\;\?\.%,!#~*/:@&#038;=_-]+)", "g");
			
			var match:Array = value.match(re);
			ObjectUtil.traceObject(match);
			
			var split:Array = value.split(re);
			ObjectUtil.traceObject(split);
			
		}		
	}
}