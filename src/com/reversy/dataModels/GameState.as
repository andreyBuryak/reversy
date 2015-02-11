/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.dataModels
{
	public class GameState
	{
		public static const CELL_UNALLOWED:int = -1;
		public static const CELL_FREE:int = 0;
		public static const CELL_WHITE:int = 1;
		public static const CELL_BLACK:int = 2;

		private var _field:Vector.<int>;
		private var _whitesTurn:Boolean;
		private var _playerIsWhite:Boolean;

		public function GameState(field:Vector.<int> = null, whitesTurn:Boolean = false, playerIsWhite:Boolean = false)
		{
			_field = field;
			_whitesTurn = whitesTurn;
			_playerIsWhite = playerIsWhite;
		}

		public function clone():GameState
		{
			var fieldClone:Vector.<int>;
			if (_field != null)
			{
				fieldClone = _field.concat();
			}

			return new GameState(fieldClone, _whitesTurn, _playerIsWhite);
		}

		public function get field():Vector.<int> {return _field;}
		public function set field(value:Vector.<int>):void {_field = value;}

		public function get whitesTurn():Boolean {return _whitesTurn;}
		public function set whitesTurn(value:Boolean):void {_whitesTurn = value;}

		public function get playerIsWhite():Boolean {return _playerIsWhite;}
		public function set playerIsWhite(value:Boolean):void {_playerIsWhite = value;}
	}
}
