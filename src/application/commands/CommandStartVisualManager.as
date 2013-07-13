package application.commands
{
	import flash.display.Sprite;
	
	import org.br.behavior.commands.Command;
	
	public class CommandStartVisualManager extends Command
	{
		
		public var root:Sprite;
		
		public function CommandStartVisualManager()
		{
			super();
		}
		
		override public function execute(scope:Object):void{
			if(!root) throw new Error("Root element is required");
			
			
		}
	}
}