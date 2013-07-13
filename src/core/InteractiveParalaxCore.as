package core
{
	import com.br.mau.air.window.NativeWindowConfig;
	
	import core.commands.CommandInitStarling;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.br.behavior.commands.CommandCreateErrorDeafault;
	import org.br.behavior.commands.CommandSequence;
	import org.br.behavior.commands.CommandValidadeErrorDefault;
	import org.br.behavior.commands.CommandValidateVersionDefault;
	import org.br.behavior.core.Core;
	import org.br.behavior.patterns.interfaces.ICommand;

	public class InteractiveParalaxCore
	{
		
		private var _scope:Sprite;
		
		public function InteractiveParalaxCore(pScope:Sprite)
		{
			
			_scope = pScope;
			_scope.addEventListener(Event.ADDED_TO_STAGE , _scope_addedToStageHendle );
			
		}
		
		private function _scope_addedToStageHendle(event:Event):void{
			_scope.removeEventListener(Event.ADDED_TO_STAGE , _scope_addedToStageHendle );
			
			NativeWindowConfig.centralizeInScreen( _scope , 1 , 150 , 150 );
			
			var initializers:Vector.<ICommand> = new Vector.<ICommand>();
			var command:ICommand;
			
			command = new CommandInitStarling();
			( command as CommandInitStarling).rootStage = _scope;
			initializers.push(command);
			
			//create bootstrap sequence
			var commandsInitializers:CommandSequence = new CommandSequence( initializers );
			
			//Config the core.
			Core.getInstance().version = "CoreParalaxMediaSliderToInterativeProjection";
			
			Core.getInstance().createCommand = commandsInitializers;
			Core.getInstance().createErrorCommand = new CommandCreateErrorDeafault();
			
			//TODO create custon validadeVeersion process
			Core.getInstance().validateVersionCommand = new CommandValidateVersionDefault();
			Core.getInstance().validateVersionErrorCommand = new CommandValidadeErrorDefault();
			
			Core.getInstance().useLoggers = false;
			
			Core.getInstance().init(_scope , "ParalaxMediaSliderToInterativeProjection'");
			
			
		}
		
	}
}