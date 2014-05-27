package saz.external.progression4
{
	import jp.progression.commands.*;
	import jp.progression.commands.lists.SerialList;
	import jp.progression.commands.tweens.DoTweener;
	import jp.progression.executors.ExecutorObjectState;
	
	import saz.util.ObjectUtil;

	/**
	 * 同時に実行するコマンドを1つに制限する。
	 * 後から実行開始したものが優先され、古いものは停止される。
	 * @author saz
	 * 
	 */
	public class CommandExcluder
	{
		
		public var defaultParams:Object = {};
		
		protected var lastExecutedCommand:CommandList;
		protected var lastDefinedCommand:CommandList;
		
		public function CommandExcluder()
		{
		}
		
		
		//--------------------------------------
		// public
		//--------------------------------------
		
		
		/**
		 * 新しいCommandListをつくる。
		 * @param params
		 * @param autoDispose	（実験的）コマンドを自動でdispose()する。
		 * @return 
		 * 
		 */
		public function createCommand(params:Object=null, autoDispose:Boolean=true):CommandList
		{
			// あんまし関係ないみたい…
			/*var opt:Object = {interruptType:CommandInterruptType.ABORT};*/
			var opt:Object = {};
			ObjectUtil.setProperties(opt, defaultParams);
			ObjectUtil.setProperties(opt, params);
			
			lastDefinedCommand = new SerialList(opt
				,new Func(function():void
				{
					interruptCommand(lastExecutedCommand);
					if (autoDispose) disposeCommand(lastExecutedCommand);
					
					lastExecutedCommand = CommandList(this.parent);
				})
			);
			return lastDefinedCommand;
		}
		
		
		
		public function createAddCommand(params:Object=null, ...commands):CommandList
		{
			var cmd:CommandList = createCommand(params);
			
			commands.forEach(function(item:Object, index:int, arr:Array):void
			{
				cmd.addCommand(item);
			});
			
			return cmd;
		}
		
		
		/**
		 * 停止。
		 * 
		 */
		public function interrupt(enforced:Boolean = false):void
		{
			interruptCommand(lastExecutedCommand, enforced);
			interruptCommand(lastDefinedCommand, enforced);
		}
		
		
		/**
		 * デストラクタ。
		 * 
		 */
		public function destroy():void
		{
			interruptCommand(lastExecutedCommand);
			disposeCommand(lastExecutedCommand);
			lastExecutedCommand = null;
			
			interruptCommand(lastDefinedCommand);
			disposeCommand(lastDefinedCommand);
			lastDefinedCommand = null;
		}
		
		
		//--------------------------------------
		// protected
		//--------------------------------------
		
		
		protected function interruptCommand(command:CommandList, enforced:Boolean = false):void
		{
			if (command && command.state == ExecutorObjectState.EXECUTING)
			{
				// 先にinterrupt()する
				command.interrupt(enforced);
				
				// DoTweenerをremoveTweens()する ← これでエラーが抑制できた！
				if (command is CommandList)
				{
					CommandUtil.removeAllDoTweener(command as CommandList);
				}
			}
		}
		
		
		protected function disposeCommand(command:CommandList):void
		{
			if (command) command.dispose();
		}
		
	}
}