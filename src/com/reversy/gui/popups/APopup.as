/**
 * Created by a.buryak on 11.02.15.
 */
package com.reversy.gui.popups
{
	import com.reversy.controller.GameController;
	import com.reversy.main.MainApp;
	import com.reversy.utils.Assets;
	import com.reversy.utils.GuiUtil;
	import com.reversy.utils.LocaleUtil;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class APopup extends Sprite implements IPopup
	{
		protected static const SHOW_DURATION:Number = 0.4;
		protected static const HIDE_DURATION:Number = 0.3;

		protected static const SUBMIT_BTN_LOC:String = "popups.submitButton";

		protected static var _instance:APopup;

		protected var _background:Image;
		protected var _captionTF:TextField;
		protected var _submitButton:Button;
		protected var _controller:GameController;

		public function APopup(controller:GameController)
		{
			super();

			_controller = controller;
			_controller.addObserver(this);
			LocaleUtil.instance.addObserver(this);

			init();
		}

		public function update():void
		{
			updateColor();
			updateLanguage();
		}

		public function show():void
		{
			if (_instance != null)
			{
				dispose();
			}
			else
			{
				resize();
				alpha = 0;
				Starling.juggler.tween(this, SHOW_DURATION, {alpha:1, onComplete:activate});
			}
		}

		public function hide():void
		{
			deactivate();
			Starling.juggler.tween(this, HIDE_DURATION, {alpha:0, onComplete:dispose});
		}

		public function init():void
		{
			_background = new Image(Assets.getTexture(Assets.POPUP_BACKGROUND_TEXTURE_NAME, Assets.ATLAS_POPUPS_NAME));
			addChild(_background);

			_captionTF = GuiUtil.createTextField(GuiUtil.TF_POPUP_CAPTION_STYLE);
			_captionTF.width = _background.width;
			_captionTF.hAlign = HAlign.CENTER;
			addChild(_captionTF);

			_submitButton = GuiUtil.createButton(Assets.PLAY_BUTTON_BG_TEXTURE_NAME);
			_submitButton.x = (_background.width - _submitButton.width) >> 1;
			_submitButton.y = _background.height - _submitButton.height - 15;
			addChild(_submitButton);
		}

		public function resize():void
		{
			this.x = (MainApp.stageWidth - _background.width) / 2;
			this.y = (MainApp.stageHeight - _background.height) / 2;
		}

		public function activate():void
		{
			_submitButton.addEventListener(Event.TRIGGERED, submitButtonHandler);
		}

		public function deactivate():void
		{
			_submitButton.removeEventListener(Event.TRIGGERED, submitButtonHandler);
		}

		public function updateLanguage():void
		{
			_submitButton.text = LocaleUtil.getPhrase(SUBMIT_BTN_LOC);
		}

		public function updateColor():void
		{

		}

		override public function dispose():void
		{
			if (_instance == this)
			{
				_instance = null;
			}

			deactivate();

			_controller.removeObserver(this);
			LocaleUtil.instance.removeObserver(this);

			removeFromParent(false);
			super.dispose();
		}

		protected function submitButtonHandler(event:Event):void
		{
			hide();
		}
	}
}
