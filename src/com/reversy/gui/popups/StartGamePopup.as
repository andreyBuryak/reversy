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

	public class StartGamePopup extends APopup
	{
		private static const CAPTION_LOC:String = "popups.startGamePopup.caption";

		private var _whiteChip:Image;
		private var _blackChip:Image;
		private var _whiteChosen:Boolean = false;

		public function StartGamePopup(controller:GameController)
		{
			super(controller);
		}

		override public function init():void
		{
			super.init();

			_whiteChip = new Image(Assets.getTexture(Assets.POPUP_CHIP_WHITE_TEXTURE_NAME, Assets.ATLAS_POPUPS_NAME));
			_whiteChip.x = (_background.width >> 2) - (_whiteChip.width >> 1);
			_whiteChip.y = (_background.height - _whiteChip.height) / 2;
			addChild(_whiteChip);

			_blackChip = new Image(Assets.getTexture(Assets.POPUP_CHIP_BLACK_TEXTURE_NAME, Assets.ATLAS_POPUPS_NAME));
			_blackChip.x = _background.width - (_background.width >> 2) - (_whiteChip.width >> 1);
			_blackChip.y = _whiteChip.y;
			addChild(_blackChip);
		}

		override public function updateLanguage():void
		{
			_captionTF.text = LocaleUtil.getPhrase(CAPTION_LOC);

			super.updateLanguage();
		}

		override public function activate():void
		{
			_whiteChip.addEventListener(TouchEvent.TOUCH, onChipTouch);
			_blackChip.addEventListener(TouchEvent.TOUCH, onChipTouch);

			_submitButton.enabled = false;
		}

		override public function deactivate():void
		{
			_whiteChip.removeEventListener(TouchEvent.TOUCH, onChipTouch);
			_blackChip.removeEventListener(TouchEvent.TOUCH, onChipTouch);

			super.deactivate();
		}

		private function onChipTouch(event:TouchEvent):void
		{
			var touch:Touch = event.touches[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				if (touch.target == _whiteChip)
				{
					_whiteChip.filter = BlurFilter.createGlow();
					_blackChip.filter = null;
					_whiteChosen = true;
				}
				else if (touch.target == _blackChip)
				{
					_blackChip.filter = BlurFilter.createGlow();
					_whiteChip.filter = null;
					_whiteChosen = false;
				}

				_submitButton.enabled = true;
				super.activate();
			}
		}

		override protected function submitButtonHandler(event:Event):void
		{
			_controller.playerIsWhite = _whiteChosen;
			_controller.startGame();

			hide();
		}
	}
}
