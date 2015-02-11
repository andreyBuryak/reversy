/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.gui.gameField
{
	import com.reversy.dataModels.GameState;
	import com.reversy.gui.*;
	import com.reversy.controller.GameController;
	import com.reversy.utils.Assets;

	import flash.geom.Point;

	import starling.core.Starling;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class GameField extends Sprite implements IView
	{
		private var _controller:GameController;

		private var _fieldSize:uint = 0;
		private var _cellSize:Number = 60;
		private var _lastCellIndex:int = -1;

		private var _width:Number = 0;

		private var _cells:Vector.<Image>;
		private var _chips:Vector.<GameChip>;

		private var _fieldColor:int = 16777215;

		public function GameField(controller:GameController)
		{
			super();

			_controller = controller;

			init();
		}

		//region public methods
		public function init():void
		{
			_lastCellIndex = -1;

			clearChips();
			update();
		}

		public function resize():void
		{

		}

		public function update():void
		{
			var modelFieldSize:uint = _controller.fieldSize;

			if (_fieldSize != modelFieldSize)
			{
				_fieldSize = modelFieldSize;

				clearChips();
				_chips.length = _fieldSize * _fieldSize;

				initBoard();
			}

			updateChips(_controller.field);

			updateHintLighting(_controller.field);

			if (_controller.isAllowPlayerAction)
			{
				addEventListener(TouchEvent.TOUCH, actionHandler);
			}
			else
			{
				removeEventListener(TouchEvent.TOUCH, actionHandler);
			}
		}

		private function updateHintLighting(field:Vector.<int>):void
		{
			if (_lastCellIndex != -1 && field[_lastCellIndex] == GameState.CELL_UNALLOWED)
			{
				var cell:Image = _cells[_lastCellIndex];
				cell.color = 0xFF0000;
				Starling.juggler.delayCall(cellGlowOff, 0.5, cell);
				_lastCellIndex == -1;
			}
		}

		public function updateLanguage():void
		{

		}

		public function updateColor():void
		{

		}

		override public function get width():Number {return _width;}

		override public function get height():Number {return _width;}
		//endregion

		//region private metods
		private function initBoard():void
		{
			var i:int;

			if (_cells == null)
			{
				_cells = new Vector.<Image>();
			}
			else
			{
				for (i = 0; i < _cells.length; i++)
				{
					removeChild(_cells[i], true);
					_cells[i] = null;
				}
				_cells.length = 0;
			}

			var cellsCount:int = _fieldSize * _fieldSize;

			for (i = 0; i < cellsCount; i++)
			{
				var cell:Image = new Image(Assets.getTexture(Assets.CELL_TEXTURE_NAME, Assets.ATLAS_TEXTURES_NAME));
				cell.width = cell.height = _cellSize;
				cell.x = (i % _fieldSize) * _cellSize;
				cell.y = int(i / _fieldSize) * _cellSize;

				addChild(cell);
				_cells.push(cell);
			}

			_width = _fieldSize * _cellSize;
		}

		private function clearChips():void
		{
			if (_chips != null && _chips.length > 0)
			{
				for (var i:int = 0; i < _chips.length; i++)
				{
					if (_chips[i] != null)
					{
						_chips[i].dispose();
						_chips[i] = null;
					}
				}
			}

			if (_chips == null)
			{
				_chips = new Vector.<GameChip>();
			}
		}

		private function updateChips(field:Vector.<int>):void
		{
			if (field != null)
			{
				var cellsCount:int = _fieldSize * _fieldSize;

				if (_chips.length == cellsCount && field.length == cellsCount)
				{
					for (var i:int = 0; i < cellsCount; i++)
					{
						var chip:GameChip = _chips[i];

						if (field[i] == GameState.CELL_FREE || field[i] == GameState.CELL_UNALLOWED)
						{
							if (chip != null)
							{
								chip.dispose();
								chip = null;
								if (_chips[i] != null)
								{
									_chips[i].dispose();
									_chips[i] = null;
								}
							}
						}
						else
						{
							var isWhite:Boolean = field[i] == GameState.CELL_WHITE;
							if (_chips[i] != null)
							{
								_chips[i].isWhite = isWhite;
							}
							else
							{
								chip = new GameChip(isWhite);
								chip.width = chip.height = _cellSize * 0.85;
								chip.x = ((i % _fieldSize) * _cellSize) + (_cellSize >> 1);
								chip.y = (int(i / _fieldSize) * _cellSize) + (_cellSize >> 1);
								addChild(chip);
								_chips[i] = chip;
							}
						}
					}
				}
				else
				{
					throw new Error("[ERROR] GameField | updateChips | Vectors length are invalid");
				}
			}
			else
			{
				clearChips();
			}
		}

		private function actionHandler(event:TouchEvent):void
		{
			var touch:Touch = event.touches[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				var p:Point = globalToLocal(new Point(touch.globalX, touch.globalY));
				var posX:int = p.x / _cellSize;
				var posY:int = p.y / _cellSize;

				if (posX < _fieldSize && posY < _fieldSize)
				{
					var index:int = posX + int(posY * _fieldSize);
					_lastCellIndex = index;
					_controller.userAction(index);
				}
			}
		}

		private function cellGlowOff(cell:Image):void
		{
			if (cell != null)
			{
				cell.color = _fieldColor;
			}
		}
		//endregion
	}
}
