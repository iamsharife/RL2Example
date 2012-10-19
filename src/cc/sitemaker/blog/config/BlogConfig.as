package cc.sitemaker.blog.config {
	
	import cc.sitemaker.application.events.ChangeLabelEvent;
	import cc.sitemaker.blog.commands.BlogChangeLabelCommand;
	import cc.sitemaker.blog.commands.ChangeFromAnotherModuleCommand;
	import cc.sitemaker.blog.models.BlogModel;
	import cc.sitemaker.blog.views.BlogView;
	import cc.sitemaker.blog.views.BlogViewMediator;
	import cc.sitemaker.core.api.IConfigDefault;
	import cc.sitemaker.core.impl.Configurator;
	import cc.sitemaker.core.impl.ModuleCommandMap;
	
	import flash.display.DisplayObjectContainer;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediator;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.modularity.ModularityExtension;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.bender.framework.impl.Context;
	
	public class BlogConfig extends Configurator implements IConfigDefault {
				
		private var _context:IContext;
		
		private var _contextView:DisplayObjectContainer;
		
		private var _moduleCommandMap:IEventCommandMap;
		
		public function BlogConfig( contextView:DisplayObjectContainer ){
			super(contextView);
			_contextView = contextView;
			startConfiguration();
		}
		
		public function startConfiguration():void {
			_context = new Context()
				.extend( MVCSBundle )
				.extend( this )
				.configure( _contextView );
			
			logger.debug("startConfiguration");
		}
		
		public function setupLifecycleListeners():void {
			logger.debug("setupLifecycleListeners");
			context.lifecycle.afterInitializing( afterInitializing );
		}	
		
		private function afterInitializing():void {
			logger.debug("afterInitializing");
			_moduleCommandMap = injector.parentInjector.getInstance(IEventCommandMap, "moduleCommandMap");
		}
		
		public function setupInjections():void {
			logger.debug("setupInjections");
		}
		
		public function mapModels():IConfigDefault {		
			logger.debug("mapModels");
			injector.map(BlogModel).asSingleton();
			return this;
		}		
		
		public function mapViews():IConfigDefault {	
			logger.debug("mapViews");
			mediatorMap.map(BlogView).toMediator(BlogViewMediator);
			return this;
		}		
		
		public function mapCommands():IConfigDefault {
			logger.debug("mapCommands");
			logger.debug("_moduleCommandMap " + (_moduleCommandMap as ModuleCommandMap).toString());
			commandMap.map(ChangeLabelEvent.CHANGE_LABEL_REQUEST).toCommand(BlogChangeLabelCommand);
			_moduleCommandMap.map(ChangeLabelEvent.CHANGE_FROM_ANOTHER_MODULE).toCommand(ChangeFromAnotherModuleCommand);
			return this;
		}	
		
	}
}