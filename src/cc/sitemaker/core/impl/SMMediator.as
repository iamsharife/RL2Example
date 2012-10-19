package cc.sitemaker.core.impl
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;
	
	public class SMMediator extends Mediator {
		
		private var _context:IContext;
		
		private var _logger:ILogger;
		
		private var _globalDispatcher:IEventDispatcher;
		
		private var _moduleDispatcher:IEventDispatcher;
		
		[Inject(name="CommunicationChannels")]
		private var _communicationChannels:Dictionary;
		
		public function SMMediator() {
			super();
		}

		[Inject]
		public function set context(value:IContext):void {
			if (value != null) {
				_context = value;
				_logger = _context.getLogger(this);
				_communicationChannels = value.injector.getInstance(Dictionary, "CommunicationChannels")
				_globalDispatcher = _communicationChannels["global"];
				_moduleDispatcher =  _communicationChannels["moduleOnly"];
			}
		}
		
		public function get logger():ILogger {
			return _logger;
		}
		
		protected function addComponentListener(component:IEventDispatcher, eventString:String, listener:Function, eventClass:Class = null):void {
			eventMap.mapListener(component, eventString, listener, eventClass);
		}
		
		protected function removeComponentListener(component:IEventDispatcher, eventString:String, listener:Function, eventClass:Class = null):void {
			eventMap.unmapListener(component, eventString, listener, eventClass);
		}
		
		protected function addGlobalListener(eventString:String, listener:Function, eventClass:Class = null):void {
			eventMap.mapListener(_globalDispatcher, eventString, listener, eventClass);
		}
		
		protected function removeGlobalListener(eventString:String, listener:Function, eventClass:Class = null):void {
			eventMap.unmapListener(_globalDispatcher, eventString, listener, eventClass);
		}
		
		protected function dispatchGlobalEvent(event:Event):void {
			if (_globalDispatcher.hasEventListener(event.type))
				_globalDispatcher.dispatchEvent(event);
		}
		
		protected function addModuleOnlyListener(eventString:String, listener:Function, eventClass:Class = null):void {
			eventMap.mapListener(_moduleDispatcher, eventString, listener, eventClass);
		}
		
		protected function removeModuleOnlyListener(eventString:String, listener:Function, eventClass:Class = null):void {
			eventMap.unmapListener(_moduleDispatcher, eventString, listener, eventClass);
		}
		
		protected function dispatchModuleEvent(event:Event):void {
			if (_moduleDispatcher.hasEventListener(event.type))
				_moduleDispatcher.dispatchEvent(event);
		}
	}
}