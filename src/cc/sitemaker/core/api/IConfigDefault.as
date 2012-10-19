package cc.sitemaker.core.api {
	
	public interface IConfigDefault {
		
		/*
		 * all model mappings
		*/
		function mapModels():IConfigDefault;
		/*
		* all view/mediator mappings
		*/
		function mapViews():IConfigDefault;
		/*
		* all command mappings
		*/
		function mapCommands():IConfigDefault;
		/*
		* add lifecycle listeners in this method
		*/
		function setupLifecycleListeners():void;
		/*
		* setup injections that havent yet been instantiated,
		* if an instance is already created and you would like to retrieve it,
		* make sure you do this on the afterInitialising lifecycle callback
		*/
		function setupInjections():void;
		
	}
}