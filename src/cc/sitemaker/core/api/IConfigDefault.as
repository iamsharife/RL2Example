package cc.sitemaker.core.api {
	
	public interface IConfigDefault {
		
		function mapModels():IConfigDefault;
		function mapViews():IConfigDefault;
		function mapCommands():IConfigDefault;
		function setupLifecycleListeners():void;
		function setupInjections():void;
		
	}
}