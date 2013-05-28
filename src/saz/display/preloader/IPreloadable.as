package saz.display.preloader
{
	import flash.display.Loader;

	public interface IPreloadable
	{
		function atLoadOpen(loader:Loader):void;
		function atLoadComplete(loader:Loader):void;
		function atLoadProgress(loader:Loader, bytesLoaded:Number, bytesTotal:Number):void;
	}
}