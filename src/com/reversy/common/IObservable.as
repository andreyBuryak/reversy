/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.common
{
	public interface IObservable
	{
		function addObserver(observer:IObserver):void;
		function removeObserver(observer:IObserver):void;
		function notifyObservers():void;
	}
}
