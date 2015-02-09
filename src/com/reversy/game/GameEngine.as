/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.game
{
	import com.reversy.common.AObservable;
	import com.reversy.common.GameState;
	import com.reversy.common.IObservable;

	public class GameEngine extends AObservable implements IObservable
	{
		private static var _instance:GameEngine;

		private var _gameState:GameState;
		private var _fieldSize:int = 8;

		public function GameEngine()
		{
			super();

			if (_instance != null)
			{
				throw new Error("[ERROR] Engine | Singleton");
			}
		}

		//region static methods
		public static function get instance():GameEngine
		{
			if (_instance == null)
			{
				_instance = new GameEngine();
			}

			return _instance;
		}
		//endregion

		//region public methods
		public function initGame():void
		{
			_gameState = new GameState(_fieldSize, getNewField(_fieldSize), false);
		}
		//endregion

		//region private methods
		private function getNewField(fieldSize:uint):Vector.<int>
		{
			var cellsCount:int = _fieldSize * _fieldSize;
			var field:Vector.<int> = new Vector.<int>(cellsCount);
			var i:int, j:int;
			for (i = 0; i < cellsCount; i++)
			{
				field[i] = GameState.FREE_CELL;
			}

			var halfSize:int = fieldSize >> 1;
			var middleRow1Displacement:int = _fieldSize * (halfSize - 1);
			var middleRow2Displacement:int = _fieldSize * halfSize;

			field[middleRow1Displacement + (halfSize - 1)] = GameState.WHITE_CELL;
			field[middleRow1Displacement + halfSize] = GameState.BLACK_CELL;
			field[middleRow2Displacement + (halfSize - 1)] = GameState.BLACK_CELL;
			field[middleRow2Displacement + halfSize] = GameState.WHITE_CELL;

			return field;
		}
		//endregion
	}
}
