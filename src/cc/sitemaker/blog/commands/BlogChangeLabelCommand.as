package cc.sitemaker.blog.commands {
	
	import cc.sitemaker.application.models.ApplicationModel;
	import cc.sitemaker.blog.models.BlogModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;
	
	public class BlogChangeLabelCommand extends Command {
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var model:BlogModel;
		
		private var _logger:ILogger;
		
		override public function execute():void {
			_logger = context.getLogger(this); 
			
			_logger.debug("execute");
			
			model.labelValue = "Hello in the 'Blog' World! " + new Date().getSeconds();
		}
	}
}