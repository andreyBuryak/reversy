/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.gui.topPanel
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class ChipContainer extends Sprite
	{
		private var _view:ChipContainerMc;
		private var _icon:DisplayObject;
		private var _leftAlign:Boolean = true;

		public function ChipContainer()
		{
			super();

			_view = new ChipContainerMc;

			_view.textTF.mouseEnabled = false;
			_view.textTF.autoSize = TextFieldAutoSize.LEFT;
			updateTextFieldAlign();

			addChild(_view);
		}

		override public function get width():Number {return _view.chipPlaceholder.width;}

		override public function get height():Number {return _view.chipPlaceholder.height;}

		public function set text(value:String):void
		{
			if (value == null)
			{
				value = "";
			}

			_view.textTF.text = value;

			updateTextFieldAlign();
		}

		public function set icon(value:DisplayObject):void
		{
			if (_icon != null)
			{
				removeChild(_icon);
				_icon == null;
			}

			if (value != null)
			{
				_icon = value;
				_icon.scaleX = _icon.scaleY = (_view.chipPlaceholder.width / _icon.width) * 0.8;
				_icon.x = ((_view.chipPlaceholder.width - _icon.width ) / 2) - (_icon.getRect(_icon).x * _icon.scaleX);
				_icon.y = ((_view.chipPlaceholder.height - _icon.height) / 2) - (_icon.getRect(_icon).y * _icon.scaleY);

				addChild(_icon);
			}
		}

		public function set leftAlign(value:Boolean):void
		{
			_leftAlign = value;

			updateTextFieldAlign();
		}

		private function updateTextFieldAlign():void
		{
			var tf:TextFormat = _view.textTF.defaultTextFormat;
			tf.align = _leftAlign ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT;
			_view.textTF.defaultTextFormat = tf;
			_view.textTF.text = _view.textTF.text;

			if (_leftAlign)
			{
				_view.textTF.x = _view.chipPlaceholder.width + 5;
			}
			else
			{
				_view.textTF.x = -(_view.textTF.width + 5);
			}

			_view.textTF.y = (_view.chipPlaceholder.height - _view.textTF.height) / 2;
		}
	}
}
