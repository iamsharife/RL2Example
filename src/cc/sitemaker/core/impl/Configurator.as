package cc.sitemaker.core.impl
{
	import cc.sitemaker.core.api.IConfigDefault;
	
	import flash.display.DisplayObjectContainer;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.api.LogLevel;

	/*
	* Should only be treated as an abstract class
	*/ 
	
	public class Configurator implements IExtension {
		
		private var _mediatorMap:IMediatorMap;
		
		private var _commandMap:IEventCommandMap;
		
		private var _context:IContext;
		
		private var _injector:Injector;
		
		private var _contextView:DisplayObjectContainer;
		
		private var _logger:ILogger;
		
		private var _config:IConfigDefault;
				
		public function Configurator(contextView:DisplayObjectContainer) {
			_contextView = contextView;		
			_config = this as IConfigDefault;
		}

		public function get mediatorMap():IMediatorMap {
			return _mediatorMap;
		}
		
		public function get commandMap():IEventCommandMap {
			return _commandMap;
		}
		
		public function get context():IContext {
			return _context;
		}
		
		public function get injector():Injector {
			return _injector;
		}
		
		public function get contextView():DisplayObjectContainer {
			return _contextView;
		}
		
		public function get logger():ILogger {
			return _logger;
		}
		
		public function extend(context:IContext):void {
			if (context.lifecycle.initialized)
				throw new Error("This extension must be installed prior to context initialization");
			
			_context = context;
			
			_context.logLevel = LogLevel.DEBUG;
			_logger = _context.getLogger(_config);
			_logger.debug("super::extend");
			
			setupLifecycleListeners();
			
			_injector = _context.injector;
			
			setupInjections();
			
			_mediatorMap = _injector.getInstance( IMediatorMap  );
			_commandMap = _injector.getInstance( IEventCommandMap );			
		}
		
		private function setupLifecycleListeners():void {
			_logger.debug("super::setupLifecycleListeners");
			_config.setupLifecycleListeners();
			context.lifecycle.afterInitializing( afterInitializing );
		}
		
		private function afterInitializing():void {
			_logger.debug("super::afterInitializing");
			configureMaps();
		}
		
		private function setupInjections():void {
			_logger.debug("super::setupInjections");
			_config.setupInjections();
		}
		
		private function configureMaps():void {
			_logger.debug("super::configureMaps");
			// TODO Auto Generated method stub
			_config.mapCommands()
				.mapModels()
				.mapViews();
		}
		
	}
}
