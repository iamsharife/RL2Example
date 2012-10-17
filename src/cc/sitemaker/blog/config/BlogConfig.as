package cc.sitemaker.blog.config {
	
	import cc.sitemaker.application.events.ChangeLabelEvent;
	import cc.sitemaker.blog.commands.BlogChangeLabelCommand;
	import cc.sitemaker.blog.models.BlogModel;
	import cc.sitemaker.blog.views.BlogView;
	import cc.sitemaker.blog.views.BlogViewMediator;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	
	public class BlogConfig {
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var injector:Injector;
		
		/*
		 * PostConstruct is used to ensure all injections are ready 
		*/
		[PostConstruct]
		public function init():void {
			configure();
		}
		
		private function configure():void {
			
			context.logLevel = LogLevel.DEBUG;
			context.lifecycle.afterInitializing( afterInitializing );
			
			mapModels();
			mapViews();
			mapCommands();
		}
		
		private function mapModels():void {
			injector.map(BlogModel).asSingleton();
		}		
		
		private function mapViews():void {
			mediatorMap.map(BlogView).toMediator(BlogViewMediator);
		}		
		
		private function mapCommands():void {
			commandMap.map(ChangeLabelEvent.CHANGE_LABEL_REQUEST).toCommand(BlogChangeLabelCommand);
		}		
		
		private function afterInitializing():void {
			
		}
		
	}
}