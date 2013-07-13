package core.commands
{
	import assets.AssetsManager;
	
	import configuration.Config;
	
	import knect.KinectController;
	
	import org.br.behavior.commands.Command;
	import org.br.behavior.controllers.Broadcaster;
	import org.br.behavior.core.Core;
	import org.br.behavior.events.EventAction;
	
	import utils.AppConstants;
	
	public class CommandInitializeSequence extends Command
	{
		
		
		
		public function CommandInitializeSequence()
		{
			super();
		}
		
		override public function execute(pScope:Object):void{
			super.execute(pScope);
			
			trace(pScope , "<<<<<<")
			
			var config:Config = new Config();
			config.version = AppConstants.SHELL_CONFIG;
			
			Broadcaster.getInstance().dispatchEvent(
				new EventAction(
					EventAction.EXECUTE_ACTION , 
					Core.ADD_SHELL , 
					this ,
					null,
					null ,		
					config ,
					config_initCompletHandle )
			);
			
		}
		
		
		private function config_initCompletHandle():void{
			
			Broadcaster.getInstance().dispatchEvent(
				new EventAction(
					EventAction.EXECUTE_ACTION , 
					AppConstants.GET_CONFIGURATION , 
					this ,
					null,
					null ,		
					null ,
					getConfiguration_completeHandle )
			);
			
		}
		
		private function getConfiguration_completeHandle():void{
			var assetsManager:AssetsManager = new AssetsManager();
			assetsManager.version = AppConstants.SHELL_ASSETS_MANAGER;
			
			Broadcaster.getInstance().dispatchEvent(
				new EventAction(
					
					EventAction.EXECUTE_ACTION , 
					Core.ADD_SHELL , 
					this ,
					null,
					null ,		
					assetsManager ,
					assets_initCompleteHandle )
				
			);
		}
		private function assets_initCompleteHandle(data:Object):void{
			
			Broadcaster.getInstance().dispatchEvent(
				new EventAction(
					EventAction.EXECUTE_ACTION , 
					AppConstants.VIEW_INIT_GALLERY , 
					this ,
					null,
					null ,		
					null ,
					gallery_initCompleteHandle )
			);
			
		}
		
		private function gallery_initCompleteHandle():void{
			
			var kinectManager:KinectController = new KinectController();
			kinectManager.version = AppConstants.SHELL_KINECT;
			//kinectManager.view = 
			Broadcaster.getInstance().dispatchEvent(
				new EventAction(
					
					EventAction.EXECUTE_ACTION , 
					Core.ADD_SHELL , 
					this ,
					null,
					null ,		
					kinectManager ,
					kinect_initCompleteHandle )
				
			);
			
		}
		
		private function kinect_initCompleteHandle():void{
			
			
			trace("kinect added")
			
		}
		
	}
}