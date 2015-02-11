/**
 * Created by a.buryak on 10.02.15.
 */
package com.reversy.game
{
	import com.reversy.dataModels.GameState;
	import com.reversy.dataModels.PotentialCell;

	public class LogicHelper
	{
		public static function getTurnIndexByCellIndex(turnsVector:Vector.<PotentialCell>, cellIndex:int):int
		{
			if (turnsVector != null)
			{
				for (var i:int = 0; i < turnsVector.length; i++)
				{
					if (turnsVector[i].cellIndex == cellIndex)
					{
						return i;
					}
				}
			}

			return -1;
		}

		public static function getValidTurns(field:Vector.<int>, fieldSize:int, isWhitesTurn:Boolean):Vector.<PotentialCell>
		{
			var validCells:Vector.<PotentialCell> = new Vector.<PotentialCell>();

			if (field != null)
			{
				for (var i:int = 0; i < field.length; i++)
				{
					if (field[i] <= GameState.CELL_FREE)
					{
						var cellPotential:int = calculateOverlappingCells(i,
						                                                  isWhitesTurn,
						                                                  field,
						                                                  fieldSize).length;

						if (cellPotential > 0)
						{
							validCells.push(new PotentialCell(i, cellPotential));
						}
					}
				}
			}

			return validCells;
		}

		public static function overlapCells(field:Vector.<int>, ownCellType:int, overlappingCells:Vector.<int>):void
		{
			for (var i:int = 0; i < overlappingCells.length; i++)
			{
				field[overlappingCells[i]] = ownCellType;
			}
		}

		public static function calculateOverlappingCells(cellIndex:uint,
		                                           isWhitesTurn:Boolean,
		                                           field:Vector.<int>,
		                                           fieldSize:int):Vector.<int>
		{
			var result:Vector.<int> = new Vector.<int>();
			var ownCellType:int, enemyCellType:int;

			if (isWhitesTurn)
			{
				ownCellType = GameState.CELL_WHITE;
				enemyCellType = GameState.CELL_BLACK;
			}
			else
			{
				ownCellType = GameState.CELL_BLACK;
				enemyCellType = GameState.CELL_WHITE;
			}

			var serviceField:Vector.<int> = getServiceField(field, fieldSize);

			var serviceCellIndex:int = convertCellIndex(cellIndex, fieldSize, fieldSize + 2);

			var displacements:Vector.<int> = getEnemyDisplacements(serviceField,
			                                                       fieldSize + 2,
			                                                       serviceCellIndex,
			                                                       enemyCellType);

			var nearbyCellId:int;
			for (var i:int = 0; i < displacements.length; i++)
			{
				var overlappingCells:Vector.<int> = new Vector.<int>();
				for (var j:int = 1; j < fieldSize; j++)
				{
					nearbyCellId = serviceCellIndex + (displacements[i] * j);
					if (nearbyCellId >= 0 && nearbyCellId < serviceField.length)
					{
						if (serviceField[nearbyCellId] == ownCellType)
						{
							result = result.concat(overlappingCells);
							break;
						}
						else if (serviceField[nearbyCellId] == enemyCellType)
						{
							overlappingCells.push(convertCellIndex(nearbyCellId, fieldSize + 2, fieldSize));
						}
						else
						{
							break;
						}
					}
					else
					{
						break;
					}
				}
			}

			return result;
		}

		private static function getEnemyDisplacements(field:Vector.<int>,
		                                              fieldSize:int,
		                                              cellIndex:uint,
		                                              enemyCellType:int):Vector.<int>
		{
			var displacements:Vector.<int> = new Vector.<int>();

			for (var i:int = 0; i < 8; i++)
			{
				var displacement:int = getDisplacement(i, fieldSize);
				var nearbyCellId:int = cellIndex + displacement;
				if (nearbyCellId >= 0 && nearbyCellId < field.length)
				{
					if (field[nearbyCellId] == enemyCellType)
					{
						displacements.push(displacement);
					}
				}
			}

			return displacements;
		}

		private static function getDisplacement(destination:int, fieldSize:int):int
		{
			switch (destination)
			{
				case 0: return (-fieldSize - 1);
				case 1: return (-fieldSize);
				case 2: return (1 - fieldSize);
				case 3: return (-1);
				case 4: return 1;
				case 5: return (fieldSize - 1);
				case 6: return fieldSize;
				case 7: return (fieldSize + 1);
				default: return 0;
			}
		}

		private static function getServiceField(realField:Vector.<int>, realFieldSize:int):Vector.<int>
		{
			var serviceField:Vector.<int> = new Vector.<int>();
			var i:int;

			for (i = 0; i < (realFieldSize + 2); i++)
			{
				serviceField.push(GameState.CELL_UNALLOWED);
			}

			for (i = 0; i < realFieldSize; i++)
			{
				serviceField.push(GameState.CELL_UNALLOWED);
				serviceField = serviceField.concat(realField.slice(i * realFieldSize, (i + 1) * realFieldSize));
				serviceField.push(GameState.CELL_UNALLOWED);
			}

			for (i = 0; i < (realFieldSize + 2); i++)
			{
				serviceField.push(GameState.CELL_UNALLOWED);
			}

			return serviceField;
		}

		private static function convertCellIndex(oldIndex:int, oldFieldSize:int, newFieldSize:int):int
		{
			var half:int = (newFieldSize - oldFieldSize) / 2;
			var newX:int = (oldIndex % oldFieldSize) + half;
			var newY:int = int(oldIndex / oldFieldSize) + half;
			var newIndex:int = newX + (newY * newFieldSize);
			return newIndex;
		}
	}
}
