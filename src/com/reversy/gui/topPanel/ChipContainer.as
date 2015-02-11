/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.gui.topPanel
{
	import com.reversy.gui.gameField.GameChip;
	import com.reversy.utils.Assets;
	import com.reversy.utils.GuiUtil;

	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class ChipContainer extends Sprite
	{
		private var _view:Image;
		private var _textField:TextField
		private var _icon:GameChip;
		private var _leftAlign:Boolean = true;

		public function ChipContainer()
		{
			super();

			_view = new Image(Assets.getTexture(Assets.CHIP_PLACEHOLDER_TEXTURE_NAME, Assets.ATLAS_TEXTURES_NAME));

			_textField = GuiUtil.createTextField(GuiUtil.TF_TOP_PANEL_STYLE);
			_textField.height = _view.height;
			_textField.touchable = false;
			_textField.vAlign = VAlign.CENTER;
			_textField.autoSize = TextFieldAutoSize.LEFT;
			updateTextFieldAlign();

			_icon = new GameChip(false);
			_icon.x = _view.x + (_view.width >> 1);
			_icon.y = _view.y + (_view.height >> 1);

			addChild(_icon);
			addChild(_view);
			addChild(_textField);
		}

		override public function get width():Number {return _view.width;}

		override public function get height():Number {return _view.height;}

		public function set text(value:String):void
		{
			if (value == null)
			{
				value = "";
			}

			_textField.text = value;

			updateTextFieldAlign();
		}

		public function set iconIsWhite(value:Boolean):void
		{
			_icon.isWhite = value;
		}

		public function set leftAlign(value:Boolean):void
		{
			_leftAlign = value;

			updateTextFieldAlign();
		}

		private function updateTextFieldAlign():void
		{
			if (_leftAlign)
			{
				_textField.hAlign = HAlign.LEFT;
				_textField.x = _view.width + 5;
			}
			else
			{
				_textField.hAlign = HAlign.RIGHT;
				_textField.x = -(_textField.width + 5);
			}

			_textField.y = (_view.height - _textField.height) / 2;
		}
	}
}
