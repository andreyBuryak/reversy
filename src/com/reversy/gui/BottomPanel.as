/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.gui
{
	import com.reversy.controller.GameController;
	import com.reversy.gui.popups.APopup;
	import com.reversy.gui.popups.EndGamePopup;
	import com.reversy.gui.popups.SettingsPopup;
	import com.reversy.gui.popups.StartGamePopup;
	import com.reversy.main.MainApp;
	import com.reversy.utils.Assets;
	import com.reversy.utils.LocaleUtil;
	import com.reversy.utils.GuiUtil;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class BottomPanel extends Sprite implements IView
	{
		private static const UNDO_BUTTON_LOC:String = "mainScreen.bottomPanel.undoButton";
		private static const PLAY_BUTTON_LOC:String = "mainScreen.bottomPanel.playButton";
		private static const REPLAY_BUTTON_LOC:String = "mainScreen.bottomPanel.replayButton";
		private static const SETTINGS_BUTTON_LOC:String = "mainScreen.bottomPanel.settingsButton";

		private var _controller:GameController;
		private var _popup:APopup;
		private var _isGameStarted:Boolean = false;

		private var _background:Image;
		private var _buttonUndo:Button;
		private var _buttonSettings:Button;
		private var _buttonPlay:Button;

		public function BottomPanel(controller:GameController)
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
				_background = new Image(Assets.getTexture(Assets.BOTTOM_PANEL_BG_TEXTURE_NAME, Assets.ATLAS_TEXTURES_NAME));
			}

			_buttonUndo = GuiUtil.createButton(Assets.BUTTON_BG_TEXTURE_NAME);

			_buttonSettings = GuiUtil.createButton(Assets.BUTTON_BG_TEXTURE_NAME);
			_buttonSettings.addEventListener(Event.TRIGGERED, settingsButtonHandler);
			_buttonPlay = GuiUtil.createButton(Assets.PLAY_BUTTON_BG_TEXTURE_NAME);
			_buttonPlay.addEventListener(Event.TRIGGERED, playButtonHandler);

			resize();

			addChild(_background);
			addChild(_buttonUndo);
			addChild(_buttonSettings);
			addChild(_buttonPlay);

			update();

			updateLanguage();
		}

		public function resize():void
		{
			this.y = MainApp.stageHeight - _background.height;

			_background.width = MainApp.stageWidth;

			var gap:int = (_background.height - _buttonUndo.height) >> 1;

			_buttonUndo.x = gap;
			_buttonUndo.y = gap;

			_buttonSettings.x = MainApp.stageWidth - (_buttonSettings.width + gap);
			_buttonSettings.y = gap;

			_buttonPlay.x = (MainApp.stageWidth - _buttonPlay.width) >> 1;
			_buttonPlay.y = gap;

			if (_popup != null)
			{
				_popup.resize();
			}
		}

		public function update():void
		{
			if (_isGameStarted == true && _controller.gameStarted == false)
			{
				showPopup(EndGamePopup);
			}

			_isGameStarted = _controller.gameStarted;

			updatePlayButtonCaption();

			if (_controller.isUndoAllowed)
			{
				_buttonUndo.enabled = true;
				_buttonUndo.addEventListener(Event.TRIGGERED, undoButtonHandler);
			}
			else
			{
				_buttonUndo.enabled = false;
				_buttonUndo.removeEventListener(Event.TRIGGERED, undoButtonHandler);
			}
		}

		public function updateLanguage():void
		{
			_buttonUndo.text = LocaleUtil.getPhrase(UNDO_BUTTON_LOC);
			_buttonSettings.text = LocaleUtil.getPhrase(SETTINGS_BUTTON_LOC);

			updatePlayButtonCaption();
		}

		public function updateColor():void
		{

		}
		//endregion

		//region private methods
		private function updatePlayButtonCaption():void
		{
			_buttonPlay.text = LocaleUtil.getPhrase(_isGameStarted ? REPLAY_BUTTON_LOC : PLAY_BUTTON_LOC);
		}

		private function undoButtonHandler(event:Event):void
		{
			_controller.undo();
		}

		private function settingsButtonHandler(event:Event):void
		{
			showPopup(SettingsPopup);
		}

		private function playButtonHandler(event:Event):void
		{
			if (_controller.gameStarted)
			{
				_controller.stopGame();
			}
			else
			{
				showPopup(StartGamePopup);
			}
		}

		private function showPopup(popupClass:Class):void
		{
			_popup = new popupClass(_controller);
			if (_popup != null)
			{
				stage.addChild(_popup);
				_popup.update();
				_popup.show();
			}
			else
			{
				throw new Error("[ERROR] BottomPanel | showPopup | Invalid popup class");
			}
		}
		//endregion
	}
}
