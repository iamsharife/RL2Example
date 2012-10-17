package cc.sitemaker.application.config {
	import cc.sitemaker.application.commands.ChangeLabelCommand;
	import cc.sitemaker.application.events.ChangeLabelEvent;
	import cc.sitemaker.application.models.ApplicationModel;
	import cc.sitemaker.application.views.MainView;
	import cc.sitemaker.application.views.MainViewMediator;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	
	public class ApplicationConfig {
		
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
			injector.map(ApplicationModel).asSingleton();
		}		
		
		private function mapViews():void {
			mediatorMap.map(MainView).toMediator(MainViewMediator);
		}		
		
		private function mapCommands():void {
			commandMap.map(ChangeLabelEvent.CHANGE_LABEL_REQUEST).toCommand(ChangeLabelCommand);
		}		
		
		private function afterInitializing():void {
			
		}
		
	}
}