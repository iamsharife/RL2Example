package cc.sitemaker.application.commands {
	
	import cc.sitemaker.application.models.ApplicationModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ChangeLabelCommand extends Command {
		
		[Inject]
		public var model:ApplicationModel;
		
		override public function execute():void {
			model.labelValue = "Hello World!";
		}
	}
}