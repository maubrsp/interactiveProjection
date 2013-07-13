package core.commands
{
	import flash.display.Sprite;
	
	import org.br.behavior.commands.Command;
	import org.br.behavior.controllers.Broadcaster;
	import org.br.behavior.core.Core;
	import org.br.behavior.events.EventAction;
	
	import starling.ViewController;
	
	import utils.AppConstants;
	
	/**
	 * Add view with starling to shell controll.
	 * @author maurício césar
	 */
	public class CommandInitStarling extends Command
	{
		
		/**
		 * Class Constructor
		 */
		public function CommandInitStarling()
		{
			super();
		}
		
		/**
		 * Set the root application. 
		 */
		public var rootStage:Sprite;
		
		/**
		 * @inheritDoc
		 */
		override public function execute(pScope:Object):void{
			super.execute(pScope);
			
			var viewController:ViewController = new ViewController(rootStage);
			viewController.version = AppConstants.SHELL_VIEW;
			
			Broadcaster.getInstance().dispatchEvent(
				new EventAction(
					EventAction.EXECUTE_ACTION , 
					Core.ADD_SHELL , 
					this ,
					null,
					null ,		
					viewController,
					sucess )
			);
			
		}
		
	}
}