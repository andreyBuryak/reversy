/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.common
{
	public class GameState
	{
		public static const FREE_CELL:uint = 0;
		public static const WHITE_CELL:uint = 1;
		public static const BLACK_CELL:uint = 2;

		private var _fieldSize:uint;
		private var _field:Vector.<int>;
		private var _whitesTurn:Boolean;

		public function GameState(fieldSize:uint = 8, field:Vector.<int> = null, whitesTurn:Boolean = false)
		{
			_fieldSize = Math.min(8, (fieldSize >> 1) << 1);
			_field = field;
			_whitesTurn = whitesTurn;
		}

		public function get field():Vector.<int> {return _field;}
		public function set field(value:Vector.<int>):void {_field = value;}

		public function get whitesTurn():Boolean {return _whitesTurn;}
		public function set whitesTurn(value:Boolean):void {_whitesTurn = value;}
	}
}
