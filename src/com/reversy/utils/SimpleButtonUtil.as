/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.text.TextField;

	public class SimpleButtonUtil
	{
		public static function setButtonCaption(button:SimpleButton, caption:String):void
		{
			if (button != null)
			{
				if (caption == null)
				{
					caption = "";
				}

				setStateCaption(button.upState as DisplayObjectContainer, caption);
				setStateCaption(button.overState as DisplayObjectContainer, caption);
				setStateCaption(button.downState as DisplayObjectContainer, caption);
				setStateCaption(button.hitTestState as DisplayObjectContainer, caption);
			}
		}

		private static function setStateCaption(container:DisplayObjectContainer, caption:String):void
		{
			if (container != null && caption != null)
			{
				for (var i:int = 0; i < container.numChildren; i++)
				{
					var tf:TextField = container.getChildAt(i) as TextField;
					if (tf != null)
					{
						tf.text = caption;
						break;
					}
				}
			}
		}
	}
}
