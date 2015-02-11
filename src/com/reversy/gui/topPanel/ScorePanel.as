/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.gui.topPanel
{
	import com.reversy.utils.Assets;
	import com.reversy.utils.GuiUtil;
	import com.reversy.utils.StringUtil;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class ScorePanel extends Sprite
	{
		private var _scoreTF:TextField;
		private var _background:Image;

		public function ScorePanel()
		{
			super();

			_background = new Image(Assets.getTexture(Assets.SCORE_PANEL_BG_TEXTURE_NAME, Assets.ATLAS_TEXTURES_NAME));
			_scoreTF = GuiUtil.createTextField(GuiUtil.TF_SCORE_STYLE);
			_scoreTF.hAlign = HAlign.CENTER;
			_scoreTF.vAlign = VAlign.CENTER;
			_scoreTF.width = _background.width;
			_scoreTF.height = _background.height * 0.75;

			updateScore(0, 0);

			addChild(_background);
			addChild(_scoreTF);
		}

		public function updateScore(scoreWhite:int, scoreBlack:int):void
		{
			_scoreTF.text = StringUtil.formatIntToStr(scoreWhite) + ":" + StringUtil.formatIntToStr(scoreBlack);
		}
	}
}
