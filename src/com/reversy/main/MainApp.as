/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.main
{
	import com.reversy.utils.Assets;
	import com.reversy.utils.LocaleUtil;

	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;

	[SWF(height="760", width="650", frameRate="60")]
	[Frame(factoryClass='com.reversy.main.Preloader')]
	public class MainApp extends Sprite
	{
		private static var _stageWidth:Number;
		private static var _stageHeight:Number;

		private var _starling:Starling;

		private var _game:Game;

		public function MainApp()
		{
			super();

			LocaleUtil.setLanguage(LocaleUtil.LANGUAGE_EN);

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public static function get stageWidth():Number {return _stageWidth;}

		public static function get stageHeight():Number {return _stageHeight;}

		private function onAddedToStage(event:Object):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(Event.RESIZE, onResize);

			initStarling();

			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
		}

		private function initStarling():void
		{
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;

			_starling = new Starling(Game, stage, null, null, "auto", "auto");
			_starling.simulateMultitouch = true;
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, loadAssets);
			_starling.start();
		}

		private function loadAssets(event:starling.events.Event = null):void
		{
			var assetManager:AssetManager = new AssetManager();
			assetManager.verbose = Capabilities.isDebugger;
			assetManager.enqueue(Assets);
			assetManager.loadQueue(loadingProgressHandler);

			function loadingProgressHandler(ratio:Number):void
			{
				if (ratio >= 1.0)
				{
					initGame();
				}
			}
		}

		private function initGame():void
		{
			_game = _starling.root as Game;
			_game.init();

			Preloader.dispose();
		}

		private function onResize(event:Object):void
		{
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;

			Starling.current.viewPort = new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
			_starling.stage.stageWidth = _stageWidth;
			_starling.stage.stageHeight = _stageHeight;

			_game.resize();
		}
	}
}
