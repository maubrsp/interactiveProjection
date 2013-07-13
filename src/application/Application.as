package application
{
	import org.br.behavior.core.Shell;
	import org.br.behavior.patterns.interfaces.IActionGroup;
	import org.br.behavior.patterns.interfaces.IModel;
	
	public class Application extends Shell
	{
		public function Application(actions:IActionGroup, data:IModel)
		{
			super(actions, data);
		}
		
		
	}
}