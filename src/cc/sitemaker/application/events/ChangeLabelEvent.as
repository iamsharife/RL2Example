package cc.sitemaker.application.events {
	
	import flash.events.Event;
	
	public class ChangeLabelEvent extends Event {
	
		public static const CHANGE_LABEL_REQUEST:String = "changeLabelRequest";
		public static const CHANGE_LABEL_HAPPENED:String = "changeLabelHappened";
		public static var CHANGE_FROM_ANOTHER_MODULE:String = "changeFromAnotherModule";
		
		public function ChangeLabelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}