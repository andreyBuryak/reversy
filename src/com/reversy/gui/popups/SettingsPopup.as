/**
 * Created by a.buryak on 11.02.15.
 */
package com.reversy.gui.popups
{
	import com.reversy.controller.GameController;
	import com.reversy.utils.Assets;
	import com.reversy.utils.LocaleUtil;

	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;

	public class SettingsPopup extends APopup
	{
		private static const CAPTION_LOC:String = "popups.settingsPopup.caption";

		private var _flagEN:Image;
		private var _flagUA:Image;
		private var _flagRU:Image;

		private var _language:String;

		public function SettingsPopup(controller:GameController)
		{
			super(controller);
		}

		override public function init():void
		{
			super.init();

			_flagEN = new Image(Assets.getTexture(Assets.POPUP_FLAG_EN_TEXTURE_NAME, Assets.ATLAS_POPUPS_NAME));
			_flagUA = new Image(Assets.getTexture(Assets.POPUP_FLAG_UA_TEXTURE_NAME, Assets.ATLAS_POPUPS_NAME));
			_flagRU = new Image(Assets.getTexture(Assets.POPUP_FLAG_RU_TEXTURE_NAME, Assets.ATLAS_POPUPS_NAME));

			_flagEN.y = _flagUA.y = _flagRU.y = _background.height * 0.25;
			_flagEN.x = _background.width * 0.25;
			_flagUA.x = (_background.width - _flagUA.width) >> 1;
			_flagRU.x = _background.width * 0.75 - _flagRU.width;

			_flagEN.name = LocaleUtil.LANGUAGE_EN;
			_flagUA.name = LocaleUtil.LANGUAGE_UA;
			_flagRU.name = LocaleUtil.LANGUAGE_RU;

			addChild(_flagEN);
			addChild(_flagUA);
			addChild(_flagRU);

			updateFlags(LocaleUtil.instance.language);
		}

		override public function updateLanguage():void
		{
			_captionTF.text = LocaleUtil.getPhrase(CAPTION_LOC);

			super.updateLanguage();
		}

		override public function activate():void
		{
			_flagEN.addEventListener(TouchEvent.TOUCH, flagTouchHandler);
			_flagUA.addEventListener(TouchEvent.TOUCH, flagTouchHandler);
			_flagRU.addEventListener(TouchEvent.TOUCH, flagTouchHandler);

			super.activate();
		}

		override public function deactivate():void
		{
			_flagEN.removeEventListener(TouchEvent.TOUCH, flagTouchHandler);
			_flagUA.removeEventListener(TouchEvent.TOUCH, flagTouchHandler);
			_flagRU.removeEventListener(TouchEvent.TOUCH, flagTouchHandler);

			super.deactivate();
		}

		override protected function submitButtonHandler(event:Event):void
		{
			if (_language != LocaleUtil.instance.language)
			{
				LocaleUtil.setLanguage(_language);
			}

			hide();
		}

		private function updateFlags(language:String):void
		{
			_flagEN.filter = null;
			_flagUA.filter = null;
			_flagRU.filter = null;

			var activeFlag:Image;

			switch (language)
			{
				case (LocaleUtil.LANGUAGE_EN): activeFlag = _flagEN; break;
				case (LocaleUtil.LANGUAGE_UA): activeFlag = _flagUA; break;
				case (LocaleUtil.LANGUAGE_RU): activeFlag = _flagRU; break;
			}

			if (activeFlag != null)
			{
				activeFlag.filter = BlurFilter.createGlow();
				_language = language;
			}
			else
			{
				_language = LocaleUtil.instance.language;
			}
		}

		private function flagTouchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.touches[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				updateFlags(touch.target.name);
			}
		}
	}
}
