package cc.sitemaker.application.events {
	
	import flash.events.Event;
	
	public class ChangeLabelEvent extends Event {
	
		public static const CHANGE_LABEL_REQUEST:String = "changeLabelRequest";
		public static const CHANGE_LABEL_HAPPENED:String = "changeLabelHappened";
		
		public function ChangeLabelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}