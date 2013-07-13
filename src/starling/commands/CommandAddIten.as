package starling.commands
{
	
	import org.br.behavior.commands.Command;
	
	import starling.ViewStarling;
	import starling.display.DisplayObject;
	
	public class CommandAddIten extends Command
	{
		/**
		 * 
		 * 
		 */
		public function CommandAddIten()
		{
			super();
		}
		
		override public function execute(scope:Object):void
		{
			super.execute(scope);
			(shell.view as ViewStarling).addChild(data as DisplayObject);
			sucess();
		}
		
		
		
	}
}