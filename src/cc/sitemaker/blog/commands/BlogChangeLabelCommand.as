package cc.sitemaker.blog.commands {
	
	import cc.sitemaker.application.models.ApplicationModel;
	import cc.sitemaker.blog.models.BlogModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class BlogChangeLabelCommand extends Command {
		
		[Inject]
		public var model:BlogModel;
		
		override public function execute():void {
			model.labelValue = "Hello in the 'Blog' World! " + new Date().getSeconds();
		}
	}
}