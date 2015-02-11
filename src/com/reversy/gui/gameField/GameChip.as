/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.gui.gameField
{
	import com.reversy.utils.Assets;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;

	public class GameChip extends Sprite
	{
		private static const OVERLAP_DURATION:Number = 0.6;

		private var _isWhite:Boolean;
		private var _view:Image;

		public function GameChip(isWhite:Boolean)
		{
			_isWhite = isWhite;

			updateView();
		}

		public function set isWhite(value:Boolean):void
		{
			if (value != _isWhite)
			{
				_isWhite = value;
				updateView();
			}
		}

		override public function dispose():void
		{
			if (_view != null)
			{
				removeChild(_view);
				_view = null;
			}

			if (parent != null)
			{
				parent.removeChild(this);
			}

			super.dispose();
		}

		private function updateView():void
		{
			if (_view != null)
			{
				var oldView:Image = _view;
				Starling.juggler.tween(oldView, OVERLAP_DURATION, {alpha:0, onComplete:removeChild, onCompleteArgs:[oldView, true]});
			}

			var textureName:String = _isWhite ? Assets.CHIP_WHITE_TEXTURE_NAME : Assets.CHIP_BLACK_TEXTURE_NAME;
			_view = new Image(Assets.getTexture(textureName, Assets.ATLAS_TEXTURES_NAME));
			_view.x = - (_view.width >> 1);
			_view.y = - (_view.height >> 1);
			addChildAt(_view, 0);
		}
	}
}
