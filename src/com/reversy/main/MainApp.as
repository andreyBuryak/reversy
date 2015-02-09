/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.main
{
	import com.reversy.utils.LocaleUtil;

	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(height="760", width="650", frameRate="60")]
	[Frame(factoryClass='com.reversy.main.Preloader')]
	public class MainApp extends Sprite
	{
		private static var _stageWidth:Number;
		private static var _stageHeight:Number;

		private var _game:Game;

		public function MainApp()
		{
			super();

			LocaleUtil.setLanguage(LocaleUtil.LANGUAGE_EN);

			_game = new Game();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public static function get stageWidth():Number {return _stageWidth;}

		public static function get stageHeight():Number {return _stageHeight;}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(Event.RESIZE, onResize);

			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;

			_game.init();

			addChild(_game);

			Preloader.dispose();
		}

		private function onResize(event:Event):void
		{
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;

			_game.resize();
		}
	}
}
