package cc.sitemaker.blog.models
{
	import cc.sitemaker.application.events.ChangeLabelEvent;
	
	import flash.events.IEventDispatcher;

	public class BlogModel {
		
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		private var _labelValue:String;
		
		public function BlogModel() {
			
		}

		public function get labelValue():String {
			return _labelValue;
		}

		public function set labelValue(value:String):void {
			
			if (_labelValue != value) { 
				_labelValue = value;
				dispatcher.dispatchEvent(new ChangeLabelEvent(ChangeLabelEvent.CHANGE_LABEL_HAPPENED));
			}
		}

	}
}