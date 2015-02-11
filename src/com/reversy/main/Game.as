/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.main
{
	import com.reversy.controller.GameController;
	import com.reversy.game.BotAI;
	import com.reversy.game.GameEngine;
	import com.reversy.gui.BottomPanel;
	import com.reversy.gui.gameField.GameField;
	import com.reversy.gui.topPanel.TopPanel;
	import com.reversy.utils.LocaleUtil;

	import starling.display.Sprite;

	public class Game extends starling.display.Sprite
	{
		private var _field:GameField;
		private var _topPanel:TopPanel;
		private var _bottomPanel:BottomPanel;

		private static var _instance:Game;

		public function Game()
		{
			super();

			if (_instance != null)
			{
				throw new Error("[ERROR] Game | Singleton")
			}

			_instance = this;
		}

		public function init():void
		{
			var engine:GameEngine = new GameEngine();
			var controller:GameController = new GameController(engine);
			engine.addObserver(controller);

			var bot:BotAI = new BotAI(controller);
			controller.addObserver(bot);

			_field = new GameField(controller);
			controller.addObserver(_field);
			addChild(_field);

			_topPanel = new TopPanel(controller);
			controller.addObserver(_topPanel);
			LocaleUtil.instance.addObserver(_topPanel);
			addChild(_topPanel);

			_bottomPanel = new BottomPanel(controller);
			controller.addObserver(_bottomPanel);
			LocaleUtil.instance.addObserver(_bottomPanel);
			addChild(_bottomPanel);

			resize();
		}

		public function resize():void
		{
			_bottomPanel.resize();

			_topPanel.resize();

			_field.resize();
			_field.x = (MainApp.stageWidth - _field.width) / 2;
			_field.y = _topPanel.height + ((_bottomPanel.y - _topPanel.height) - _field.height) / 2;

		}
	}
}
