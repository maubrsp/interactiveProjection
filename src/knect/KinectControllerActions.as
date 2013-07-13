package knect
{
	import org.br.behavior.actions.ActionGroup;
	
	public class KinectControllerActions extends ActionGroup
	{
		public function KinectControllerActions(commands:Array = null, names:String=null)
		{
			
			if(!commands){
				commands = ["asdf","asdf"];
			};
			
			if(!names){
				names = "asdf,asdf";
			};
			
			super(commands, names);
		}
	}
}