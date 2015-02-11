/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.game
{
	import com.reversy.common.AObservable;
	import com.reversy.dataModels.GameState;
	import com.reversy.common.IObservable;
	import com.reversy.dataModels.PotentialCell;
	import com.reversy.dataModels.Score;

	public class GameEngine extends AObservable implements IObservable
	{
		private static var _instance:GameEngine;

		private var _gameState:GameState;
		private var _validCells:Vector.<PotentialCell>;
		private var _history:Vector.<GameState>;
		private var _fieldSize:uint = 8;
		private var _score:Score;
		private var _gameStarted:Boolean = false;
		private var _skipCount:int;

		public function GameEngine()
		{
			super();

			if (_instance != null)
			{
				throw new Error("[ERROR] GameEngine | Singleton");
			}

			initGame();
		}

		//region public methods
		override public function notifyObservers():void
		{
			updateScore();
			super.notifyObservers();
		}

		public function startGame():void
		{
			initGame();
			setStartChips();

			validateField();

			_gameStarted = true;

			notifyObservers();
		}

		public function stopGame():void
		{
			_gameStarted = false;
			notifyObservers();
		}

		public function undo():void
		{
			if (_gameStarted && _history.length > 0)
			{
				_gameState = _history.pop().clone();
				validateField();
				notifyObservers();
			}
		}

		public function userAction(cellIndex:uint):void
		{
			if (_gameState.field[cellIndex] <= GameState.CELL_FREE || _validCells.length == 0)
			{
				if (_validCells.length == 0)
				{
					if (++_skipCount > 2)
					{
						_gameStarted = false;
					}

					_gameState.whitesTurn = !_gameState.whitesTurn;
				}
				else
				{
					var chosenValidCellIndex:int = LogicHelper.getTurnIndexByCellIndex(_validCells, cellIndex);

					_skipCount = 0;

					if (chosenValidCellIndex != -1)
					{
						var overlappingCells:Vector.<int> = LogicHelper.calculateOverlappingCells(
								cellIndex,
								_gameState.whitesTurn,
								_gameState.field,
								_fieldSize
						);

						if (overlappingCells.length > 0)
						{
							if (isPlayerTurn)
							{
								_history.push(_gameState.clone());
							}

							var ownCellType:int = _gameState.whitesTurn ? GameState.CELL_WHITE : GameState.CELL_BLACK;
							_gameState.field[cellIndex] = ownCellType;

							LogicHelper.overlapCells(_gameState.field, ownCellType, overlappingCells);

							_gameState.whitesTurn = !_gameState.whitesTurn;
						}
					}
				}

				validateField();
				notifyObservers();
			}
		}
		//endregion

		//region getters and setters
		public function get gameState():GameState {return _gameState;}

		public function get validCells():Vector.<PotentialCell> {return _validCells;}

		public function get fieldSize():uint {return _fieldSize;}

		public function get score():Score {return _score;}

		public function get gameStarted():Boolean {return _gameStarted;}

		public function get isPlayerTurn():Boolean {return _gameState.whitesTurn == _gameState.playerIsWhite;}

		public function get isUndoAllowed():Boolean
		{
			return (_history.length > 0 && isPlayerTurn);
		}
		//endregion

		//region private methods
		private function initGame():void
		{
			var playerIsWhite:Boolean = false;
			if (_gameState != null)
			{
				playerIsWhite = _gameState.playerIsWhite;
			}

			_gameState = new GameState(getNewField(), false, playerIsWhite);
			_score = new Score();
			_skipCount = 0;

			if (_history == null)
			{
				_history = new Vector.<GameState>();
			}
			_history.length = 0;

			_validCells = new Vector.<PotentialCell>();
		}

		private function getNewField():Vector.<int>
		{
			var cellsCount:int = _fieldSize * _fieldSize;
			var field:Vector.<int> = new Vector.<int>(cellsCount);
			var i:int, j:int;
			for (i = 0; i < cellsCount; i++)
			{
				field[i] = GameState.CELL_FREE;
			}
			return field;
		}

		private function setStartChips():void
		{
			if (_gameState != null && (_gameState.field.length == _fieldSize * _fieldSize))
			{
				var halfSize:int = _fieldSize >> 1;
				var middleRow1Displacement:int = _fieldSize * (halfSize - 1);
				var middleRow2Displacement:int = _fieldSize * halfSize;

				_gameState.field[middleRow1Displacement + (halfSize - 1)] = GameState.CELL_WHITE;
				_gameState.field[middleRow1Displacement + halfSize] = GameState.CELL_BLACK;
				_gameState.field[middleRow2Displacement + (halfSize - 1)] = GameState.CELL_BLACK;
				_gameState.field[middleRow2Displacement + halfSize] = GameState.CELL_WHITE;
			}
		}

		private function updateScore():void
		{
			if (_score == null)
			{
				_score = new Score();
			}
			else
			{
				_score.scoreWhite = 0;
				_score.scoreBlack = 0;
			}

			if (_gameState != null && _gameState.field != null)
			{
				for (var i:int = 0; i < _gameState.field.length; i++)
				{
					if (_gameState.field[i] != GameState.CELL_FREE)
					{
						switch (_gameState.field[i])
						{
							case GameState.CELL_WHITE:
								_score.scoreWhite++;
								break;
							case GameState.CELL_BLACK:
								_score.scoreBlack++;
								break;
						}
					}
				}
			}

			if (_gameStarted && (_score.scoreWhite == 0 || _score.scoreBlack == 0))
			{
				stopGame();
			}
		}

		private function validateField():void
		{
			_validCells = LogicHelper.getValidTurns(_gameState.field, _fieldSize, _gameState.whitesTurn);

			var freeCellsCount:int = 0;

			for (var i:int = 0; i < _gameState.field.length; i++)
			{
				if (_gameState.field[i] <= GameState.CELL_FREE)
				{
					freeCellsCount++;
					_gameState.field[i] = LogicHelper.getTurnIndexByCellIndex(_validCells, i) == -1 ?
							GameState.CELL_UNALLOWED :
							GameState.CELL_FREE;
				}
			}

			if (freeCellsCount == 0)
			{
				_gameStarted = false;
			}
		}
		//endregion
	}
}
