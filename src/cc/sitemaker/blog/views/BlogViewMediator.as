package cc.sitemaker.blog.views
{
	import cc.sitemaker.application.events.ChangeLabelEvent;
	import cc.sitemaker.application.models.ApplicationModel;
	import cc.sitemaker.blog.models.BlogModel;
	import cc.sitemaker.core.impl.SMMediator;
	
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;
	
	public class BlogViewMediator extends SMMediator {
		
		[Inject]
		public var view:BlogView;

		[Inject]
		public var model:BlogModel;
		
		[Inject(name="global")]
		public var globalDispatcher:IEventDispatcher;
		
		public function BlogViewMediator() {
			super();
		}
		
		override public function initialize():void {
			super.initialize();
			
			logger.debug("initialise");
			
			view.lblSomeText.text = "BlogView Mediator Initialize";
			
			addContextListener(ChangeLabelEvent.CHANGE_LABEL_HAPPENED, onChangeLabelHappened);
			addComponentListener(view.btnChangeLabel, MouseEvent.CLICK, onChangeLabelClick);
		}
		
		override public function destroy():void {
			super.destroy();	
		}
		
		private function onChangeLabelClick(e:MouseEvent):void {
			dispatch(new ChangeLabelEvent(ChangeLabelEvent.CHANGE_LABEL_REQUEST));			
			dispatchGlobalEvent(new ChangeLabelEvent(ChangeLabelEvent.CHANGE_LABEL_REQUEST));
		}
		
		private function onChangeLabelHappened(e:ChangeLabelEvent):void {
			view.lblSomeText.text = model.labelValue;
			logger.debug("onChangeLabelHappened");
		}
	}
}