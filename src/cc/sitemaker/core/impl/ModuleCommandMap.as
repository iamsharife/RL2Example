package cc.sitemaker.core.impl
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandCenter;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.impl.EventCommandTrigger;
	import robotlegs.bender.framework.impl.UID;
	
	public class ModuleCommandMap implements IEventCommandMap {
		
		/*============================================================================*/
		/* Private Properties */
		/*============================================================================*/
		
		private const _triggers:Dictionary = new Dictionary();
		
		[Inject]
		public var injector:Injector;
		
		[Inject(name="moduleOnly")]
		public var dispatcher:IEventDispatcher;
		
		private var _commandCenter:ICommandCenter;
				
		private var _uid:String = UID.create(this);
		
		[PostConstruct]
		public function init():void {
			_commandCenter = new CommandCenter();
		}
		
		public function map(type:String, eventClass:Class=null):ICommandMapper
		{
			const trigger:ICommandTrigger =
				_triggers[type + eventClass] ||=
				createTrigger(type, eventClass);
			return _commandCenter.map(trigger);
		}
		
		public function unmap(type:String, eventClass:Class=null):ICommandUnmapper
		{
			return _commandCenter.unmap(getTrigger(type, eventClass));
		}
		
		/*============================================================================*/
		/* Private Functions */
		/*============================================================================*/
		
		private function createTrigger(type:String, eventClass:Class = null):ICommandTrigger
		{
			return new EventCommandTrigger(injector, dispatcher, type, eventClass);
		}
		
		private function getTrigger(type:String, eventClass:Class = null):ICommandTrigger
		{
			return _triggers[type + eventClass];
		}
		
		public function toString():String {
			return "ModuleCommandMap Instance[" + _uid + "]";
		}
		
	}
}