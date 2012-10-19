package cc.sitemaker.application.config {
	import cc.sitemaker.application.commands.ChangeLabelCommand;
	import cc.sitemaker.application.events.ChangeLabelEvent;
	import cc.sitemaker.application.models.ApplicationModel;
	import cc.sitemaker.application.views.MainView;
	import cc.sitemaker.application.views.MainViewMediator;
	import cc.sitemaker.core.api.IConfigDefault;
	import cc.sitemaker.core.impl.Configurator;
	import cc.sitemaker.core.impl.ModuleCommandMap;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.scopedEventDispatcher.ScopedEventDispatcherExtension;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	public class ApplicationConfig extends Configurator implements IConfigDefault {
		
		private var _context:IContext;
		
		private var _contextView:DisplayObjectContainer;
		
		public function ApplicationConfig( contextView:DisplayObjectContainer ){
			super(contextView);
			_contextView = contextView;
			startConfiguration();
		}
		
		public function startConfiguration():void {
			_context = new Context()
				.extend( MVCSBundle )
				.extend( new ScopedEventDispatcherExtension("global","moduleOnly") )
				.extend( this )
				.configure( _contextView );
			
			logger.debug("startConfiguration");
		}	
		
		public function setupLifecycleListeners():void {
			logger.debug("setupLifecycleListeners");
			context.lifecycle.afterInitializing( afterInitializing );
		}
		
		public function afterInitializing():void {
			logger.debug("afterInitializing");
			
			var communicationChannels:Dictionary = new Dictionary();
			communicationChannels[ "global" ] = injector.getInstance( IEventDispatcher, "global" );
			communicationChannels[ "moduleOnly" ] = injector.getInstance( IEventDispatcher, "moduleOnly" );
			
			injector.map( Dictionary, "CommunicationChannels" ).toValue( communicationChannels );
			
			var mcm:ModuleCommandMap = new ModuleCommandMap();
			injector.injectInto(mcm);
			injector.map(IEventCommandMap, "moduleCommandMap").toValue( mcm );
			logger.debug("mcm " + mcm.toString());
		}
		
		public function setupInjections():void {
			logger.debug("setupInjections");
		}
					
		public function mapModels():IConfigDefault {
			logger.debug("mapModels");
			injector.map(ApplicationModel).asSingleton();			
			return this;
		}		
		
		public function mapViews():IConfigDefault {
			logger.debug("mapViews");
			mediatorMap.map(MainView).toMediator(MainViewMediator);
			return this;
		}		
		
		public function mapCommands():IConfigDefault {
			logger.debug("mapCommands");
			commandMap.map(ChangeLabelEvent.CHANGE_LABEL_REQUEST).toCommand(ChangeLabelCommand);
			return this;
		}	
		
	}
}