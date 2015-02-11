/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.gui.topPanel
{
	import com.reversy.controller.GameController;
	import com.reversy.gui.*;
	import com.reversy.main.MainApp;
	import com.reversy.utils.Assets;
	import com.reversy.utils.LocaleUtil;

	import starling.display.Image;
	import starling.display.Sprite;

	public class TopPanel extends Sprite implements IView
	{
		private static const PLAYER_CHIP_CONTAINER_TITLE:String = "mainScreen.topPanel.playerChipsColorTF";
		private static const TURN_CHIP_CONTAINER_TITLE:String = "mainScreen.topPanel.currentPlayerTurnTF";

		private var _controller:GameController;

		private var _background:Image;
		private var _scorePanel:ScorePanel;
		private var _playerChipContainer:ChipContainer;
		private var _turnChipContainer:ChipContainer;

		public function TopPanel(controller:GameController)
		{
			super();

			_controller = controller;

			init();
		}

		//region public methods
		public function init():void
		{
			if (_background == null)
			{
				_background = new Image(Assets.getTexture(Assets.TOP_PANEL_BG_TEXTURE_NAME, Assets.ATLAS_TEXTURES_NAME));
			}

			if (_scorePanel == null)
			{
				_scorePanel = new ScorePanel();
			}

			if (_playerChipContainer == null)
			{
				_playerChipContainer = new ChipContainer();
				_playerChipContainer.leftAlign = true;
			}

			if (_turnChipContainer == null)
			{
				_turnChipContainer = new ChipContainer();
				_turnChipContainer.leftAlign = false;
			}

			resize();

			addChild(_background);
			addChild(_playerChipContainer);
			addChild(_turnChipContainer);
			addChild(_scorePanel);

			update();

			updateLanguage();
		}

		public function resize():void
		{
			_background.width = MainApp.stageWidth;

			_scorePanel.x = (MainApp.stageWidth - _scorePanel.width) / 2;

			var gap:int = (_background.height - _playerChipContainer.height) >> 1;

			_playerChipContainer.x = gap;
			_playerChipContainer.y = gap;

			_turnChipContainer.x = MainApp.stageWidth - (_turnChipContainer.width + gap);
			_turnChipContainer.y = gap;
		}

		public function update():void
		{
			_playerChipContainer.visible = _turnChipContainer.visible = _controller.gameStarted;

			_playerChipContainer.iconIsWhite = _controller.playerIsWhite;
			_turnChipContainer.iconIsWhite = _controller.whitesTurn;

			if (_controller.playerIsWhite)
			{
				_scorePanel.updateScore(_controller.score.scoreWhite, _controller.score.scoreBlack);
			}
			else
			{
				_scorePanel.updateScore(_controller.score.scoreBlack, _controller.score.scoreWhite);
			}
		}

		public function updateLanguage():void
		{
			_playerChipContainer.text = LocaleUtil.getPhrase(PLAYER_CHIP_CONTAINER_TITLE);
			_turnChipContainer.text = LocaleUtil.getPhrase(TURN_CHIP_CONTAINER_TITLE);
		}

		public function updateColor():void
		{

		}
		//endregion
	}
}
