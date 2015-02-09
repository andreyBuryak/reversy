/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.main
{
	import com.reversy.controller.GameController;
	import com.reversy.game.GameEngine;
	import com.reversy.gui.BottomPanel;
	import com.reversy.gui.GameField;
	import com.reversy.gui.topPanel.TopPanel;
	import com.reversy.utils.LocaleUtil;

	import flash.display.BitmapData;

	import flash.display.Sprite;

	public class Game extends Sprite
	{
		private var _field:GameField;
		private var _topPanel:TopPanel;
		private var _bottomPanel:BottomPanel;
		private var _background:Sprite;

		public function Game()
		{
			super();
		}

		//region public methods
		public function init():void
		{
			GameEngine.instance.addObserver(GameController.instance);

			_field = new GameField();
			GameController.instance.addObserver(_field);
			addChild(_field);

			_topPanel = new TopPanel();
			GameController.instance.addObserver(_topPanel);
			LocaleUtil.instance.addObserver(_topPanel);
			addChild(_topPanel);

			_bottomPanel = new BottomPanel();
			GameController.instance.addObserver(_bottomPanel);
			LocaleUtil.instance.addObserver(_bottomPanel);
			addChild(_bottomPanel);

			resize();
		}

		public function resize():void
		{
			updateBackground();
			_bottomPanel.resize();
			_topPanel.resize();
		}
		//endregion

		//region private methods
		private function updateBackground():void
		{
			if (_background == null)
			{
				_background = new Sprite();
			}

			var template:Sprite = new GameBackgroundMc();
			var bitmap:BitmapData = new BitmapData(template.width, template.height, true, 0x000000);
			bitmap.draw(template);

			_background.graphics.clear();
			_background.graphics.beginBitmapFill(bitmap, null, true, true);
			_background.graphics.drawRect(0, 0, MainApp.stageWidth, MainApp.stageHeight);
			_background.graphics.endFill();

			addChildAt(_background, 0);
		}
		//endregion
	}
}
