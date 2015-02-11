/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.controller
{
	import com.reversy.common.AObservable;
	import com.reversy.common.IObservable;
	import com.reversy.common.IObserver;
	import com.reversy.dataModels.PotentialCell;
	import com.reversy.dataModels.Score;
	import com.reversy.game.GameEngine;

	public class GameController extends AObservable implements IObservable, IObserver
	{
		private static var _instance:GameController;

		private var _model:GameEngine;

		public function GameController(model:GameEngine)
		{
			super();

			if (_instance != null)
			{
				throw new Error("[ERROR] GameController | Singleton");
			}

			_model = model;
		}

		//region public methods
		public function update():void
		{
			notifyObservers();
		}

		public function startGame():void {_model.startGame();}

		public function stopGame():void {_model.stopGame();}

		public function undo():void
		{
			if (_model.gameStarted)
			{
				_model.undo();
			}
		}

		public function userAction(cellId:int):void
		{
			if (_model.gameState.field.length > cellId)
			{
				_model.userAction(cellId);
			}
		}
		//endregion

		//region getters and setters
		public function get field():Vector.<int> {return _model.gameState.field;}

		public function get fieldSize():uint {return _model.fieldSize;}

		public function get validCells():Vector.<PotentialCell> {return _model.validCells;}

		public function get whitesTurn():Boolean {return _model.gameState.whitesTurn;}

		public function get playerIsWhite():Boolean {return _model.gameState.playerIsWhite;}
		public function set playerIsWhite(value:Boolean):void
		{
			if (!_model.gameStarted)
			{
				_model.gameState.playerIsWhite = value;
				update();
			}
		}

		public function get score():Score {return _model.score;}

		public function get gameStarted():Boolean {return _model.gameStarted;}

		public function get isAllowPlayerAction():Boolean
		{
			return (_model.gameStarted && _model.isPlayerTurn);
		}

		public function get isUndoAllowed():Boolean {return _model.isUndoAllowed;}
		//endregion
	}
}
