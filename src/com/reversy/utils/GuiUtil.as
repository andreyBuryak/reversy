/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.utils
{
	import flash.text.TextField;

	import starling.display.Button;
	import starling.text.TextField;

	public class GuiUtil
	{
		public static const TF_BUTTON_CAPTION_STYLE:String = "buttonTF";
		public static const TF_TOP_PANEL_STYLE:String = "chipContainerTF";
		public static const TF_SCORE_STYLE:String = "scoreTF";
		public static const TF_POPUP_CAPTION_STYLE:String = "popupCaptionTF";

		private static var _tfExample:TextFieldExamplesMc = new TextFieldExamplesMc();

		public static function createButton(textureNamePrefix:String, caption:String = ""):Button
		{
			var button:Button = new Button(Assets.getTexture(textureNamePrefix + 0, Assets.ATLAS_BUTTONS_NAME), caption);

			button.overState = Assets.getTexture(textureNamePrefix + 1, Assets.ATLAS_BUTTONS_NAME);
			button.downState = Assets.getTexture(textureNamePrefix + 2, Assets.ATLAS_BUTTONS_NAME);

			button.scaleWhenDown = 1;

			button.fontName = getStyledTF(TF_BUTTON_CAPTION_STYLE).defaultTextFormat.font;
			button.fontColor = uint(getStyledTF(TF_BUTTON_CAPTION_STYLE).defaultTextFormat.color);
			button.fontSize = Number(getStyledTF(TF_BUTTON_CAPTION_STYLE).defaultTextFormat.size);

			button.useHandCursor = false;

			return button;
		}

		public static function createTextField(style:String, text:String = ""):starling.text.TextField
		{
			var textField:starling.text.TextField = new starling.text.TextField(
					getStyledTF(style).width,
					getStyledTF(style).height,
					text,
					getStyledTF(style).defaultTextFormat.font,
					Number(getStyledTF(style).defaultTextFormat.size),
					uint(getStyledTF(style).defaultTextFormat.color),
					true
			);

			return textField;
		}

		private static function getStyledTF(style:String):flash.text.TextField
		{
			if (_tfExample[style] as flash.text.TextField != null)
			{
				return _tfExample[style];
			}
			else
			{
				return new flash.text.TextField();
			}
		}
	}
}
