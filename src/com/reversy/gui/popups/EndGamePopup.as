/**
 * Created by a.buryak on 11.02.15.
 */
package com.reversy.gui.popups
{
	import com.reversy.controller.GameController;
	import com.reversy.dataModels.Score;
	import com.reversy.utils.GuiUtil;
	import com.reversy.utils.LocaleUtil;
	import com.reversy.utils.StringUtil;

	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class EndGamePopup extends APopup
	{
		private static const CAPTION_WIN_LOC:String = "popups.endGamePopup.captionWin";
		private static const CAPTION_LOSE_LOC:String = "popups.endGamePopup.captionLose";
		private static const CAPTION_DEAD_HEAT_LOC:String = "popups.endGamePopup.captionDeadHeat";

		private var _scoreTF:TextField;

		public function EndGamePopup(controller:GameController)
		{
			super(controller);
		}

		override public function init():void
		{
			super.init();

			_scoreTF = GuiUtil.createTextField(GuiUtil.TF_SCORE_STYLE);
			_scoreTF.hAlign = HAlign.CENTER;
			_scoreTF.vAlign = VAlign.CENTER;
			_scoreTF.width = _background.width;
			_scoreTF.height = _background.height >> 1;
			_scoreTF.x = 0;
			_scoreTF.y = _background.height >> 2;

			addChild(_scoreTF);
		}

		override public function updateLanguage():void
		{
			var score:Score = _controller.score;

			if (score.scoreWhite == score.scoreBlack)
			{
				_captionTF.text = LocaleUtil.getPhrase(CAPTION_DEAD_HEAT_LOC);
			}
			else
			{
				if (_controller.playerIsWhite == (score.scoreWhite > score.scoreBlack))
				{
					_captionTF.text = LocaleUtil.getPhrase(CAPTION_WIN_LOC);
				}
				else
				{
					_captionTF.text = LocaleUtil.getPhrase(CAPTION_LOSE_LOC);
				}
			}

			_scoreTF.text = StringUtil.formatIntToStr(score.scoreWhite) + ":" + StringUtil.formatIntToStr(score.scoreBlack);

			super.updateLanguage();
		}
	}
}
