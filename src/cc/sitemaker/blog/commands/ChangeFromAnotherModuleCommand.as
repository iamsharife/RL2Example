package cc.sitemaker.blog.commands
{
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;
	
	public class ChangeFromAnotherModuleCommand extends Command {
		
		[Inject]
		public var context:IContext;
		
		private var _logger:ILogger;
		
		override public function execute():void {
			
			_logger = context.getLogger(this); 
			
			_logger.debug("execute");
			_logger.debug("NOTE: Problem here is that the command is executed on ModuleCommandMap which is an injection that exists in the Top Level Context (ApplicationConfig)");
		}
	}
}