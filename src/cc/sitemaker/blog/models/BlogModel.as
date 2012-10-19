package cc.sitemaker.blog.models
{
	import cc.sitemaker.application.events.ChangeLabelEvent;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;

	public class BlogModel {
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		private var _labelValue:String;
		
		private var _logger:ILogger;
		
		public function BlogModel() {
			
		}
		
		[PostConstruct]
		public function init():void {
			_logger = context.getLogger(this); 
			
			_logger.debug("init");
		}

		public function get labelValue():String {
			return _labelValue;
		}

		public function set labelValue(value:String):void {
			
			if (_labelValue != value) { 
				_labelValue = value;
				_logger.debug("set labelValue");
				dispatcher.dispatchEvent(new ChangeLabelEvent(ChangeLabelEvent.CHANGE_LABEL_HAPPENED));
			}
		}

	}
}