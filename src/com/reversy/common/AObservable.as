/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.common
{
	public class AObservable implements IObservable
	{
		protected var _observers:Vector.<IObserver>;

		public function AObservable()
		{
			_observers = new Vector.<IObserver>();
		}

		public function addObserver(observer:IObserver):void
		{
			var index:int = _observers.indexOf(observer);
			if (index == -1)
			{
				_observers.push(observer);
			}
		}

		public function removeObserver(observer:IObserver):void
		{
			var index:int = _observers.indexOf(observer);
			if (index != -1)
			{
				_observers.splice(index, 1);
			}
		}

		public function notifyObservers():void
		{
			for each (var observer:IObserver in _observers)
			{
				observer.update();
			}
		}
	}
}
