package cc.sitemaker.application.views
{
	import cc.sitemaker.application.events.ChangeLabelEvent;
	import cc.sitemaker.application.models.ApplicationModel;
	import cc.sitemaker.core.impl.SMMediator;
	
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;
	
	public class MainViewMediator extends SMMediator {
				
		[Inject]
		public var view:MainView;

		[Inject]
		public var model:ApplicationModel;
		
		public function MainViewMediator() {
			super();
		}
		
		override public function initialize():void {
			super.initialize(); 
			
			logger.debug("initialise");
			
			addGlobalListener(ChangeLabelEvent.CHANGE_LABEL_REQUEST, function():void {
				Alert.show("I heard about the change!");
				dispatchModuleEvent(new ChangeLabelEvent(ChangeLabelEvent.CHANGE_FROM_ANOTHER_MODULE));
			});
			
			view.lblSomeText.text = "MainView Mediator Initialize";
			
			addContextListener(ChangeLabelEvent.CHANGE_LABEL_HAPPENED, onChangeLabelHappened);
			addComponentListener(view.btnChangeLabel, MouseEvent.CLICK, onChangeLabelClick);
		}
		
		private function onChangeLabelClick(e:MouseEvent):void {
			dispatch(new ChangeLabelEvent(ChangeLabelEvent.CHANGE_LABEL_REQUEST));			
		}
		
		private function onChangeLabelHappened(e:ChangeLabelEvent):void {
			view.lblSomeText.text = model.labelValue;
			logger.debug("onChangeLabelHappened");
		}
		
		override public function destroy():void {
			super.destroy();	
		}
	}
}