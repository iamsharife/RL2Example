package cc.sitemaker.application.commands {
	
	import cc.sitemaker.application.models.ApplicationModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;
	
	public class ChangeLabelCommand extends Command {
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var model:ApplicationModel;
		
		private var _logger:ILogger;
		
		override public function execute():void {
			_logger = context.getLogger(this); 
			
			_logger.debug("execute");
			
			model.labelValue = "Hello World! " + new Date().getSeconds();
		}
	}
}