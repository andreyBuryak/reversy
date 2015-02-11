/**
 * Created by a.buryak on 10.02.15.
 */
package com.reversy.game
{
	import com.reversy.common.IObserver;
	import com.reversy.controller.GameController;
	import com.reversy.dataModels.PotentialCell;

	import starling.core.Starling;

	public class BotAI implements IObserver
	{
		private static const BOT_TURN_DELAY:Number = 1.5;
		private static const BOT_MIN_DELAY:Number = 0.3;

		private var _controller:GameController;
		private var _gameStarted:Boolean = false;

		public function BotAI(controller:GameController)
		{
			_controller = controller;
		}

		public function update():void
		{
			if (_controller.gameStarted && (_controller.whitesTurn != _controller.playerIsWhite))
			{
				var cellIndex:int = getTurnCellIndex(_controller.validCells, _controller.fieldSize);
				if (cellIndex == -1)
				{
					Starling.juggler.delayCall(makeTurn, BOT_MIN_DELAY);
				}
				else
				{
					Starling.juggler.delayCall(makeTurn, BOT_TURN_DELAY, [cellIndex]);
				}
			}

			_gameStarted = _controller.gameStarted;
		}

		private function getTurnCellIndex(validCells:Vector.<PotentialCell>, fieldSize:int):int
		{
			var maxPotential:int = -1;
			var maxPotentialIndex:int = -1;

			if (validCells != null && validCells.length > 0)
			{
				for (var i:int = 0; i < validCells.length; i++)
				{
					var cellIndex:int = validCells[i].cellIndex;
					var cellX:int = cellIndex % fieldSize;
					var cellY:int = int(cellIndex / fieldSize);
					var corner:int = fieldSize - 1;

					if (cellX == 0 || cellX == corner || cellY == 0 || cellY == corner)
					{
						validCells[i].potential += 20;
					}

					if ((cellX == 0 || cellX == corner) && (cellY == 0 || cellY == corner))
					{
						validCells[i].potential += 50;
					}

					if (validCells[i].potential > maxPotential)
					{
						maxPotential = validCells[i].potential;
						maxPotentialIndex = cellIndex;
					}
				}
			}

			return maxPotentialIndex;
		}

		private function makeTurn(cellIndex:int = 0):void
		{
			_controller.userAction(cellIndex);
		}
	}
}
