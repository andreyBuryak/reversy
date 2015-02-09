/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.controller
{
	import com.reversy.common.AObservable;
	import com.reversy.common.IObservable;
	import com.reversy.common.IObserver;

	public class GameController extends AObservable implements IObservable, IObserver
	{
		private static var _instance:GameController;

		public function GameController()
		{
			super();

			if (_instance != null)
			{
				throw new Error("[ERROR] GameController | Singleton");
			}
		}

		//region static methods
		public static function get instance():GameController
		{
			if (_instance == null)
			{
				_instance = new GameController();
			}

			return _instance;
		}
		//endregion

		//region public methods
		public function update():void
		{
			notifyObservers();
		}
		//endregion
	}
}
