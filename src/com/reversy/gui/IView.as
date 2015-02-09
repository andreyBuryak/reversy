/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.gui
{
	import com.reversy.common.IObserver;

	public interface IView extends IObserver
	{
		function init():void;
		function resize():void;
		function updateLanguage():void;
		function updateColor():void;
	}
}
