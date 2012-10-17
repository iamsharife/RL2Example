package cc.sitemaker.application.views
{
	import cc.sitemaker.application.events.ChangeLabelEvent;
	import cc.sitemaker.application.models.ApplicationModel;
	
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class ShopViewMediator extends Mediator {
		
		[Inject]
		public var view:MainView;

		[Inject]
		public var model:ApplicationModel;
		
		public function ShopViewMediator() {
			super();
		}
		
		override public function initialize():void {
			super.initialize();
			
			view.lblSomeText.text = "MainView Mediator Initialize";
			
			addContextListener(ChangeLabelEvent.CHANGE_LABEL_HAPPENED, onChangeLabelHappened);
			eventMap.mapListener(view.btnChangeLabel, MouseEvent.CLICK, onChangeLabelClick);
		}
		
		private function onChangeLabelClick(e:MouseEvent):void {
			dispatch(new ChangeLabelEvent(ChangeLabelEvent.CHANGE_LABEL_REQUEST));			
		}
		
		private function onChangeLabelHappened(e:ChangeLabelEvent):void {
			view.lblSomeText.text = model.labelValue;
		}
		
		override public function destroy():void {
			super.destroy();	
		}
	}
}