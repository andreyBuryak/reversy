/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.gui
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class GameField extends Sprite implements IView
	{
		private var _fieldSize:uint = 8;
		private var _cellSize:Number = 70;

		public function GameField()
		{
			super();

			init();
		}

		public function init():void
		{
			drawCells();

			update();
		}

		public function resize():void
		{

		}

		private function drawCells():void
		{
			var i:int, j:int;

			removeChildren();

			for (i = 0; i < _fieldSize; i++)
			{
				for (j = 0; j < _fieldSize; j++)
				{
					var cell:Sprite = new CellMc();
					cell.width = cell.height = _cellSize;
					cell.x = j * _cellSize;
					cell.y = i * _cellSize;

					addChild(cell);
					setChip(j, i, Math.random() > 0.45);
				}
			}

			var frame:Sprite = new FieldFrameMc();
			frame.scale9Grid = new Rectangle(3, 3, frame.width - 6, frame.height - 6);
			frame.width = this.width + 7;
			frame.height = this.height + 7;

			frame.x = -4;
			frame.y = -4;
			addChild(frame);
		}

		private function setChip(posX:int, posY:int, white:Boolean):void
		{
			var chip:Sprite = white ? new ChipWhiteMc() : new ChipBlackMc();
			chip.width = chip.height = _cellSize * 0.8;
			chip.x = (posX * _cellSize) + (_cellSize >> 1);
			chip.y = (posY * _cellSize) + (_cellSize >> 1);

			addChild(chip);
		}

		public function update():void
		{
		}

		public function updateLanguage():void
		{

		}

		public function updateColor():void
		{

		}
	}
}
