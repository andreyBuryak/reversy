/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.gui.topPanel
{
	import com.reversy.gui.*;
	import com.reversy.main.MainApp;
	import com.reversy.utils.LocaleUtil;
	import com.reversy.utils.StringUtil;

	import flash.display.Sprite;

	public class TopPanel extends Sprite implements IView
	{
		private static const PLAYER_CHIP_CONTAINER_TITLE:String = "mainScreen.topPanel.playerChipsColorTF";
		private static const TURN_CHIP_CONTAINER_TITLE:String = "mainScreen.topPanel.currentPlayerTurnTF";

		private var _background:Sprite;
		private var _scorePanelBg:Sprite;
		private var _playerChipContainer:ChipContainer;
		private var _turnChipContainer:ChipContainer;

		public function TopPanel()
		{
			super();

			init();
		}

		//region public methods
		public function init():void
		{
			if (_background == null)
			{
				_background = new TopPanelBgMc();
			}

			if (_scorePanelBg == null)
			{
				_scorePanelBg = new ScorePanelBgMc();
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
			addChild(_scorePanelBg);
			addChild(_playerChipContainer);
			addChild(_turnChipContainer);

			update();

			updateLanguage();
		}

		public function resize():void
		{
			_background.width = MainApp.stageWidth;

			_scorePanelBg.x = (MainApp.stageWidth - _scorePanelBg.width) / 2;

			var gap:int = (_background.height - _playerChipContainer.height) >> 1;

			_playerChipContainer.x = gap;
			_playerChipContainer.y = gap;

			_turnChipContainer.x = MainApp.stageWidth - (_turnChipContainer.width + gap);
			_turnChipContainer.y = gap;
		}

		public function update():void
		{
			var isPlayerWhite:Boolean = true;
			var isWhiteTurn:Boolean = false;

			_playerChipContainer.icon = isPlayerWhite ? new ChipWhiteMc() : new ChipBlackMc();
			_turnChipContainer.icon = isWhiteTurn ? new ChipWhiteMc() : new ChipBlackMc();

			updateScore(3, 5);
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

		//region private methods
		private function updateScore(scoreWhite:uint, scoreBlack:uint):void
		{
			var scoreString:String;
			scoreString = StringUtil.formatIntToStr(scoreWhite) + ":" + StringUtil.formatIntToStr(scoreBlack);
			//_view.scoreTF.text = scoreString;
		}


		//endregion
	}
}
