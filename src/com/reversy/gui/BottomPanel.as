/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.gui
{
	import com.reversy.main.MainApp;
	import com.reversy.utils.LocaleUtil;
	import com.reversy.utils.SimpleButtonUtil;

	import flash.display.SimpleButton;

	import flash.display.Sprite;

	public class BottomPanel extends Sprite implements IView
	{
		private static const UNDO_BUTTON_LOC:String = "mainScreen.bottomPanel.undoButton";
		private static const PLAY_BUTTON_LOC:String = "mainScreen.bottomPanel.playButton";
		private static const REPLAY_BUTTON_LOC:String = "mainScreen.bottomPanel.replayButton";
		private static const SETTINGS_BUTTON_LOC:String = "mainScreen.bottomPanel.settingsButton";

		private var _background:Sprite;
		private var _buttonUndo:SimpleButton;
		private var _buttonSettings:SimpleButton;
		private var _buttonPlay:SimpleButton;
		private var _isGameStarted:Boolean = false;

		public function BottomPanel()
		{
			super();

			init();
		}

		//region public methods
		public function init():void
		{
			if (_background == null)
			{
				_background = new BottomPanelBgMc();
			}

			_buttonUndo = new ButtonMc();
			_buttonUndo.useHandCursor = false;
			_buttonSettings = new ButtonMc();
			_buttonSettings.useHandCursor = false;
			_buttonPlay = new PlayButtonMc();
			_buttonPlay.useHandCursor = false;

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

			_buttonSettings.x = _background.width - (_buttonSettings.width + gap);
			_buttonSettings.y = gap;

			_buttonPlay.x = (_background.width - _buttonPlay.width) >> 1;
			_buttonPlay.y = (_background.height - _buttonPlay.height) >> 1;
		}

		public function update():void
		{
		}

		public function updateLanguage():void
		{
			SimpleButtonUtil.setButtonCaption(_buttonUndo, LocaleUtil.getPhrase(UNDO_BUTTON_LOC));
			SimpleButtonUtil.setButtonCaption(_buttonSettings, LocaleUtil.getPhrase(SETTINGS_BUTTON_LOC));
			SimpleButtonUtil.setButtonCaption(
					_buttonPlay,
					LocaleUtil.getPhrase(_isGameStarted ? REPLAY_BUTTON_LOC : PLAY_BUTTON_LOC));
		}

		public function updateColor():void
		{

		}
		//endregion
	}
}
