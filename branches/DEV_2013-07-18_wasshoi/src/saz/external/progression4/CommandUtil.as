package saz.external.progression4
{
	import caurina.transitions.Tweener;
	
	import jp.progression.commands.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	import jp.progression.commands.managers.*;
	import jp.progression.commands.media.*;
	import jp.progression.commands.net.*;
	import jp.progression.commands.tweens.*;
	
	import saz.util.ObjectUtil;

	public class CommandUtil
	{
		
		/**
		 * 指定したCommandListが内包するCommandすべてを走査して、指定した関数を実行する。
		 * @param list
		 * @param listIterator	CommandList用関数。
		 * @param commandIterator	Command（CommandListじゃない）用関数。
		 * 
		 */
		public static function scanCommand(list:CommandList, listIterator:Function=null, commandIterator:Function=null):void
		{
			var cmd:Command;
			for (var i:int = 0; i < list.numCommands; i++) 
			{
				cmd = list.getCommandAt(i);
				
				if (cmd is CommandList)
				{
					// CommandList
					scanCommand(cmd as CommandList, listIterator, commandIterator);
					
					if (listIterator) listIterator(cmd);
				}else{
					// Command
					if (commandIterator) commandIterator(cmd);
				}
			}
		}
		
		/**
		 * CommandListに含まれるDoTweenerすべてに、removeDoTweener()を実行。
		 * DoTweenerをinterrupt()した時のエラー対策。
		 * 
		 * @param list
		 * 
		 */
		public static function removeAllDoTweener(list:CommandList):void
		{
			scanCommand(list
				,null
				,function(cmd:Command):void
				{
					if (cmd is DoTweener) CommandUtil.removeDoTweener(cmd as DoTweener);
				}
			);
		}
		
		/**
		 * DoTweenerを止めようとしてみる。
		 * 内部で保持してるトィーンプロパティに対して、Tweener.removeTweens()を実行。
		 * 
		 * @param doTweener
		 * 
		 */
		public static function removeDoTweener(doTweener:DoTweener):void
		{
			if (doTweener.target == null || doTweener.parameters == null) return;
			
			var keys:Array = ObjectUtil.propNames(doTweener.parameters);
			var param:Array = [doTweener.target].concat(keys);
			Tweener.removeTweens.apply(null, param);
		}
		
		
	}
}