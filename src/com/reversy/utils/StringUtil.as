/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.utils
{
	public class StringUtil
	{
		public static function formatIntToStr(intValue:int, length:uint = 2):String
		{
			var isNegativeInt:Boolean = intValue < 0;
			var res:String = int(Math.abs(intValue)).toString();

			while (res.length < length)
			{
				res = "0" + res;
			}

			if (isNegativeInt)
			{
				res = "-" + res;
			}

			return res;
		}
	}
}
