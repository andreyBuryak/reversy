/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.gui.popups
{
	import com.reversy.gui.*;
	public interface IPopup extends IView
	{
		function show():void;
		function hide():void;
		function activate():void;
		function deactivate():void;
	}
}
